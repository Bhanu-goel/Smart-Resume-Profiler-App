# clean.py
from NLPMODEL.extraction.extract import extracted_text
import re
import nltk
from nltk.corpus import stopwords
from nltk.stem import WordNetLemmatizer

# Download NLTK resources if not already downloaded
nltk.download('punkt')
nltk.download('stopwords')
nltk.download('wordnet')

# Custom stopwords to exclude words not relevant to resume processing
CUSTOM_STOPWORDS = set([
    "mr", "ms", "linkedin", "github", "com", "org", "edu", "www",
    "email", "phone", "resume", "objective", "contact", "skills",
    "summary", "job", "work", "experience", "project", "university"
])

# Combine standard and custom stopwords
STOPWORDS = set(stopwords.words('english')).union(CUSTOM_STOPWORDS)

# Initialize the WordNet lemmatizer
lemmatizer = WordNetLemmatizer()

def clean_text(text):
    """
    Cleans and preprocesses the input text by:
    - Converting to lowercase
    - Removing punctuation
    - Removing stopwords
    - Lemmatizing words
    """
    # Convert text to lowercase
    text = text.lower()
    
    # Remove punctuation and special characters
    text = re.sub(r'[^\w\s]', ' ', text)
    
    # Tokenize text into words
    words = nltk.word_tokenize(text)
    
    # Remove stopwords and lemmatize words
    cleaned_words = [
        lemmatizer.lemmatize(word)
        for word in words if word not in STOPWORDS
    ]
    
    # Join words back into a single string
    cleaned_text = ' '.join(cleaned_words)
    return cleaned_text
