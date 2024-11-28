import os
from NLPMODEL.ats_scoring_system.ats_scorer import ATSScorer
from NLPMODEL.extraction.extract import extracted_text

def load_job_description(domain):
    # Define the path to the job descriptions folder
    file_path = os.path.join('NLPMODEL/ats_scoring_system/job_descriptions', f'{domain}.txt')

    # Check if the file exists
    if not os.path.exists(file_path):
        raise FileNotFoundError(f"Job description for domain '{domain}' not found.")

    # Read the content of the file
    with open(file_path, 'r') as file:
        return file.read()

def main(domain):
    ats_scorer = ATSScorer(soft_skills=[
        'communication', 'leadership', 'teamwork', 'problem-solving', 'creativity'
    ])
    
    ats_scorer.set_domain_keywords('software_engineering', [
        'Python', 'Java', 'JavaScript', 'React', 
                'Node.js', 'Cloud Computing', 'DevOps', 
                'Machine Learning', 'Cybersecurity'
    ])
    
    ats_scorer.set_domain_keywords('data_science', [
        'Python', 'R', 'SQL', 'Machine Learning', 
                'Deep Learning', 'Data Visualization', 
                'Statistical Analysis', 'TensorFlow', 'Pandas'
    ])
    
    ats_scorer.set_domain_keywords('marketing', [
    'Digital Marketing', 'SEO', 'Content Strategy', 
                'Social Media Marketing', 'Google Analytics', 
                'Email Marketing', 'CRM', 'Marketing Automation'
])
    #get text from pdf file
    dom = domain
    print(dom)
    pdf_path = f"/home/bhanu-goel/Documents/Flutter/Programming Fundamentals/flask flutter integration projects/test auth/backend/uploads/{dom}.pdf"  # Provide your resume PDF file path here
    resume_text = extracted_text(pdf_path)
    
    # Get job description from file based on domain
    try:
        job_description = load_job_description(domain=dom)
    except FileNotFoundError as e:
        print(e)
        return
    
    ats_result = ats_scorer.calculate_ats_score(
        resume_text, 
        job_description, 
        domain=dom
    )
    
    # for key, value in ats_result.items():
        # print(f"{key.replace('_', ' ').title()}: {value}")
    return ats_result['comprehensive_score']


