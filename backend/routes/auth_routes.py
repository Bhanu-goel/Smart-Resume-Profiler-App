from flask import Blueprint, request, jsonify
from models.user_model import db, User
from utils.token_utils import generate_token
import os

# Initialize Blueprint
auth_bp = Blueprint("auth", __name__)

# -------------------------------
# User Authentication Endpoints
# -------------------------------

@auth_bp.route("/signup", methods=["POST"])
def signup():
    data = request.get_json()
    username = data.get("username")
    password = data.get("password")

    if not username or not password:
        return jsonify({"message": "Username and password are required"}), 400

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

    if not username or not password:
        return jsonify({"message": "Username and password are required"}), 400

    user = User.query.filter_by(username=username).first()
    if user and user.check_password(password):
        token = generate_token(user.id)
        return jsonify({"token": token}), 200

    return jsonify({"message": "Invalid credentials"}), 401


# -------------------------------
# Resume Evaluation Endpoints
# -------------------------------

@auth_bp.route("/evaluate", methods=["POST"])
def evaluate():
    if 'resume' not in request.files:
        return jsonify({"message": "No file part"}), 400

    file = request.files['resume']
    domain = request.form.get('domain')

    if not domain:
        return jsonify({"message": "Domain is required"}), 400

    if file.filename == '':
        return jsonify({"message": "No selected file"}), 400

    # Ensure uploads directory exists
    upload_folder = 'uploads'
    os.makedirs(upload_folder, exist_ok=True)

    # Save the file to the uploads directory
    file_path = os.path.join(upload_folder, f'{domain}.pdf')
    file.save(file_path)

    # Analyze the resume using the mock function
    analysis_results = analyze_resume(file_path, domain)

    # Return the analysis results
    return jsonify({
        "message": "File successfully uploaded and evaluated",
        "domain": domain,
        "ats_score": analysis_results["ats_score"],
        "top_skills": analysis_results["top_skills"],
        "recommendations": analysis_results["recommendations"]
    }), 200


def analyze_resume(file_path, domain):
    # Simulate an analysis based on the resume file and domain
    return {
        "ats_score": calculate_ats_score(domain),
        "top_skills": find_top_skills(domain),
        "recommendations": create_recommendations(domain)
    }


# -------------------------------
# ATS Scoring Endpoint
# -------------------------------

@auth_bp.route('/getATSScore', methods=['GET'])
def get_ats_score():
    domain = request.args.get('domain')

    if not domain:
        return jsonify({"error": "Domain is required"}), 400

    try:
        ats_score = calculate_ats_score(domain)
        return jsonify({'ats_score': f'{ats_score}%'}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500


def calculate_ats_score(domain):
    from NLPMODEL.ats_scoring_system.main import main
    ats_score = main(domain)
    return ats_score


# -------------------------------
# Top Skills Endpoint
# -------------------------------

@auth_bp.route('/getTopSkills', methods=['GET'])
def get_top_skills():
    domain = request.args.get('domain')

    if not domain:
        return jsonify({"error": "Domain is required"}), 400
    
    try:
        top_skills = find_top_skills(domain)
        return jsonify({'top_skills': top_skills}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500


def find_top_skills(domain):
    from NLPMODEL.main import main
    topskills = main(domain)
    formatted_skills = [skill.capitalize() for skill in topskills]
    return formatted_skills


# -------------------------------
# Recommendations Endpoint
# -------------------------------

@auth_bp.route('/getRecommendations', methods=['GET'])
def get_recommendations():
    domain = request.args.get('domain')

    if not domain:
        return jsonify({"error": "Domain is required"}), 400
    try:
        recommendations = create_recommendations(domain)
        return jsonify({'recommendations': recommendations}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500


def create_recommendations(domain):
    from NLPMODEL.recommendations.test import main
    recommendations = main(domain)
    return [recommendations]
