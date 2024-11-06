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

# Mock analysis function
def analyze_resume(file_path, domain):
    # Simulate an analysis based on the resume file and domain
    return {
        "ats_score": 85,
        "top_skills": ["Python", "Data Analysis", "Machine Learning"],
        "recommendations": [
            "Add more leadership experience",
            "Highlight project management skills"
        ]
    }

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
    
@auth_bp.route('/getATSScore', methods=['GET'])
def get_ats_score():
    try:
        # Logic to calculate or retrieve the ATS score (can be based on resume data)
        ats_score = calculate_ats_score()

        return jsonify({'ats_score': f'{ats_score}%'}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

def calculate_ats_score():
    # Placeholder function to simulate ATS score calculation
    # This should contain the actual logic of evaluating a resume
    return 75  # Example ATS score

@auth_bp.route('/getTopSkills', methods=['GET'])
def get_top_skills():
    try:
        # Logic to fetch or calculate the top skills
        top_skills = find_top_skills()

        return jsonify({'top_skills': top_skills}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    
def find_top_skills():
    top_skills = ["Python", "Data Analysis", "Machine Learning", "Project Management"]
    return top_skills


@auth_bp.route('/getRecommendations', methods=['GET'])
def get_recommendations():
    try:
        # Mock recommendations, ideally this would come from some analysis or database
        recommendations = create_recommendations()
        return jsonify({'recommendations': recommendations}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    
def create_recommendations():
    recommendations = [
            "Improve resume formatting",
            "Add more technical skills",
            "Highlight leadership roles",
            "Include measurable achievements",
            "Focus on relevant experience"
        ]
    return recommendations
