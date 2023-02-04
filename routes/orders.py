from urllib import request
from flask import Blueprint, jsonify
from db import connect_to_database
from helpers import auth_required
import json
import random
import re
import string
import uuid
from datetime import datetime, timedelta

import jwt
import requests
from flask import Blueprint, current_app, jsonify, redirect, request
from werkzeug.security import check_password_hash, generate_password_hash

from db import connect_to_database
from helpers import auth_required
bp = Blueprint('orders', __name__)

#a route that allows to the user to get his orders
@bp.route('/my-orders', methods=['GET'])
@auth_required
def get_orders(current_user):
    conn = connect_to_database()
    cursor = conn.cursor()
    # get the orders from the database
    cursor.execute("SELECT * FROM orders WHERE user_id = %s",
                   (current_user[0],))
    rows = cursor.fetchall()
    # converting the query objects to list of jsons
    output = []
    for row in rows:
        # appending the user data json to the response list
        output.append({
            'id': row[0],
            'user_id': row[1],
            'announce_id': row[2],
            'status': row[3],
            'message': row[4],
            'created_at': row[5],
        })
    return jsonify({'orders': output})


@bp.route('/announces/<announce_id>/place-order', methods=['POST'])
@auth_required
def place_order(current_user, announce_id):
 
    app = current_app
    data = request.get_json()

    conn = connect_to_database()
    cursor = conn.cursor()
    # check if the announce exists
    cursor.execute("SELECT * FROM announces WHERE id = %s", (announce_id,))
    announce = cursor.fetchone()
    if not announce:
        return jsonify({'message': 'Announce not found'}), 404
    # check if the user is the owner of the announce
    if announce[1] == current_user[0]:
        return jsonify({'message': 'You are not allowed to place an order for this property'}), 401
    # check if the user already placed an order for the announce
    cursor.execute("SELECT * FROM orders WHERE user_id = %s AND announce_id = %s",
                   (current_user[0], announce_id))
    order = cursor.fetchone()
    if order:
        return jsonify({'message': 'You already placed an order'}), 400
    # place the order
    cursor.execute("INSERT INTO orders (user_id, announce_id,message) VALUES (%s, %s, %s)",
                   (current_user[0], announce_id, data['message']))
    conn.commit()
    # create a notification for the user and make sure it's not a notification for the user who created the announce and the user didn't place an order for his own announce before and the notification should be created only once
    cursor.execute("SELECT * FROM notifications WHERE user_id = %s AND announce_id = %s AND type = %s",
                   (announce[1], announce_id, 'order'))
    notification = cursor.fetchone()
    if not notification and announce[1] != current_user[0]:
        cursor.execute("INSERT INTO notifications (user_id, announce_id, type) VALUES (%s, %s, %s)",
                       (announce[1], announce_id, 'order'))
        conn.commit()
        return jsonify({'message': 'Order has been placed'}), 201
    return jsonify({'message': 'Order has been placed'}), 201


@bp.route('/orders/<order_id>/accept', methods=['POST'])
@auth_required
def accept_order(current_user, order_id):
    conn = connect_to_database()
    cursor = conn.cursor()
    # check if the order exists
    cursor.execute("SELECT * FROM orders WHERE id = %s", (order_id,))
    order = cursor.fetchone()
    if not order:
        return jsonify({'message': 'Order not found'}), 404
    # check if the user is the owner of the announce
    cursor.execute("SELECT * FROM announces WHERE id = %s", (order[2],))
    announce = cursor.fetchone()
    if announce[1] != current_user[0]:
        return jsonify({'message': 'You are not allowed to do this'}), 401
    # accept the order
    cursor.execute(
        "UPDATE orders SET status = %s WHERE id = %s", (1, order_id))
    conn.commit()
    # create a notification for the user and make sure it's not a notification for the user who created the announce and the user didn't place an order for his own announce before and the notification should be created only once
    cursor.execute("SELECT * FROM notifications WHERE user_id = %s AND announce_id = %s AND type = %s",
                   (order[1], order[2], 'accept'))
    notification = cursor.fetchone()
    if not notification and order[1] != current_user[0]:
        cursor.execute("INSERT INTO notifications (user_id, announce_id, type) VALUES (%s, %s, %s)",
                       (order[1], order[2], 'accept'))
        conn.commit()
        return jsonify({'message': 'Order has been accepted'}), 200
    return jsonify({'message': 'Order has been accepted'}), 200


