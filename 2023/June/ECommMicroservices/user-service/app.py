# mkdir user-service
# cd user-service
# python -m venv venv
# source venv/bin/activate Linux
# venv\Scripts\activate.bat
#pip install Flask Flask-SQLAlchemy Flask-Migrate psycopg2
#python.exe -m pip install --upgrade pip
from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from config import Config

app = Flask(__name__)
app.config.from_object(Config)
#app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://username:password@localhost/dbname'
#app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
from models import UserProfile, ShippingAddress, User
db = SQLAlchemy(app)
migrate = Migrate(app, db)

@app.route('/users', methods=['GET'])
def get_users():
    users = User.query.all()
    return jsonify([user.to_dict() for user in users])

@app.route('/users/<int:user_id>', methods=['GET'])
def get_user(user_id):
    user = User.query.get(user_id)
    if user is None:
        return jsonify({"error": "User not found"}), 404
    return jsonify(user.to_dict())

@app.route('/users', methods=['POST'])
def create_user():
    data = request.get_json()
    username = data.get('username')
    email = data.get('email')

    if not username or not email:
        return jsonify({"error": "Username and email are required"}), 400

    user = User(username=username, email=email)
    db.session.add(user)
    db.session.commit()

    return jsonify(user.to_dict()), 201
# User profile
@app.route('/users/<int:user_id>/profile', methods=['GET'])
def get_user_profile(user_id):
    profile = UserProfile.query.filter_by(user_id=user_id).first()
    if profile is None:
        return jsonify({"error": "Profile not found"}), 404
    return jsonify(profile.to_dict())

@app.route('/users/<int:user_id>/profile', methods=['POST'])
def create_user_profile(user_id):
    data = request.get_json()
    first_name = data.get('first_name')
    last_name = data.get('last_name')

    if not first_name or not last_name:
        return jsonify({"error": "First name and last name are required"}), 400

    profile = UserProfile(user_id=user_id, first_name=first_name, last_name=last_name)
    db.session.add(profile)
    db.session.commit()

    return jsonify(profile.to_dict()), 201

# Shipping addresses
@app.route('/users/<int:user_id>/addresses', methods=['GET'])
def get_user_addresses(user_id):
    addresses = ShippingAddress.query.filter_by(user_id=user_id).all()
    return jsonify([address.to_dict() for address in addresses])

@app.route('/users/<int:user_id>/addresses', methods=['POST'])
def create_user_address(user_id):
    data = request.get_json()
    street = data.get('street')
    city = data.get('city')
    state = data.get('state')
    postal_code = data.get('postal_code')

    if not street or not city or not state or not postal_code:
        return jsonify({"error": "Street, city, state, and postal code are required"}), 400

    address = ShippingAddress(user_id=user_id, street=street, city=city, state=state, postal_code=postal_code)
    db.session.add(address)
    db.session.commit()

    return jsonify(address.to_dict()), 201

if __name__ == '__main__':
    app.run(debug=True)
