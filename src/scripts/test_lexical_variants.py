"""Quick unit tests for lexical_variants.

Run:    python -m pytest src/scripts/test_lexical_variants.py
   or:  python src/scripts/test_lexical_variants.py
"""

from __future__ import annotations

import io
import textwrap
from pathlib import Path

import lexical_variants as lv


# ---- Rule-level tests -----------------------------------------------------


def variants_for(label):
    return {v: r for v, r in lv.generate_variants(label)}


def test_r1_arabic_to_roman():
    out = variants_for("spinocerebellar ataxia type 4")
    assert "spinocerebellar ataxia type IV" in out
    assert out["spinocerebellar ataxia type IV"] == "R1"


def test_r1_roman_to_arabic():
    out = variants_for("Mobitz type II atrioventricular block")
    # R1 is suffix-anchored, so "type II" here is NOT a suffix -> no R1 match
    # but lowercase should still produce a variant.
    assert "mobitz type ii atrioventricular block" in out


def test_r1_suffix_roman_to_arabic():
    out = variants_for("Charcot-Marie-Tooth disease type II")
    assert "Charcot-Marie-Tooth disease type 2" in out


def test_r1b_no_type_prefix_roman_to_arabic():
    out = variants_for("glycogen storage disease I")
    assert "glycogen storage disease 1" in out
    out2 = variants_for("orofaciodigital syndrome V")
    assert "orofaciodigital syndrome 5" in out2
    out3 = variants_for("Fanconi anemia complementation group V")
    assert "Fanconi anemia complementation group 5" in out3


def test_r1b_no_type_prefix_arabic_to_roman():
    out = variants_for("glycogen storage disease 1")
    assert "glycogen storage disease I" in out


def test_r1b_skips_trailing_X():
    # Single-letter X at suffix is dominated by chromosome-X usage in MONDO.
    # These must NOT be converted.
    for label in [
        "trisomy X",
        "monosomy X",
        "pentasomy X",
        "partial deletion of chromosome X",
    ]:
        out = variants_for(label)
        # No arabic-conversion variant
        assert all(" 10" not in v for v in out), f"trailing X wrongly converted for {label!r}: {out}"


def test_r1b_multi_char_X_still_works():
    # XI / XII at suffix should still convert (they were always safe).
    out = variants_for("some syndrome XI")
    assert "some syndrome 11" in out


def test_r2_comma_form_roman():
    out = variants_for(
        "cerebral arteriopathy, autosomal dominant, with subcortical infarcts and leukoencephalopathy, type 1"
    )
    assert any("type I" in k and k.endswith("type I") for k in out)


def test_r3_comma_drop():
    out = variants_for("disease X, type 2")
    assert "disease X type 2" in out


def test_r4_x_linked_hyphen_space():
    out = variants_for("X-linked mental retardation")
    assert "X linked mental retardation" in out
    out2 = variants_for("Y linked thing")
    assert "Y-linked thing" in out2


def test_r4_lowercase_xy_linked():
    # Defensive: should also fire on lowercase x-linked / y-linked labels,
    # preserving the original case via the backreference.
    out = variants_for("x-linked weird label")
    assert "x linked weird label" in out
    out2 = variants_for("y linked weird label")
    assert "y-linked weird label" in out2


def test_r10_celltype_hyphen_to_space():
    out = variants_for("mature T-cell and NK-cell non-Hodgkin lymphoma")
    # Both occurrences swap in one pass — no combinatorial blow-up.
    assert "mature T cell and NK cell non-Hodgkin lymphoma" in out


def test_r10_celltype_space_to_hyphen():
    out = variants_for("mature T cell lymphoma")
    assert "mature T-cell lymphoma" in out


def test_r10_celltype_does_not_hit_other_letters():
    # "A-cell" / "U-cell" etc. should NOT fire — we only accept T / B / NK.
    out = variants_for("A-cell weird disease")
    assert "A cell weird disease" not in out


def test_r5_xlinked_reorder_safe():
    out = variants_for("fetal akinesia syndrome, X-linked")
    assert "X-linked fetal akinesia syndrome" in out


def test_r5_xlinked_reorder_skips_multi_comma():
    # mental retardation, X-linked, nonsyndromic — the conservative R5 must
    # NOT produce "X-linked mental retardation nonsyndromic".
    out = variants_for("mental retardation, X-linked, nonsyndromic")
    assert all("X-linked mental retardation" not in k for k in out)


def test_r6_type_hyphen_space():
    out = variants_for("disease type 2")
    assert "disease type-2" in out
    out2 = variants_for("disease type-II")
    assert "disease type II" in out2


def test_r7_susceptibility_reorder():
    out = variants_for("microvascular complications of diabetes, susceptibility")
    assert "susceptibility to microvascular complications of diabetes" in out


def test_r7_reverse_direction():
    out = variants_for("susceptibility to malaria")
    assert "malaria, susceptibility" in out
    assert "malaria susceptibility" in out


def test_r8_british_american():
    out = variants_for("brain tumour")
    assert "brain tumor" in out
    out2 = variants_for("acute leukemia")
    assert "acute leukaemia" in out2


def test_r8_preserves_initial_capital():
    out = variants_for("Tumour syndrome")
    assert "Tumor syndrome" in out


