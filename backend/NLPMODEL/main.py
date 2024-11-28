# main.py
from NLPMODEL.topskills.top_skills import get_top_skills_from_pdf

def main(domain):
    dom = domain
    pdf_path = f"/home/bhanu-goel/Documents/Flutter/Programming Fundamentals/flask flutter integration projects/test auth/backend/uploads/{dom}.pdf"  # Provide your resume PDF file path here
    
    # Get the top skills from the PDF and display them in a table
    top_skills_table = get_top_skills_from_pdf(pdf_path,dom)
    for i in top_skills_table:
        i = i.capitalize()
    return top_skills_table