import docx
import sys

try:
    doc = docx.Document(sys.argv[1])
    for p in doc.paragraphs:
        if p.text.strip():
            print(p.text)
except Exception as e:
    print(f"Error: {e}")
