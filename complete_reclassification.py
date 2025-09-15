#!/usr/bin/env python3

import re
import sys

def reclassify_terms():
    """
    Reclassify all remaining direct subclasses of human disease
    """

    # Define the reclassification mapping
    reclassifications = {
        # Genetic and chromosomal diseases -> MONDO:1060155
        'MONDO:0019040': 'MONDO:1060155',  # chromosomal disorder (already done)
        'MONDO:0019303': 'MONDO:1060155',  # premature aging syndrome (already done)

        # Anatomical system diseases -> MONDO:1060156
        'MONDO:0003900': 'MONDO:1060156',  # connective tissue disorder (already done)
        'MONDO:0024623': 'MONDO:1060156',  # otorhinolaryngologic disease
        'MONDO:0005219': 'MONDO:1060156',  # breast fibrocystic disease

        # Environmental and external cause diseases -> MONDO:1060157
        'MONDO:0029000': 'MONDO:1060157',  # poisoning
        'MONDO:0005137': 'MONDO:1060157',  # nutritional disorder
        'MONDO:0700220': 'MONDO:1060157',  # disease related to transplantation

        # Functional and physiological disorders -> MONDO:1060158
        'MONDO:0100081': 'MONDO:1060158',  # sleep disorder
        'MONDO:0043839': 'MONDO:1060158',  # ulcer disease

        # Life stage related diseases -> MONDO:1060160
        'MONDO:0100086': 'MONDO:1060160',  # perinatal disease
        'MONDO:0700003': 'MONDO:1060160',  # obstetric disorder
    }

    # New parent class names
    class_names = {
        'MONDO:1060155': 'genetic and chromosomal disease',
        'MONDO:1060156': 'anatomical system disease',
        'MONDO:1060157': 'environmental and external cause disease',
        'MONDO:1060158': 'functional and physiological disorder',
        'MONDO:1060160': 'life stage related disease',
    }

    print("Reclassification Plan:")
    print("=" * 80)

    for old_id, new_parent in reclassifications.items():
        parent_name = class_names[new_parent]
        print(f"{old_id} -> {new_parent} ({parent_name})")

    print("\nTo complete reclassification, run these sed commands:")
    print("=" * 50)

    for old_id, new_parent in reclassifications.items():
        if old_id not in ['MONDO:0019040', 'MONDO:0019303', 'MONDO:0003900']:  # Skip already done
            parent_name = class_names[new_parent]
            print(f'# Reclassify {old_id}')
            print(f'sed -i "s|is_a: MONDO:0700096.*{old_id}.*|is_a: {new_parent} {{source=\"https://github.com/monarch-initiative/mondo/issues/claude-reclassification\"}} ! {parent_name}|g" src/ontology/mondo-edit.obo')
            print()

if __name__ == "__main__":
    reclassify_terms()