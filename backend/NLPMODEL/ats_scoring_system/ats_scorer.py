# ats_scoring/ats_scorer.py
import re
import numpy as np
from typing import Dict, List
from fuzzywuzzy import fuzz
from NLPMODEL.ats_scoring_system.utils import preprocess_text
from NLPMODEL.ats_scoring_system.tfidf_relevance import calculate_tfidf_relevance
from NLPMODEL.ats_scoring_system.formatting import check_formatting

class ATSScorer:
    def __init__(self, domain_keywords: Dict[str, List[str]] = None, soft_skills: List[str] = None):
        self.domain_keywords = domain_keywords or {}
        self.soft_skills = soft_skills or []

    def set_domain_keywords(self, domain: str, keywords: List[str]):
        self.domain_keywords[domain] = keywords

    def get_domain_keywords(self, domain: str) -> List[str]:
        return self.domain_keywords.get(domain, [])

    def calculate_keyword_coverage(self, resume_text: str, domain: str = None) -> Dict[str, Dict]:
        keyword_coverage = {}
        domains_to_check = [domain] if domain else list(self.domain_keywords.keys())
        for check_domain in domains_to_check:
            if check_domain not in self.domain_keywords:
                print(f"Warning: No keywords found for domain '{check_domain}'")
                continue
            keywords = self.domain_keywords[check_domain]
            matched_keywords = [keyword for keyword in keywords if keyword.lower() in resume_text.lower() or fuzz.partial_ratio(keyword.lower(), resume_text.lower()) > 80]
            coverage = (len(matched_keywords) / len(keywords)) * 100 if keywords else 0
            keyword_coverage[check_domain] = {'coverage_percentage': round(coverage, 2)}

        if self.soft_skills:
            # print(resume_text)
            # for skill in self.soft_skills:
            #     print(skill)
            matched_soft_skills = [skill for skill in self.soft_skills if skill.lower() in resume_text.lower()]
            # print(matched_soft_skills)
            soft_skill_coverage = (len(matched_soft_skills) / len(self.soft_skills)) * 100
            keyword_coverage['soft_skills'] = {'coverage_percentage': round(soft_skill_coverage, 2)}
        
        return keyword_coverage

    def calculate_ats_score(self, resume_text: str, job_description: str, domain: str = None, scoring_weights: Dict[str, float] = None) -> Dict[str, float]:
        default_weights = {
            'keyword_coverage': 0.4,
            'tfidf_relevance': 0.3,
            'length_score': 0.2,
            'formatting_score': 0.1
        }
        
        scoring_weights = scoring_weights or default_weights
        cleaned_resume = preprocess_text(resume_text)
        cleaned_job_desc = preprocess_text(job_description)
        # print(cleaned_resume,'\n')
        
        keyword_scores = self.calculate_keyword_coverage(resume_text, domain)
        tfidf_score = calculate_tfidf_relevance(cleaned_resume, cleaned_job_desc)
        
        length_score = min(len(cleaned_resume.split()) / 500 * 100, 100)
        formatting_score = check_formatting(resume_text)
        
        domain_coverage = list(keyword_scores.values())[0]['coverage_percentage'] if keyword_scores else 0
        
        comprehensive_score = (
            domain_coverage * scoring_weights['keyword_coverage'] +
            tfidf_score * scoring_weights['tfidf_relevance'] +
            length_score * scoring_weights['length_score'] +
            formatting_score * scoring_weights['formatting_score']
        )
        
        return {
            'comprehensive_score': round(comprehensive_score, 2),
            'keyword_coverage': keyword_scores,
            'tfidf_relevance': tfidf_score,
            'length_score': round(length_score, 2),
            'formatting_score': round(formatting_score, 2)
        }
