# ats_scoring/formatting.py
import re

def check_formatting(resume_text: str) -> float:
    formatting_checks = [
        bool(re.search(r'\b(education|experience|skills)\b', resume_text.lower())),
        len(resume_text.split('\n')) > 10,
        bool(re.search(r'\b[A-Z][a-z]+ [A-Z][a-z]+\b', resume_text))  # Name detection
    ]
    return (sum(formatting_checks) / len(formatting_checks)) * 100
