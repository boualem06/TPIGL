from flask import Blueprint, jsonify

from db import connect_to_database
from helpers import auth_required

bp = Blueprint('saved_announces', __name__)


@bp.route('/announces/<announce_id>/togglesave', methods=['POST'])
@auth_required
def save_announce(current_user, announce_id):
    conn = connect_to_database()
    cursor = conn.cursor()
    # check if the announce exists
    cursor.execute("SELECT * FROM announces WHERE id = %s", (announce_id,))
    announce = cursor.fetchone()
    if not announce:
        return jsonify({'message': 'Announce not found'}), 404
    # check if the user already saved the announce
    cursor.execute("SELECT * FROM saved_announces WHERE user_id = %s AND announce_id = %s",
                   (current_user[0], announce_id))
    saved_announce = cursor.fetchone()
    if saved_announce:
        # delete the saved announce
        cursor.execute("DELETE FROM saved_announces WHERE user_id = %s AND announce_id = %s",
                       (current_user[0], announce_id))
        conn.commit()
        return jsonify({'message': 'Announce has been removed from your saved announces'}), 200
    # save the announce
    cursor.execute("INSERT INTO saved_announces (user_id, announce_id) VALUES (%s, %s)",
                   (current_user[0], announce_id))
    conn.commit()
    cursor.execute("SELECT * FROM notifications WHERE user_id = %s AND announce_id = %s AND type = %s",
                   (announce[1], announce_id, 'save'))
    notification = cursor.fetchone()
    if not notification and announce[1] != current_user[0]:
        cursor.execute("INSERT INTO notifications (user_id, announce_id, type) VALUES (%s, %s, %s)",
                       (announce[1], announce_id, 'save'))
        conn.commit()
        return jsonify({'message': 'Announce has been saved'}), 201
    return jsonify({'message': 'Announce has been saved'}), 201


@bp.route('/announces/saved', methods=['GET'])
@auth_required
def get_saved_announces(current_user):
    conn = connect_to_database()
    cursor = conn.cursor()
    # get the saved announces from the database
    cursor.execute(
        "SELECT * FROM saved_announces WHERE user_id = %s", (current_user[0],))
    rows = cursor.fetchall()
    # converting the query objects to list of jsons
    output = []
    for row in rows:
        # appending the user data json to the response list
        output.append({
            'id': row[0],
            'user_id': row[1],
            'announce_id': row[2]
        })
    return jsonify({'saved_announces': output})
