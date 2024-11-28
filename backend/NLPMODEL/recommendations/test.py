import re
import numpy as np
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity

from NLPMODEL.extraction.extract import extracted_text

class DomainSpecificResumeAnalyzer:
    def __init__(self, domain):
        """
        Initialize Resume Analyzer for a specific domain
        
        Args:
            domain (str): Target professional domain
        """
        self.domain = domain
        print(domain)
        self.vectorizer = TfidfVectorizer(stop_words='english')
        
        # Domain-specific skill databases
        self.domain_skill_databases = {
            'software_engineering': [
                'Python', 'Java', 'JavaScript', 'React', 
                'Node.js', 'Cloud Computing', 'DevOps', 
                'Machine Learning', 'Cybersecurity'
            ],
            'data_science': [
                'Python', 'R', 'SQL', 'Machine Learning', 
                'Deep Learning', 'Data Visualization', 
                'Statistical Analysis', 'TensorFlow', 'Pandas'
            ],
            'marketing': [
                'Digital Marketing', 'SEO', 'Content Strategy', 
                'Social Media Marketing', 'Google Analytics', 
                'Email Marketing', 'CRM', 'Marketing Automation'
            ],

        }
        
        # Select skills based on domain
        self.skill_database = self.domain_skill_databases.get(
            domain, self.domain_skill_databases[domain]
        )
    
    def preprocess_text(self, text):
        """Preprocess text for analysis"""
        text = text.lower()
        text = re.sub(r'[^a-zA-Z\s]', '', text)
        return text
    
    def calculate_domain_alignment_score(self, resume_text, job_description):
        """Calculate domain-specific alignment score"""
        resume_processed = self.preprocess_text(resume_text)
        job_desc_processed = self.preprocess_text(job_description)
        
        vectors = self.vectorizer.fit_transform([resume_processed, job_desc_processed])
        similarity = cosine_similarity(vectors)[0][1]
        
        domain_alignment_score = similarity * 100
        return round(domain_alignment_score, 2)
    
    def extract_domain_skills(self, resume_text):
        """Extract domain-specific skills from resume"""
        found_skills = {
            'matched_skills': [],
            'missing_skills': [],
            'skill_coverage': 0
        }
        
        normalized_resume = resume_text.lower()
        
        for skill in self.skill_database:
            if skill.lower() in normalized_resume:
                found_skills['matched_skills'].append(skill)
            else:
                found_skills['missing_skills'].append(skill)
        
        total_skills = len(self.skill_database)
        matched_count = len(found_skills['matched_skills'])
        found_skills['skill_coverage'] = round((matched_count / total_skills) * 100, 2)
        
        return found_skills
    
    def generate_domain_recommendations(self, resume_text, job_description):
        """Generate domain-specific resume recommendations"""
        recommendations = {
            'domain_assessment': [],
            'skill_recommendations': [],
            'improvement_areas': []
        }
        
        # Domain Alignment Score
        domain_score = self.calculate_domain_alignment_score(resume_text, job_description)
        
        # Skill Analysis
        skills_analysis = self.extract_domain_skills(resume_text)
        
        recommendations['domain_assessment'] = [
            f"Domain Alignment Score: {domain_score}%",
            f"Domain: {self.domain} Professional Potential"
        ]
        
        recommendations['skill_recommendations'] = [
            f"Matched Skills: {', '.join(skills_analysis['matched_skills'])}",
            f"Missing Skills: {', '.join(skills_analysis['missing_skills'])}",
            f"Skill Coverage: {skills_analysis['skill_coverage']}%"
        ]
        
        if skills_analysis['skill_coverage'] < 80:
            recommendations['improvement_areas'].append(
                f"Skill Enhancement: Critical {self.domain} skills to add"
            )
        
        return recommendations

import os
def load_job_description(domain):
    # Define the path to the job descriptions folder
    file_path = os.path.join('/home/bhanu-goel/Documents/Flutter/Programming Fundamentals/flask flutter integration projects/test auth/backend/NLPMODEL/ats_scoring_system/job_descriptions', f'{domain}.txt')

    # Check if the file exists
    if not os.path.exists(file_path):
        raise FileNotFoundError(f"Job description for domain '{domain}' not found.")

    # Read the content of the file
    with open(file_path, 'r') as file:
        return file.read()
    
# Example Usage
def main(domain):
    
    dom = domain
    pdf_path = f"/home/bhanu-goel/Documents/NLP MODEL/resumefolder/{dom}.pdf"  # Provide your resume PDF file path here
    resume_text = extracted_text(pdf_path)
    
    # Sample Job Description
    job_description = load_job_description(dom)
    
    # Initialize Domain-Specific Analyzer
    analyzer = DomainSpecificResumeAnalyzer(domain=dom)
    
    # Generate Recommendations
    recommendations = analyzer.generate_domain_recommendations(resume_text, job_description)
    
    return recommendations

