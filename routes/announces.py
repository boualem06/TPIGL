from datetime import date

from flask import Blueprint, jsonify, request

from db import connect_to_database
from helpers import auth_required
import uuid
bp = Blueprint('announces', __name__)


@bp.route('/announces', methods=['GET'])
@auth_required
def get_announces(current_user):
    conn = connect_to_database()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM announces")
    rows = cursor.fetchall()

    # converting the query objects to list of jsons
    output = []
    for row in rows:
        # appending the user data json to the response list
        output.append({
            'id': row[0],
            'user_id': row[1],
            'public_id': row[2],
            'type_announcement': row[3],
            'price': row[4],
            'street':row[5],
            'state': row[6],
            'city': row[7],
            'created_at': row[8],
            'area': row[9],
            'rooms': row[10],
            'type_of_property': row[11],
            'description': row[12],
            'dimensions': row[13],
        })
    # Fetch announce images
    cursor.execute("SELECT * FROM images")
    images = cursor.fetchall()
    # Add images to the response
    for announce in output:
        announce['images'] = []
        for image in images:
            if image[1] == announce['id']:
                announce['images'].append(image[2])
    return jsonify({'announces': output})


@bp.route('/announces', methods=['POST'])
@auth_required
def create_announce(current_user):
    user_id = current_user[0]
    public_id = str(uuid.uuid4())
    type_announcement = request.json['type_announcement']
    price = request.json['price']
    street=request.json['street']
    state = request.json['state']
    city = request.json['city']
    created_at = date.today()
    area = request.json['area']
    rooms = request.json['rooms']
    type_of_property = request.json['type_of_property']
    description = request.json['description']
    dimensions = request.json['dimensions']
    conn = connect_to_database()
    cursor = conn.cursor()
    cursor.execute("INSERT INTO announces (user_id, public_id, type_announcement, price, street, state, city, created_at, area, rooms, type_of_property, description, dimensions) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)", (user_id, public_id, type_announcement, price,street, state, city, created_at, area, rooms, type_of_property, description, dimensions))
    conn.commit()
    cursor.close()
    conn.close()
    return jsonify({'message': 'new announcement is added successfully'})


@bp.route('/announces/<announce_id>', methods=['GET'])
@auth_required
def show_announce(current_user, announce_id):
    conn = connect_to_database()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM announces WHERE id = %s", (announce_id,))
    row = cursor.fetchone()
    if not row:
        return jsonify({'message': 'Resource not found'}), 404
    output = []
    output.append({
            'id': row[0],
            'user_id': row[1],
            'public_id': row[2],
            'type_announcement': row[3],
            'price': row[4],
            'street':row[5],
            'state': row[6],
            'city': row[7],
            'created_at': row[8],
            'area': row[9],
            'rooms': row[10],
            'type_of_property': row[11],
            'description': row[12],
            'dimensions': row[13],
            'images': []
    })
    # Fetch announce images
    cursor.execute("SELECT * FROM images")
    images = cursor.fetchall()
    # Add images to the announce
    for image in images:
        if image[1] == output[0]['id']:
            output[0]['images'].append(image[2])
    return jsonify({'announce': output})

@bp.route('/announces/<announce_id>', methods=['PUT'])
@auth_required
def update_announce(current_user, announce_id):
    # check if the user is an admin or the owner of the announce
    conn = connect_to_database()
    cursor = conn.cursor()
    if not current_user[6]:
        # get the announce from the database
        cursor.execute(
            "SELECT user_id FROM announces WHERE id = %s", (announce_id,))
        announce = cursor.fetchone()
        # if the announce doesn't exist or the user is not the owner, return an error
        if not announce or announce[0] != current_user[0]:
            return jsonify({'message': 'You are not authorized to update this announce'}), 401
    # update the announce in the database
    cursor.execute("UPDATE announces SET type_announcement = %s, price = %s,street= %s, state = %s, city = %s, area = %s, rooms = %s, type_of_property = %s, description = %s, dimensions= %s WHERE id = %s",
                   (request.json['type_announcement'], request.json['price'],request.json['street'], request.json['state'], request.json['city'], request.json['area'], request.json['rooms'], request.json['type_of_property'], request.json['description'], request.json['dimensions'], announce_id))
    conn.commit()
    return jsonify({'message': 'Announce has been updated'})


