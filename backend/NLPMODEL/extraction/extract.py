# extract.py

import fitz  # PyMuPDF

def extracted_text(pdf_path):
    """
    Extract text from a PDF file.
    """
    # Open the PDF file
    doc = fitz.open(pdf_path)
    text = ""

    # Iterate through each page of the PDF and extract text
    for page in doc:
        text += page.get_text()

    return text