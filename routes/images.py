import os
import uuid

from flask import Blueprint, current_app, jsonify, request
from werkzeug.utils import secure_filename

from db import connect_to_database
from helpers import auth_required

bp = Blueprint('images', __name__)

# Check if the file extension is allowed


def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ['png', 'jpg', 'jpeg']


@bp.route('/announces/<announce_id>/images', methods=['POST'])
@auth_required
def upload_announce_images(current_user, announce_id):
    # check if the user is an admin or the owner of the announce
    app = current_app
    conn = connect_to_database()
    cursor = conn.cursor()
    if not current_user[6]:
        # get the announce from the database
        cursor.execute(
            "SELECT user_id FROM announces WHERE id = %s", (announce_id,))
        announce = cursor.fetchone()
        # if the announce doesn't exist or the user is not the owner, return an error
        if not announce or announce[0] != current_user[0]:
            return jsonify({'message': 'You are not authorized to upload images for this announce'}), 401
    # check if the announce has images
    cursor.execute(
        "SELECT * FROM images WHERE announce_id = %s", (announce_id,))
    images = cursor.fetchall()
    # check if the request has files
    if 'files' not in request.files:
        return jsonify({'message': 'No file part'}), 400
    files = request.files.getlist('files')
    # Check if files are JPG or PNG and if the file size is less than 5MB, write a commend of each module in the code
    for file in files:
        if file.filename == '':
            return jsonify({'message': 'No selected file'}), 400
        if not allowed_file(file.filename):
            return jsonify({'message': 'File type not allowed'}), 400
        if file and allowed_file(file.filename) and file.content_length < 5 * 1024 * 1024:
            filename = str(uuid.uuid4()) + '.' + \
                secure_filename(file.filename).split('.')[-1]
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            # save the file name in the database
            cursor.execute(
                "INSERT INTO images (announce_id, image) VALUES (%s, %s)", (announce_id, filename))
            conn.commit()

    # upload the files to the server
    for file in files:
        filename = secure_filename(file.filename)
        file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
        # save the file name in the database
        cursor.execute(
            "INSERT INTO images (announce_id, image) VALUES (%s, %s)", (announce_id, filename))
        conn.commit()
    return jsonify({'message': 'Images uploaded successfully'}), 200


@bp.route('/announces/<announce_id>/images/<image_id>', methods=['DELETE'])
@auth_required
def delete_announce_image(current_user, announce_id, image_id):
    app = current_app
    conn = connect_to_database()
    cursor = conn.cursor()
    # check if the user is an admin or the owner of the announce
    if not current_user[6]:
        # get the announce from the database
        cursor.execute(
            "SELECT user_id FROM announces WHERE id = %s", (announce_id,))
        announce = cursor.fetchone()
        # if the announce doesn't exist or the user is not the owner, return an error
        if not announce or announce[0] != current_user[0]:
            return jsonify({'message': 'You are not authorized to delete images for this announce'}), 401
    # get the image from the database
    cursor.execute(
        "SELECT image FROM images WHERE id = %s", (image_id,))
    image = cursor.fetchone()
    # if the image doesn't exist, return an error
    if not image:
        return jsonify({'message': 'Image not found'}), 404
    # delete the image from the database
    cursor.execute(
        "DELETE FROM images WHERE id = %s", (image_id,))
    conn.commit()
    # delete the image from the server
    os.remove(os.path.join(app.config['UPLOAD_FOLDER'], image[0]))
    return jsonify({'message': 'Image deleted successfully'}), 200
