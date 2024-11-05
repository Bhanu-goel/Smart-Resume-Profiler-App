# routes/auth_routes.py
from flask import Blueprint, request, jsonify
from models.user_model import db, User
from utils.token_utils import generate_token
import os

auth_bp = Blueprint("auth", __name__)

@auth_bp.route("/signup", methods=["POST"])
def signup():
    data = request.get_json()
    username = data.get("username")
    password = data.get("password")

    if User.query.filter_by(username=username).first():
        return jsonify({"message": "Username already exists"}), 400
    
    user = User(username=username)
    user.set_password(password)
    db.session.add(user)
    db.session.commit()
    
    token = generate_token(user.id)
    return jsonify({"token": token}), 201

@auth_bp.route("/login", methods=["POST"])
def login():
    data = request.get_json()
    username = data.get("username")
    password = data.get("password")

    user = User.query.filter_by(username=username).first()
    if user and user.check_password(password):
        token = generate_token(user.id)
        return jsonify({"token": token}), 200

    return jsonify({"message": "Invalid credentials"}), 401

@auth_bp.route("/evaluate", methods=["POST"])
def evaluate():
    if 'resume' not in request.files:
        return jsonify({"message": "No file part"}), 400

    file = request.files['resume']
    domain = request.form.get('domain')

    if file.filename == '':
        return jsonify({"message": "No selected file"}), 400

    # Ensure uploads directory exists
    upload_folder = 'uploads'
    if not os.path.exists(upload_folder):
        os.makedirs(upload_folder)

    # Save the file to the uploads directory
    file_path = os.path.join(upload_folder, file.filename)
    file.save(file_path)

    # Here you can add your logic to analyze the resume based on the selected domain
    # For now, just return a success message

    return jsonify({"message": "File successfully uploaded and evaluation started", "domain": domain}), 200
