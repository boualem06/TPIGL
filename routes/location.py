import os
import requests
from flask import Blueprint, jsonify
from flask import Flask, jsonify
from db import connect_to_database
from helpers import auth_required

bp = Blueprint('location', __name__)

@bp.route('/location/<announce_id>')
@auth_required
def get_location(current_user,announce_id):
    #connect to the data base
    conn = connect_to_database()
    cursor = conn.cursor()
    #get the announce that its id is the same as the givn one 
    cursor.execute("SELECT * FROM announces WHERE id = %s", (announce_id,))
    row = cursor.fetchone()
    if not row:
        return jsonify({'message': 'Resource not found'}), 404
    output = []
    #get the full location of the announce
    location=" ".join([row[5], row[7],row[6]])
  
    # Use the OpenStreetMap geocoding API to lookup the location
    response = requests.get(f'https://nominatim.openstreetmap.org/search?q={location}&format=json')
    data = response.json()
    
    # Check if the API found the location 
    if len(data) > 0:
        # Extract the latitude and longitude from the first result
        latitude = data[0]['lat']
        longitude = data[0]['lon']
        
        # Create a URL to the location 
        url = f'https://www.openstreetmap.org/#map=18/{latitude}/{longitude}'
        
        # Return the URL 
        return jsonify({'location_url': url})
    else:
        # If the API did not return any results, return an error message
        return jsonify({'error': 'Location not found'})



