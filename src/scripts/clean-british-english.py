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
    content = f.read()

for old, new in replacements.items():
    if old=="disc":
        old="disc([^a-zA-Z]|$)"
    content = re.sub(old, new, content)

with open(input, 'w') as f:
    f.write(content)
