#!/usr/bin/env python3
import re

def reclassify_terms():
    # Read the file
    with open('src/ontology/mondo-edit.obo', 'r') as f:
        content = f.read()

    # Define replacements
    replacements = [
        # Anatomical system diseases
        ('MONDO:0024623', 'MONDO:1060156', 'anatomical system disease'),  # otorhinolaryngologic disease
        ('MONDO:0005219', 'MONDO:1060156', 'anatomical system disease'),  # breast fibrocystic disease

        # Environmental and external cause diseases
        ('MONDO:0029000', 'MONDO:1060157', 'environmental and external cause disease'),  # poisoning
        ('MONDO:0005137', 'MONDO:1060157', 'environmental and external cause disease'),  # nutritional disorder
        ('MONDO:0700220', 'MONDO:1060157', 'environmental and external cause disease'),  # disease related to transplantation

        # Functional and physiological disorders
        ('MONDO:0100081', 'MONDO:1060158', 'functional and physiological disorder'),  # sleep disorder
        ('MONDO:0043839', 'MONDO:1060158', 'functional and physiological disorder'),  # ulcer disease

        # Life stage related diseases
        ('MONDO:0100086', 'MONDO:1060160', 'life stage related disease'),  # perinatal disease
        ('MONDO:0700003', 'MONDO:1060160', 'life stage related disease'),  # obstetric disorder
    ]

    changes_made = 0

    for term_id, new_parent, parent_name in replacements:
        # Find the term stanza and replace is_a relationship
        pattern = rf'(id: {re.escape(term_id)}.*?)is_a: MONDO:0700096[^!]*! human disease'
        replacement = rf'\1is_a: {new_parent} {{source="https://github.com/monarch-initiative/mondo/issues/claude-reclassification"}} ! {parent_name}'

        new_content = re.sub(pattern, replacement, content, flags=re.DOTALL)

        if new_content != content:
            changes_made += 1
            print(f"✓ Reclassified {term_id} -> {new_parent} ({parent_name})")
            content = new_content
        else:
            print(f"✗ Failed to reclassify {term_id}")

    # Write the updated file
    with open('src/ontology/mondo-edit.obo', 'w') as f:
        f.write(content)

    print(f"\nCompleted! Made {changes_made} changes.")

if __name__ == '__main__':
    reclassify_terms()