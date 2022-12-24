from flask import Flask, request, jsonify, make_response
from flask_sqlalchemy import SQLAlchemy
import uuid # for public id
from  werkzeug.security import generate_password_hash, check_password_hash
# imports for PyJWT authentication
import jwt
from datetime import datetime, timedelta
from functools import wraps
  


app = Flask(__name__)



app.config['SECRET_KEY'] = 'qldkfqdmqskfnsld354684sdfbscdhfb'
app.config['SQLALCHEMY_DATABASE_URI']='mysql://root:''@localhost/flask'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS']=False


db=SQLAlchemy(app)



# *****************************authentfication routes and models ******************************

class User(db.Model):
    id = db.Column(db.Integer, primary_key = True)
    public_id = db.Column(db.String(50), unique = True)
    nom = db.Column(db.String(100))
    prenom = db.Column(db.String(100))
    email = db.Column(db.String(70), unique = True)
    password = db.Column(db.String(255))
  


def token_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        token = None
        # jwt is passed in the request header
        if 'x-access-token' in request.headers:
            token = request.headers['x-access-token'] 
        # return 401 if token is not passed
        if not token:
            return jsonify({'message' : 'Token is missing !!'}), 401
        try:
            # decoding the payload to fetch the stored details
            data = jwt.decode(token, app.config['SECRET_KEY'], algorithms=["HS256"])
            current_user = User.query.filter_by(public_id = data['public_id']).first()
        except:
            return jsonify({
                'message' : 'Token is invalid !!'
            }), 401
        # returns the current logged in users contex to the routes
        return  f(current_user, *args, **kwargs)
  
    return decorated
  



@app.route('/user', methods =['GET'])
@token_required
def get_all_users(current_user):

    # querying the database for all the entries in it
    users = User.query.all()
    # converting the query objects to list of jsons
    output = []
    for user in users:
        # appending the user data json to the response list
        output.append({
            'public_id': user.public_id,
            'nom' : user.nom,
            'prenom':user.prenom,
            'email' : user.email
        })
  
    return jsonify({'users': output})




@app.route('/login', methods =['POST'])
def login():
   
    email =request.json['email']
    password = request.json['password']

    if  not email  or not password :
        # returns 401 if any email or / and password is missing
        return make_response(
            'please add your password and email',
            401,
            {'WWW-Authenticate' : 'Basic realm ="Login required !!"'}
        )
  
    user = User.query.filter_by(email =email ).first()
  
    if not user:
        # returns 401 if user does not exist
        return make_response(
            'user not found ',
            401,
            {'WWW-Authenticate' : 'Basic realm ="User does not exist !!"'}
        )
    
    if check_password_hash(user.password, password):
        # generates the JWT Token
        token = jwt.encode({
            'public_id': user.public_id,
            'exp' : datetime.utcnow() + timedelta(minutes = 30)
        }, app.config['SECRET_KEY'])
  
        return make_response(jsonify({'token' : token}), 201)
    # returns 403 if password is wrong
    return make_response(
        'incorrect password ',
        403,
        {'WWW-Authenticate' : 'Basic realm ="Wrong Password !!"'}
    )
  



@app.route('/signup', methods =['POST'])
def signup():
    # creates a dictionary of the request data
    nom=request.json['nom']
    prenom=request.json['prenom']
    email =request.json['email']
    password = request.json['password']
    
    if  not email  or not password or not nom or not prenom :
        # returns 401 if any email or / and password is missing
        return make_response(
            'please add all your informations ',
            401,
            {'WWW-Authenticate' : 'Basic realm ="Login required !!"'}
        )


    # checking for existing user
    user = User.query.filter_by(email = email).first()
    
    if not user:
        # database ORM object
        user = User(
            public_id = str(uuid.uuid4()),
            nom = nom,
            prenom=prenom,
            email = email,
            password = generate_password_hash(password,method='pbkdf2:sha1',salt_length=8)
        )
       
        # insert user
        db.session.add(user)
        db.session.commit()
        return make_response('Successfully registered.', 201)
    else:
        # returns 202 if user already exists
        return make_response('User already exists. Please use another Email.', 202)


