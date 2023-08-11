import csv
import re
import sys

replacements = {}

input = sys.argv[1]
dictionary = sys.argv[2]

with open(dictionary, 'r') as f:
    reader = csv.reader(f)
    next(reader)  # skip header
    replacements = {rows[0]: rows[1] for rows in reader}

with open(input, 'r') as f:
    text = f.read()

def replace_words_from_dict(text, word_dict):
    """Replace words in text based on dictionary."""

    def replacement(match):
        word = match.group(0)
        clean_word = word.strip('.,!?()[]{}":;')
        return word.replace(clean_word, word_dict.get(clean_word, clean_word))

    # This regex will capture words and preserve punctuations.
    return re.sub(r'\b[\w\'-]+\b', replacement, text)


content = replace_words_from_dict(text, replacements)

with open(input, 'w') as f:
    f.write(content)
