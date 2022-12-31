import re
import uuid
from datetime import datetime, timedelta

import jwt
from flask import Blueprint, current_app, jsonify, request
from werkzeug.security import check_password_hash, generate_password_hash

from db import connect_to_database

bp = Blueprint('auth', __name__)


def is_valid_email(email):
    # Regular expression to match email addresses
    pattern = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$'
    if re.match(pattern, email):
        return True
    return False


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
    hashed_password = generate_password_hash(data['password'], method='sha256')
    cursor.execute("INSERT INTO user (public_id, nom, prenom, email, password, is_admin) VALUES (%s, %s, %s, %s, %s, %s)", (str(
        uuid.uuid4()), data['nom'], data['prenom'], data['email'], hashed_password, False))
    conn.commit()
    return jsonify({'message': 'New user created'})
