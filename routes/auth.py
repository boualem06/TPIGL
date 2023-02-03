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

bp = Blueprint('auth', __name__)


def is_valid_email(email):
    # Regular expression to match email addresses
    pattern = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$'
    if re.match(pattern, email):
        return True
    return False

def is_valid_phone_number(phone_number):
  if not isinstance(phone_number, str):
    return False
  if len(phone_number) != 10:
    return False
  if not phone_number[0] == '0':
    return False
  if not phone_number.isdigit():
    return False
  return True



@bp.route('/login', methods=['POST'])
def login():
    app = current_app
    data = request.get_json()
    conn = connect_to_database()
    cursor = conn.cursor()
    cursor.execute(
        "SELECT id, public_id, nom, prenom, email, password, is_admin FROM user WHERE email = %s", (data['email'],))
    rows = cursor.fetchall()
    # Check if email exists in the database
    if len(rows) > 0:
        user = rows[0]
        if check_password_hash(user[5], data['password']):
            # Generate JWT token and return it
            token = jwt.encode({'public_id': user[1], 'exp': datetime.now(
            ) + timedelta(minutes=30000)}, app.config['SECRET_KEY'], algorithm="HS256")
            return jsonify({'token': token})
        else:
            return jsonify({'message': 'Wrong password'}), 400
    else:
        return jsonify({'message': 'Email does not exist'}), 400


@bp.route('/register', methods=['POST'])
def register():
    data = request.get_json()

    # Check if email is valid
    if not is_valid_email(data['email']):
        return jsonify({'message': 'Invalid email address'}), 400

    # Check if email already exists in the database
    conn = connect_to_database()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM user WHERE email = %s", (data['email'],))
    rows = cursor.fetchall()
    if len(rows) > 0:
        return jsonify({'message': 'Email already exists'})

    # Hash password and insert new user into the database

    #check if the phone number is valid
    if  is_valid_phone_number(data['phone_number']) ==False:
        return jsonify({'message': 'Invalid phone number'}), 400
    hashed_password = generate_password_hash(data['password'], method='sha256')
    cursor.execute("INSERT INTO user (public_id, nom, prenom, email,phone_number,address, is_admin, password) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)", (str(
        uuid.uuid4()), data['nom'], data['prenom'], data['email'],data['phone_number'],data['address'],False, hashed_password))
    conn.commit()
    return jsonify({'message': 'New user created'})


#a route that allows the user to edit his profile
@bp.route('/edit_profile', methods=['PUT'])
@auth_required
def edit_profile(current_user):
    data = request.get_json()
    conn = connect_to_database()
    cursor = conn.cursor()

    # Check if email is valid
    if not is_valid_email(data['email']):
        return jsonify({'message': 'Invalid email address'}), 400

    # Check if email already exists in the database and it's not the current user's email
    cursor.execute("SELECT * FROM user WHERE email = %s", (data['email'],))
    rows = cursor.fetchall()
    if len(rows) > 0 and rows[0][0] != current_user[0]:
        return jsonify({'message': 'Email already exists'})
    
    # Check if phone number is valid
    if not is_valid_phone_number(data['phone_number']):
        return jsonify({'message': 'Invalid phone number'}), 400

    # Hash password and update user in the database
    hashed_password = generate_password_hash(data['password'], method='sha256')
    cursor.execute("UPDATE user SET nom = %s, prenom = %s,email= %s, phone_number= %s, address = %s, password = %s WHERE id = %s",(request.json['nom'], request.json['prenom'],request.json['email'], request.json['phone_number'], hashed_password, request.json['password'], current_user[0]))
    conn.commit()
    return jsonify({'message': 'Profile updated'})


@bp.route('/logout', methods=['POST'])
@auth_required
def logout(current_user):
    return jsonify({'message': 'Logged out'})



@bp.route('/delete-my-profile', methods=['DELETE'])
@auth_required
def delete_profile(current_user):
    conn = connect_to_database()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM user WHERE id = %s", (current_user[0],))
    conn.commit()
    return jsonify({'message': 'Profile deleted'})


#route that allows the user to get his profile informations
@bp.route('/my-profile', methods=['GET'])
@auth_required
def get_profile(current_user):
    conn = connect_to_database()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM user WHERE id = %s", (current_user[0],))
    rows = cursor.fetchall()
    if len(rows) > 0:
        user = rows[0]
        return jsonify({'id': user[0], 'public_id': user[1], 'nom': user[2], 'prenom': user[3], 'email': user[4], 'phone_number': user[5], 'address': user[6], 'is_admin': user[7]})
    else:
        return jsonify({'message': 'User not found'}), 400
     
#route that allows the admin to get all the users
@bp.route('/get-all-users', methods=['GET'])
@auth_required
def get_all_users(current_user):
    #check if the current user is an admin
    if not current_user[6]:
        return jsonify({'message': 'You are not an admin'}), 400
    else:
        conn = connect_to_database()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM user")
        rows = cursor.fetchall()
        if len(rows) > 0:
            users = []
            for user in rows:
                users.append({'id': user[0], 'public_id': user[1], 'nom': user[2], 'prenom': user[3], 'email': user[4], 'phone_number': user[5], 'address': user[6], 'is_admin': user[7]})
            return jsonify({'users': users})
        else:
            return jsonify({'message': 'No users found'}), 400

    

#route that allows the admin to delete a user
@bp.route('/delete-user/<user_id>', methods=['DELETE'])
@auth_required
def delete_user(current_user, user_id):
    #check if the current user is an admin
    if not current_user[6]:
        return jsonify({'message': 'You are not an admin'}), 400
    else:
        conn = connect_to_database()
        cursor = conn.cursor()
        cursor.execute("DELETE FROM user WHERE id = %s", (user_id,))
        conn.commit()
        return jsonify({'message': 'User deleted'})

