# ats_scoring/tfidf_relevance.py
import numpy as np
from sklearn.feature_extraction.text import TfidfVectorizer

def calculate_tfidf_relevance(resume_text: str, job_description: str) -> float:
    corpus = [resume_text, job_description]
    vectorizer = TfidfVectorizer()
    tfidf_matrix = vectorizer.fit_transform(corpus)
    cosine_similarity = np.dot(tfidf_matrix[0].toarray(), tfidf_matrix[1].toarray().T)[0][0]
    return round(cosine_similarity * 100, 2)