@bp.route('/orders/<order_id>/reject', methods=['POST'])
@auth_required
def reject_order(current_user, order_id):
    conn = connect_to_database()
    cursor = conn.cursor()
    # check if the order exists
    cursor.execute("SELECT * FROM orders WHERE id = %s", (order_id,))
    order = cursor.fetchone()
    if not order:
        return jsonify({'message': 'Order not found'}), 404
    # check if the user is the owner of the announce
    cursor.execute("SELECT * FROM announces WHERE id = %s", (order[2],))
    announce = cursor.fetchone()
    if announce[1] != current_user[0]:
        return jsonify({'message': 'You are not allowed to do this'}), 401
    # reject the order
    cursor.execute(
        "UPDATE orders SET status = %s WHERE id = %s", (-1, order_id))
    conn.commit()
    # create a notification for the user and make sure it's not a notification for the user who created the announce and the user didn't place an order for his own announce before and the notification should be created only once
    cursor.execute("SELECT * FROM notifications WHERE user_id = %s AND announce_id = %s AND type = %s",
                   (order[1], order[2], 'reject'))
    notification = cursor.fetchone()
    if not notification and order[1] != current_user[0]:
        cursor.execute("INSERT INTO notifications (user_id, announce_id, type) VALUES (%s, %s, %s)",
                       (order[1], order[2], 'reject'))
        conn.commit()
        return jsonify({'message': 'Order has been rejected'}), 200
    return jsonify({'message': 'Order has been rejected'}), 200


#a route to get the owner of the announce information
@bp.route('/announces/<announce_id>/owner', methods=['GET'])
@auth_required
def get_owner(current_user, announce_id):
    conn = connect_to_database()
    cursor = conn.cursor()
    # check if the announce exists
    cursor.execute("SELECT * FROM announces WHERE id = %s", (announce_id,))
    announce = cursor.fetchone()
    if not announce:
        return jsonify({'message': 'Announce not found'}), 404
    # get the owner of the announce
    cursor.execute("SELECT * FROM user WHERE id = %s", (announce[1],))
    owner = cursor.fetchone()
    output = {
        'name': owner[2],
        'prenom': owner[3],
        'email': owner[4],
        'phone': owner[5],
        'address': owner[6],   
    }
    return jsonify({'owner': output})



#a route that allows a user to get orders placed on an announce
@bp.route('/announces/<announce_id>/orders', methods=['GET'])
@auth_required
def get_announce_orders(current_user, announce_id):
    conn = connect_to_database()
    cursor = conn.cursor()
    # check if the announce exists
    cursor.execute("SELECT * FROM announces WHERE id = %s", (announce_id,))
    announce = cursor.fetchone()
    if not announce:
        return jsonify({'message': 'Announce not found'}), 404
    # check if the user is the owner of the announce
    cursor.execute("SELECT * FROM announces WHERE id = %s", (announce_id,))
    announce = cursor.fetchone()
    if announce[1] != current_user[0]:
        return jsonify({'message': 'You are not the owner of this announce'}), 401
    # get the orders placed on the announce
    cursor.execute("SELECT * FROM orders WHERE announce_id = %s", (announce_id,))
    orders = cursor.fetchall()
    output = []
    for order in orders:
        # get the  information of the user who placed the order
        cursor.execute(
            "SELECT * FROM user WHERE id = %s", (order[1],))
        user = cursor.fetchone()
        order_data = {
            'id': order[0],
            'user_id': order[1],
            'announce_id': order[2],
            'status': order[3],
            'message': order[4],
            'user_name': user[2],
            'user_prenom': user[3],
            'user_email': user[4],
            'user_phone': user[5],
            'user_address': user[6],
        }
        output.append(order_data)
    return jsonify({'orders': output})