@bp.route('/announces/<announce_id>', methods=['DELETE'])
@auth_required
def delete_announce(current_user, announce_id):
    # check if the user is an admin or the owner of the announce
    conn = connect_to_database()
    cursor = conn.cursor()
    if not current_user[6]:
        # get the announce from the database
        cursor.execute(
            "SELECT user_id FROM announces WHERE id = %s", (announce_id,))
        announce = cursor.fetchone()
        # if the announce doesn't exist or the user is not the owner, return an error
        if not announce or announce[0] != current_user[0]:
            return jsonify({'message': 'You are not authorized to delete this announce'}), 401
    # delete the announce from the database
    cursor.execute("DELETE FROM announces WHERE id = %s", (announce_id,))
    conn.commit()
    return jsonify({'message': 'Announce has been deleted'})


@bp.route('/my-announces', methods=['GET'])
@auth_required
def user_announces(current_user):
    conn = connect_to_database()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM announces WHERE user_id = %s",
                   (current_user[0],))
    rows = cursor.fetchall()
    # converting the query objects to list of jsons
    output = []
    for row in rows:
        # appending the user data json to the response list
        output.append({
            'id': row[0],
            'user_id': row[1],
            'public_id': row[2],
            'type_announcement': row[3],
            'price': row[4],
            'street':row[5],
            'state': row[6],
            'city': row[7],
            'created_at': row[8],
            'area': row[9],
            'rooms': row[10],
            'type_of_property': row[11],
            'description': row[12],
            'dimensions': row[13],
            'images': []
 
        })
        # Fetch announce images
    cursor.execute("SELECT * FROM images")
    images = cursor.fetchall()
    # Add images to the response
    for announce in output:
        announce['images'] = []
        for image in images:
            if image[1] == announce['id']:
                announce['images'].append(image[2])
    return jsonify({'announces': output})


@bp.route('/announces/search', methods=['GET'])
@auth_required
def search(current_user):
    conn = connect_to_database()
    cursor = conn.cursor()
    # get the query parameters
    city = request.args.get('city')
    state = request.args.get('state')
    type_of_property = request.args.get('type_of_property')
    type_announcement = request.args.get('type_announcement')
    min_price = request.args.get('min_price')
    max_price = request.args.get('max_price')
    min_created_at = request.args.get('min_created_at')
    max_created_at = request.args.get('max_created_at')
    description = request.args.get('description')
    # build the query
    query = "SELECT * FROM announces WHERE 1=1"
    values = []
    if city:
        query += " AND city = %s"
        values.append(city)
    if state:
        query += " AND state = %s"
        values.append(state)
    if type_of_property:
        query += " AND type_of_property = %s"
        values.append(type_of_property)
    if type_announcement:
        query += " AND type_announcement = %s"
        values.append(type_announcement)
    if min_price:
        query += " AND price >= %s"
        values.append(min_price)
    if max_price:
        query += " AND price <= %s"
        values.append(max_price)
    if min_created_at:
        query += " AND created_at >= %s"
        values.append(min_created_at)
    if max_created_at:
        query += " AND created_at <= %s"
        values.append(max_created_at)
    if description:
        query += " AND description LIKE %s"
        values.append(f'%{description}%')
    # execute the query
    cursor.execute(query, tuple(values))
    rows = cursor.fetchall()
# converting the query objects to list of jsons
    output = []
    for row in rows:
        # appending the user data json to the response list
        output.append({
            'id': row[0],
            'user_id': row[1],
            'public_id': row[2],
            'type_announcement': row[3],
            'price': row[4],
            'street':row[5],
            'state': row[6],
            'city': row[7],
            'created_at': row[8],
            'area': row[9],
            'rooms': row[10],
            'type_of_property': row[11],
            'description': row[12],
            'dimensions': row[13],
        })
    return jsonify({'announces': output})
