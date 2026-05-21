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
    # R1 is suffix-anchored, so "type II" here is NOT a suffix -> no R1 match.
    # The fully-lowercased variant is suppressed because the source contains
    # the multi-char roman "II" (and "Mobitz" if it ends up in the proper-noun
    # list). No assertion about positive output — see also
    # test_rlower_skips_multichar_roman.
    assert all("type ii" not in v for v in out)


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


def test_r1b_skips_compound_numerals():
    # Regression: "grade 1/2" must NOT become "grade 1/II". The trailing
    # token must be standalone (preceded by whitespace or start-of-string).
    out = variants_for("digestive system neuroendocrine tumor, grade 1/2")
    assert "digestive system neuroendocrine tumor, grade 1/II" not in out
    out2 = variants_for("cervical intraepithelial neoplasia grade 2/3")
    assert "cervical intraepithelial neoplasia grade 2/III" not in out2


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
    # Unidirectional: `type-N` -> `type N`, never the reverse.
    out = variants_for("disease type 2")
    assert "disease type-2" not in out
    out2 = variants_for("disease type-II")
    assert "disease type II" in out2


def test_rlower_skips_indicator_plus_single_letter_roman():
    restore = _with_proper_nouns(set())
    try:
        # `type I` -> would lowercase to `type i`, which reads as a roman
        # numeral in context. The indicator-prefix branch must suppress it.
        out = variants_for("Hailey-Hailey disease type I")
        assert "hailey-hailey disease type i" not in out
        out2 = variants_for("ovarian cancer stage IV")
        assert "ovarian cancer stage iv" not in out2  # multi-char also blocked
        out3 = variants_for("complement factor V deficiency")
        assert "complement factor v deficiency" not in out3
    finally:
        restore()


def test_no_propagation_of_miscased_proper_noun():
    # Source label has the eponym in lowercase ("sertoli") — quirky MONDO
    # casing. R8 must NOT propagate it into a new "sertoli ... tumour".
    restore = _with_proper_nouns({"Sertoli"})
    try:
        out = variants_for("ovarian sertoli-stromal cell tumor")
        assert all("sertoli" not in v for v in out), out
    finally:
        restore()


def test_rlower_skips_suffix_single_letter_roman():
    restore = _with_proper_nouns(set())
    try:
        # Direct: label already ending in single-letter `I`.
        out = variants_for("glycogen storage disease I")
        assert "glycogen storage disease i" not in out
        # Indirect: R1b converts the trailing `1` -> `I`, and the lowercase
        # of THAT variant must also be blocked.
        out2 = variants_for("vertigo, benign recurrent, 1")
        assert "vertigo, benign recurrent, i" not in out2
        # V at end
        out3 = variants_for("orofaciodigital syndrome V")
        assert "orofaciodigital syndrome v" not in out3
        # R1b converting `, 10` -> `, X`: the trailing-X carve-out must
        # NOT let this lowercase through.
        out4 = variants_for("prostate cancer, hereditary, 10")
        assert "prostate cancer, hereditary, x" not in out4
        # But naturally-occurring trailing X (chromosome) still lowercases.
        out5 = variants_for("trisomy X")
        assert "trisomy x" in out5
    finally:
        restore()


def test_multichar_roman_with_trailing_letters():
    # `IIa`, `IIx`, `IIIb` etc. should also block the lowercase chain.
    restore = _with_proper_nouns(set())
    try:
        out = variants_for("congenital disorder of glycosylation, type i/IIx")
        assert "congenital disorder of glycosylation, type i/iix" not in out
        out2 = variants_for("some condition IIIa")
        assert "some condition iiia" not in out2
    finally:
        restore()


def test_rlower_still_allows_single_letter_without_indicator():
    restore = _with_proper_nouns(set())
    try:
        # `X chromosome` has X but no preceding indicator -> lowercase OK.
        out = variants_for("X chromosome thing")
        assert "x chromosome thing" in out
    finally:
        restore()


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
    # Pin the proper-noun set to empty so this test isolates the
    # multi-char-roman lowercase filter and isn't sensitive to whatever's
    # in lexical_variant_proper_nouns.txt on disk.
    restore = _with_proper_nouns(set())
    try:
        out = variants_for("Charcot-Marie-Tooth disease type II")
        # multi-char roman "II" in source -> RL chain skipped for that
        # string, but R1+RL still fires because "type 2" is romanless.
        assert "charcot-marie-tooth disease type ii" not in out
        assert "charcot-marie-tooth disease type 2" in out
    finally:
        restore()


def test_rlower_skips_multichar_roman():
    out = variants_for("Mobitz type II atrioventricular block")
    # source contains "II" -> never lowercase the form that still has II.
    assert "mobitz type ii atrioventricular block" not in out


def test_rlower_keeps_single_letter_X():
    # Chromosome X / single-letter X should still get a lowercase variant.
    out = variants_for("X chromosome thing")
    assert "x chromosome thing" in out


def _with_proper_nouns(nouns):
    """Temporarily swap in a proper-noun set for a test. Returns a cleanup
    callable. The matcher does case-insensitive lookup, so we lowercase
    here too to match what `_load_proper_nouns` does on disk."""
    saved = lv._PROPER_NOUNS_CACHE
    lv._PROPER_NOUNS_CACHE = frozenset(n.lower() for n in nouns)
    def restore():
        lv._PROPER_NOUNS_CACHE = saved
    return restore


def test_rlower_skips_when_proper_noun_present():
    restore = _with_proper_nouns({"Crohn"})
    try:
        out = variants_for("Crohn disease, type 4")
        assert "crohn disease, type 4" not in out
        # The "Crohn disease, type IV" R1 variant should still be present
        # because R1 only swaps the digit, not the case.
        assert "Crohn disease, type IV" in out
    finally:
        restore()


def test_proper_noun_check_strips_possessive():
    restore = _with_proper_nouns({"Crohn"})
    try:
        out = variants_for("Crohn's disease")
        assert "crohn's disease" not in out
    finally:
        restore()


def test_proper_noun_check_handles_hyphenated_tokens():
    restore = _with_proper_nouns({"Sertoli", "Leydig"})
    try:
        out = variants_for("malignant Sertoli-Leydig cell tumor")
        assert "malignant sertoli-leydig cell tumor" not in out
    finally:
        restore()


def test_proper_noun_check_matches_compound_entry():
    # With "Boyadjiev-Jabs" stored as a single compound entry, the matcher
    # must still fire on a label that uses it.
    restore = _with_proper_nouns({"Boyadjiev-Jabs"})
    try:
        out = variants_for("Boyadjiev-Jabs syndrome")
        assert "boyadjiev-jabs syndrome" not in out
    finally:
        restore()


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
    # MONDO:0000001 should get "Disease type 2" (R1) and the R1+RL chain
    # "disease type 2". The "disease type ii" RL variant is suppressed by
    # the multi-char-roman lowercase filter.
    assert 'synonym: "Disease type 2" EXACT [MONDO:LexicalVariation]' in text
    assert 'synonym: "disease type 2" EXACT [MONDO:LexicalVariation]' in text
    assert 'disease type ii' not in text
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
