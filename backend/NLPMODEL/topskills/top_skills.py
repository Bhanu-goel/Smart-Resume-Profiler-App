# topskills.py
from collections import Counter
from tabulate import tabulate
from NLPMODEL.extraction.extract import extracted_text  # Ensure the correct import for your PDF extraction module
from NLPMODEL.clean_and_preprocess.clean import clean_text  # Ensure the correct import for your cleaning module
import importlib

# Function to dynamically import skill sets based on domain
def load_skill_set_for_domain(domain):
    try:
        print(domain)
        # Dynamically import the skill set based on the domain
        skill_module = importlib.import_module(f"NLPMODEL.skill_sets.{domain.lower()}")
        return skill_module.SKILL_CATEGORIES  # Return the SKILL_CATEGORIES from the domain-specific file
    except ModuleNotFoundError:
        print(f"Skill set for domain '{domain}' not found. Please make sure the domain is correct.")
        return {}

# Function to fetch skills from each category
def extract_skills_from_category(text, category_keywords):
    word_counts = Counter(text.split())  # Split cleaned text into words and count occurrences
    category_skills = {}
    
    for skill in category_keywords:
        category_skills[skill] = word_counts[skill]  # Count how many times the skill appears
    
    return category_skills

# Function to get the top skills from the PDF
def get_top_skills_from_pdf(pdf_path, domain=None):
    # Extract and clean the text from the provided PDF file
    raw_text = extracted_text(pdf_path)  # Extract raw text from PDF
    cleaned_text = clean_text(raw_text)  # Clean the extracted text
    
    # If no domain is provided, use a default domain (optional)
    if domain is None:
        domain = 'datascience'  # Default to data science domain
    
    # Load skill categories based on the provided domain
    SKILL_CATEGORIES = load_skill_set_for_domain(domain)
    
    if not SKILL_CATEGORIES:
        return "No skills found for the given domain."
    
    # Initialize an empty list to store skills
    top_skills = []

    # Fetch skills from each category based on the domain's skill set
    for category, category_keywords in SKILL_CATEGORIES.items():
        category_skills = extract_skills_from_category(cleaned_text, category_keywords)
        
        # Add the skills from the current category to the top_skills list
        top_skills.extend([(skill, count) for skill, count in category_skills.items() if count > 0])
    
    # If we have fewer than 5 skills, repeat the process until we have 5
    while len(top_skills) < 7:
        # Add more skills by repeating the extraction process from each category
        for category, category_keywords in SKILL_CATEGORIES.items():
            category_skills = extract_skills_from_category(cleaned_text, category_keywords)
            top_skills.extend([(skill, count) for skill, count in category_skills.items() if count > 0])
            
            # If we now have 7 skills, break out of the loop
            if len(top_skills) >= 7:
                break

    # Sort skills by count in descending order and pick the top 7
    sorted_skills = sorted(top_skills, key=lambda x: x[1], reverse=True)[:7]

    # Extract only the skill names
    skills_list = [skill for skill, _ in sorted_skills]

    # Return the list of skills
    return skills_list
