#!/usr/bin/env python3
"""
Infer new MONDO to ICD11Foundation and ICD10WHO mappings using semra chain inference.

This script:
1. Loads MONDO mappings (including existing MONDO→ICD10WHO and MONDO→ICD11Foundation)
2. Loads WHO ICD10→ICD11 bridge mappings
3. Uses semra's chain inference to discover new transitive mappings
4. Filters for only NEW mappings (not already in mondo.sssom.tsv)
5. Outputs the new mappings
"""

import sys
from pathlib import Path

import semra
import semra.io
from semra.inference import infer_chains, infer_reversible
from semra.api import assemble_evidences


def load_mappings(mondo_path: str, who_path: str):
    """Load both mapping files."""
    print(f"Loading MONDO mappings from {mondo_path}...")
    mondo_mappings = semra.io.from_sssom(
        mondo_path,
        license="https://w3id.org/sssom/license/unspecified",
        mapping_set_title="MONDO",
    )
    print(f"  Loaded {len(mondo_mappings)} MONDO mappings")

    print(f"\nLoading WHO ICD10→ICD11 mappings from {who_path}...")
    who_mappings = semra.io.from_sssom(
        who_path,
        license="https://w3id.org/sssom/license/unspecified",
        mapping_set_title="WHO ICD10-ICD11 Bridge",
    )
    print(f"  Loaded {len(who_mappings)} WHO bridge mappings")

    return mondo_mappings, who_mappings


def get_existing_mondo_to_icd_mappings(mondo_mappings):
    """Extract existing MONDO→ICD10WHO and MONDO→ICD11Foundation mappings for filtering."""
    existing = set()
    for mapping in mondo_mappings:
        if mapping.subject.prefix == "mondo":
            # Note: semra normalizes prefixes - icd11.foundation becomes icd11, ICD10WHO becomes icd10who
            if mapping.object.prefix in ("icd10who", "icd10", "icd11", "icd11.foundation"):
                # Store as (subject_curie, object_curie) tuple
                existing.add((
                    f"{mapping.subject.prefix}:{mapping.subject.identifier}",
                    f"{mapping.object.prefix}:{mapping.object.identifier}"
                ))

    print(f"\nFound {len(existing)} existing MONDO→ICD10WHO/ICD11 mappings")
    # Show breakdown
    icd10_existing = sum(1 for (s, o) in existing if "icd10" in o)
    icd11_existing = sum(1 for (s, o) in existing if "icd11" in o)
    print(f"  - {icd10_existing} existing MONDO→ICD10WHO mappings")
    print(f"  - {icd11_existing} existing MONDO→ICD11 mappings")
    return existing


def infer_new_mappings(mondo_mappings, who_mappings):
    """Merge and infer chains to find new mappings."""
    print("\nMerging all mappings...")
    all_mappings = mondo_mappings + who_mappings
    print(f"  Total mappings before inference: {len(all_mappings)}")

    print("\nInferring reverse mappings (for bidirectional chains)...")
    all_mappings = infer_reversible(all_mappings, progress=True)
    print(f"  Total mappings after reversible inference: {len(all_mappings)}")

    print("\nAssembling evidences (merging duplicate mappings)...")
    all_mappings = assemble_evidences(all_mappings, progress=True)
    print(f"  Total unique mappings: {len(all_mappings)}")

    print("\nInferring chains (transitive closure)...")
    inferred_mappings = infer_chains(
        all_mappings,
        backwards=True,  # Allow bidirectional inference
        progress=True,
        cutoff=3,  # Max chain length (e.g., MONDO→ICD10→ICD11)
        minimum_component_size=2,
        maximum_component_size=1000,
    )
    print(f"  Total mappings after chain inference: {len(inferred_mappings)}")

    return inferred_mappings


def filter_new_mondo_to_icd(inferred_mappings, existing_mappings):
    """Filter for only NEW MONDO→ICD10WHO/ICD11Foundation mappings."""
    new_mappings = []

    for mapping in inferred_mappings:
        # Only keep MONDO as subject
        if mapping.subject.prefix != "mondo":
            continue

        # Only keep ICD10WHO or ICD11Foundation as object
        # Note: semra normalizes prefixes
        if mapping.object.prefix not in ("icd10who", "icd10", "icd11", "icd11.foundation"):
            continue

        # Check if it's new
        pair = (
            f"{mapping.subject.prefix}:{mapping.subject.identifier}",
            f"{mapping.object.prefix}:{mapping.object.identifier}"
        )

        if pair not in existing_mappings:
            new_mappings.append(mapping)

    return new_mappings


def main():
    mondo_path = "mappings/mondo.sssom.tsv"
    who_path = "mappings/who-icd10-to-icd11.sssom.tsv"
    output_path = "mappings/inferred_mondo_icd_new.sssom.tsv"

    # Load mappings
    mondo_mappings, who_mappings = load_mappings(mondo_path, who_path)

    # Get existing MONDO→ICD mappings for filtering
    existing_mappings = get_existing_mondo_to_icd_mappings(mondo_mappings)

    # Infer new mappings through chain reasoning
    inferred_mappings = infer_new_mappings(mondo_mappings, who_mappings)

    # Filter for NEW MONDO→ICD mappings
    print("\nFiltering for new MONDO→ICD10WHO/ICD11Foundation mappings...")
    new_mappings = filter_new_mondo_to_icd(inferred_mappings, existing_mappings)
    print(f"  Found {len(new_mappings)} NEW mappings!")

    # Show breakdown by target
    icd10_count = sum(1 for m in new_mappings if "icd10" in m.object.prefix)
    icd11_count = sum(1 for m in new_mappings if "icd11" in m.object.prefix)
    print(f"    - {icd10_count} new MONDO→ICD10WHO mappings")
    print(f"    - {icd11_count} new MONDO→ICD11Foundation mappings")

    # Show some examples
    if new_mappings:
        print("\nExample new mappings (first 10):")
        for i, mapping in enumerate(new_mappings[:10], 1):
            print(f"  {i}. {mapping.subject.prefix}:{mapping.subject.identifier} "
                  f"→ {mapping.predicate.identifier} → "
                  f"{mapping.object.prefix}:{mapping.object.identifier}")
            if mapping.evidence:
                ev = mapping.evidence[0]
                if hasattr(ev, 'mappings') and ev.mappings:
                    chain = " → ".join([
                        f"{m.subject.prefix}:{m.subject.identifier}"
                        for m in ev.mappings
                    ] + [f"{ev.mappings[-1].object.prefix}:{ev.mappings[-1].object.identifier}"])
                    print(f"      Chain: {chain}")

    # Write output
    if new_mappings:
        print(f"\nWriting new mappings to {output_path}...")
        semra.io.write_sssom(
            new_mappings,
            output_path,
            add_labels=False,  # Don't fetch labels (speeds up writing)
        )
        print(f"  Done! Output written to {output_path}")
        print(f"\nNote: The output file contains inferred mappings from semra chain reasoning.")
        print(f"These mappings were derived from existing MONDO mappings and WHO ICD10-ICD11 bridge mappings.")
    else:
        print("\nNo new mappings found.")

    return 0


if __name__ == "__main__":
    sys.exit(main())
