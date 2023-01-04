
import requests
from bs4 import BeautifulSoup
from datetime import date
from datetime import datetime
from flask import Blueprint, jsonify, request
from db import connect_to_database
from helpers import auth_required
import uuid


def split_sentence(sentence, separator):
    # Use the split method of the string object to split the sentence on the specified separator
    words = sentence.split(separator)
    return words



bp = Blueprint('web', __name__)

@bp.get("/webscrapping")
@auth_required
def get_annonces(current_user):
    #check if the user is admin

    #if the user is not admin return 401
    if current_user[6] == 0:
        return jsonify({"message": "You are not an admin"}), 401
    else:    #if the user is admin start the webscrapping process
        annonces = []
    url = "https://darjadida.com/annonces/immobilier-dz-Vente,alger.php"

    # Send an HTTP GET request to the URL
    result = requests.get(url)
    # Parse the HTML response
    doc = BeautifulSoup(result.text, "html.parser")
    # Find all elements with the class "listing-item"
    annonce_elements = doc.find_all(class_="listing-item")

    # Iterate over the elements
    for annonce in annonce_elements:
        # Get the URL of the detail page for the annonce
        a = annonce.a
        detail_annonce_url = a["href"]
        # Send an HTTP GET request to the detail page URL
        result_detail = requests.get(detail_annonce_url)
        # Parse the detail page HTML
        doc_detail = BeautifulSoup(result_detail.text, "html.parser")
        # Extract data from the detail page HTML
        annonce_data = {}
      
      
        # Get the title of the annonce
        titre_annonce = doc_detail.find(class_="property-title").h2.text
        annonce_data["titre_annonce"] = titre_annonce.replace("\r\n", "")
        type_announce=split_sentence(titre_annonce.replace("\r\n", "")," ")[0]
        type_property=split_sentence(titre_annonce.replace("\r\n", "")," ")[1]
        annonce_data["type_announce"] = type_announce.replace("\r\n", "")
        annonce_data["type_property"] = type_property.replace("\r\n", "")

        # Get the price of the annonce
        prix_annonce = doc_detail.find(class_="property-price").text
        annonce_data["prix_annonce"] = prix_annonce.replace("\r ", "")
      
      
        # Get the dimensions of the annonce
        dimensions_annonce = doc_detail.find(class_="property-main-features").find_all("li")
        annonce_data["dimensions_annonce"] = dimensions_annonce[0].span.string
        
      
      
      
        # Get the address of the annonce
        adresse_annonce = doc_detail.find(class_="listing-address").text
        annonce_data["adresse_annonce"] = (adresse_annonce.replace("\n", "")).replace("\r", "").replace("  ", "")
        state_annonce=split_sentence( (adresse_annonce.replace("\n", "")).replace("\r", "").replace("  ", ""),",")[1]
        city_annonce=split_sentence((adresse_annonce.replace("\n", "")).replace("\r", "").replace("  ", ""),",")[0]
        annonce_data["state"] = (state_annonce.replace("\n", "")).replace("\r", "").replace("  ", "")
        annonce_data["city"] = (city_annonce.replace("\n", "")).replace("\r", "").replace("  ", "")



        # Get the images of the annonce
        images = doc_detail.find_all("a", class_="item")
        Images = []
        for image in images:
            Images.append(image["href"])
        annonce_data["Images"] = Images



        # Get the details of the annonce
        annonce_features = doc_detail.find_all(class_="property-main-features")
        annonce_detail = doc_detail.find(class_="property-description")

        annonce_features = annonce_detail.find(class_="property-main-features").find_all("li")
        annonce_area = annonce_features[0].span.string
        annonce_rooms = annonce_features[1].span.string
        annonce_data["annonce_area"] = annonce_area
        annonce_data["annonce_rooms"] = annonce_rooms

        #get the date of the annonce
        annonce_dates = annonce_detail.find(class_="property-features margin-top-0").find_all("li")
        annonce_date = annonce_dates[2].span.string
        annonce_data["annonce_date"] = annonce_date


        
        #get the description of the annonce
        description_annonce = doc_detail.find(class_="property-description").text
        annonce_data["description_annonce"] = description_annonce.replace("\r\n", "")

        #get the seller of the annonce
        seller_annonce = doc_detail.find(class_="agent-name").text
        annonce_data["seller_annonce"] = seller_annonce.replace("\r\n", "")
        #extract name and surname from the seller
        annonce_data["name_seller"] = split_sentence(seller_annonce.replace("\r\n", "")," ")[0]
        annonce_data["surname_seller"] = split_sentence(seller_annonce.replace("\r\n", "")," ")[1]

        #get the email of the seller
        email_seller = doc_detail.find(class_="agent-contact-details").find_all("li")[1].text
        annonce_data["email_seller"] = email_seller.replace("\r ", "")



        

        # Get the contact of the annonce
        contact_annonce = doc_detail.find("ul", class_="agent-contact-details").li.a["href"]
        annonce_data["contact_annonce"] = contact_annonce
        #extract the phone number from the contact
        annonce_data["phone_annonce"] = split_sentence(contact_annonce,":")[1]


        # Add the extracted data to the list of annonces
        annonces.append(annonce_data)



        #add annonces to the database
        conn = connect_to_database()
        cursor = conn.cursor()
        for annonce in annonces:
            user_id=current_user[0]
            public_id=str(uuid.uuid4())
            type_announcement=annonce["type_announce"]
            price=annonce["prix_annonce"]
            street=""
            state=annonce["state"]
            city=annonce["city"]
            created_at=datetime.strptime( annonce["annonce_date"],"%d/%m/%Y").date()
            area=annonce["annonce_area"]
            rooms=annonce["annonce_rooms"]
            type_of_property=annonce["type_property"]
            description=annonce["description_annonce"]
            dimensions=annonce["dimensions_annonce"]
            cursor.execute("INSERT INTO announces (user_id, public_id, type_announcement, price,street, state, city, created_at, area, rooms, type_of_property, description, dimensions) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)", (user_id, public_id, type_announcement, price,street, state, city, created_at, area, rooms, type_of_property, description,dimensions)) 
            conn.commit()
        

        
        cursor.close()
        conn.close()
        
 
    return jsonify({'message': 'new announces are added successfully'})



       

    




   