def test_r8_does_not_mangle_compound_words():
    # Regression: "oesophag" must NOT match mid-word in "gastroesophageal"
    # and produce a corrupted "gastresophageal".
    out = variants_for("gastroesophageal junction adenocarcinoma")
    assert "gastresophageal junction adenocarcinoma" not in out


def test_r9_diacritics():
    out = variants_for("Möbitz syndrome")
    assert "Mobitz syndrome" in out


def test_rlower_label_and_chain():
    out = variants_for("Charcot-Marie-Tooth disease type II")
    assert "charcot-marie-tooth disease type ii" in out
    assert "charcot-marie-tooth disease type 2" in out  # R1+RL


def test_no_duplicates_from_label():
    # label already lowercase: no lowercase variant added.
    out = variants_for("foo bar")
    assert "foo bar" not in out  # excluded from outputs


def test_paren_qualifier_not_dropped():
    # R11 is excluded — make sure we never drop `(disorder)` etc.
    out = variants_for("blindness (disorder)")
    assert "blindness" not in out


# ---- OBO file-level tests -------------------------------------------------


SAMPLE_OBO = """\
format-version: 1.2

[Term]
id: MONDO:0000001
name: Disease type II
def: "A test." [PMID:1]
synonym: "old lex synonym" EXACT [MONDO:LexicalVariation]
synonym: "manual synonym" EXACT [PMID:2]
synonym: "shared synonym" EXACT [PMID:3, MONDO:LexicalVariation]
is_a: MONDO:9999999 ! root

[Term]
id: MONDO:0000002
name: obsolete thing
is_obsolete: true

[Term]
id: MONDO:0000003
name: X-linked thing
def: "A test." [PMID:1]
is_a: MONDO:9999999 ! root

[Term]
id: MONDO:0000004
name: condemned thing
subset: obsoletion_candidate
subset: rare
def: "A test." [PMID:1]
is_a: MONDO:9999999 ! root
"""


def write_sample(tmp_path):
    p = tmp_path / "edit.obo"
    p.write_text(SAMPLE_OBO)
    return p


def test_purge_drops_only_lex_only(tmp_path):
    in_path = write_sample(tmp_path)
    out_path = tmp_path / "out.obo"
    lv.run(in_path, out_path, do_purge=True, do_generate=False, report_path=None)
    text = out_path.read_text()
    assert 'synonym: "old lex synonym"' not in text
    assert 'synonym: "manual synonym"' in text
    # Shared synonym has more than one source, must be retained.
    assert 'synonym: "shared synonym"' in text


def test_generate_adds_for_live_terms_only(tmp_path):
    in_path = write_sample(tmp_path)
    out_path = tmp_path / "out.obo"
    lv.run(in_path, out_path, do_purge=False, do_generate=True, report_path=None)
    text = out_path.read_text()
    # MONDO:0000001 should get "Disease type 2" (R1) and lowercase variants.
    assert 'synonym: "Disease type 2" EXACT [MONDO:LexicalVariation]' in text
    assert 'synonym: "disease type ii" EXACT [MONDO:LexicalVariation]' in text
    # MONDO:0000002 is obsolete — no synonyms should be added to it. The
    # generated block should sit on the live term only.
    assert "obsolete thing" in text
    # MONDO:0000003 has an X-linked label.
    assert 'synonym: "X linked thing" EXACT [MONDO:LexicalVariation]' in text
    # MONDO:0000004 is an obsoletion candidate; no synonyms should be added.
    cond_block = text.split("MONDO:0000004")[1]
    next_term_split = cond_block.split("[Term]")[0] if "[Term]" in cond_block else cond_block
    assert "MONDO:LexicalVariation" not in next_term_split


def test_full_pipeline_is_idempotent(tmp_path):
    in_path = write_sample(tmp_path)
    out_path = tmp_path / "out.obo"
    lv.run(in_path, out_path, do_purge=True, do_generate=True, report_path=None)
    first = out_path.read_text()
    # Re-run on the output.
    lv.run(out_path, out_path, do_purge=True, do_generate=True, report_path=None)
    second = out_path.read_text()
    assert first == second


def test_report_written(tmp_path):
    in_path = write_sample(tmp_path)
    out_path = tmp_path / "out.obo"
    report_path = tmp_path / "report.tsv"
    lv.run(in_path, out_path, do_purge=True, do_generate=True, report_path=report_path)
    rep = report_path.read_text().splitlines()
    assert rep[0].split("\t") == ["term_id", "label", "generated_synonym", "rule_id"]
    # at least one R1 row from "Disease type II"
    assert any("\tR1\n" in (line + "\n") for line in rep[1:])


if __name__ == "__main__":
    # Minimal runner so you don't need pytest installed.
    import inspect
    import tempfile
    import traceback

    tests = [
        (name, obj)
        for name, obj in globals().items()
        if name.startswith("test_") and callable(obj)
    ]
    failures = 0
    for name, fn in tests:
        try:
            sig = inspect.signature(fn)
            if "tmp_path" in sig.parameters:
                with tempfile.TemporaryDirectory() as td:
                    fn(Path(td))
            else:
                fn()
            print(f"OK   {name}")
        except Exception:
            failures += 1
            print(f"FAIL {name}")
            traceback.print_exc()
    print(f"\n{len(tests) - failures}/{len(tests)} passed")
    raise SystemExit(1 if failures else 0)
