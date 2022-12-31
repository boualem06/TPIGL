from functools import wraps

import jwt
from flask import request, jsonify, current_app

from db import connect_to_database

def auth_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        token = None

        if 'Authorization' in request.headers:
            token = request.headers['Authorization']

        if not token:
            return jsonify({'message': 'Token is missing!'}), 401

        try:
            data = jwt.decode(
                token, current_app.config['SECRET_KEY'], algorithms=['HS256'])
            conn = connect_to_database()
            cursor = conn.cursor()
            cursor.execute(
                "SELECT id, public_id, nom, prenom, email, password, is_admin FROM user WHERE public_id = %s", (data['public_id'],))
            current_user = cursor.fetchone()
        except:
            return jsonify({'message': 'Token is invalid!'}), 401

        return f(current_user, *args, **kwargs)
    return decorated
