# MONDO synonyms that are misspellings but not marked `MISSPELLING`

**Source:** `mondo.obo`, release `2026-07-06` (95,023 synonyms across 35,996 non-obsolete `MONDO:` classes).
**Method:** within each class, compare every *untyped* synonym against the class's own label and other synonyms; treat a difference as a **misspelling candidate** only if the two names are still within edit-distance 1 (or a single adjacent transposition) *after* normalizing away legitimate variation (accents, UK/US spelling, hyphen/space/punctuation, roman↔arabic numerals, Latin/English plural and noun↔adjective morphology). Then auto-classify each surviving candidate by *what the single edit is*.

## Headline

MONDO defines a `MISSPELLING` synonym type but **only 2 synonyms in the entire ontology currently use it** (`holocarboxylase synthase deficiency`, `intellectual disability, XMEN-linked 88`). The misspelling population is essentially entirely unmarked.

The scan surfaced **852 untyped near-duplicate synonyms**, which classify as:

| Category | Count | Misspelling? |
|---|---:|---|
| **Genuine typo** | 367 raw → **138 unique** (52 vs label, 86 vs a sibling synonym) | **Yes — candidates for `MISSPELLING`** |
| UK/US spelling (`foetal`, `caecum`, `tumour`, `naevus`, `pheochromocytoma`) | 265 | No — should be `OMO:0003005` (UK spelling) |
| Acronym / sibling-code differences (`TRH`/`TRF`, `ASL`/`ASA`, `M6a`/`M6b`) | 111 | No — distinct entities |
| `disk` / `disc` | 57 | No — both valid |
| `c` / `k` (`phako`/`phaco`, `pycno`/`pykno`) | 25 | No — both valid |
| `i` / `y` (`piri`/`pyri`) | 19 | No — both valid |
| Numbered subtype codes | 8 | No |

For context, MONDO already tags **5,922** UK-spelling synonyms with `OMO:0003005` — so the 265 untyped UK spellings are a genuine tagging gap, but a *different* one from misspellings.

## The 138 genuine-typo candidates

Full machine-readable list: `typos_final.tsv` (columns: `mondo_id`, `term_label`, `correct_form`, `misspelled_synonym`, `anchor`).

### Highest confidence — label-anchored (the class's own label is the correct form)

Unambiguous single-letter typos (a curator would tag `MISSPELLING` on sight):

- `Congential` → congenital aortic valve insufficiency
- `congenitla` → facial palsy, congenital, …
- `infaracts` → cerebral arteriopathy with subcortical **infarcts** … (CADASIL)
- `accululation` → neurodegeneration with brain iron **accumulation** 5
- `Paroxysomal` → **paroxysmal** nonkinesigenic dyskinesia
- `Sulfemoglobinemia` → **sulfhemoglobinemia**
- `essential thrombocytemia` → **thrombocythemia**
- `gluthathione` → **glutathione** peroxidase deficiency
- `Camurati-Englemann` → Camurati-**Engelmann** disease
- `Axenfeldt-Rieger` → **Axenfeld**-Rieger syndrome
- `Boerhave` → **Boerhaave** syndrome
- `Bonnevie-Ulrich` → Bonnevie-**Ullrich** syndrome
- `Li-Ghorgani-…` → Li-**Ghorbani**-Weisz-Hubshman syndrome
- `ondontochondrodysplasia` → **odontochondrodysplasia** 2 …
- `otospondylmegaepiphyseal` → **otospondylo**megaepiphyseal dysplasia
- `spondylocarpostarsal` → **spondylocarpotarsal** fusion syndrome 1A
- `Vernal Keratonconjunctivitis` → **keratoconjunctivitis**
- `tonsilitis` → **tonsillitis**
- `Polyrhinia` → **polyrrhinia**
- `proteosome-associated…` → **proteasome**-associated autoinflammatory syndrome  ⚠️ *the primary label is the misspelling*

Borderline in this bucket (arguably accepted variant spellings rather than errors — curator judgment): `pseudarthrosis`/pseudoarthrosis (×6), `tendonitis`/tendinitis, `sialoadenitis`/sialadenitis, `spondylarthropathy`/spondyloarthropathy, `pilomatricoma`/pilomatrixoma, `lung hilus`/hilum (×3), `hyperexplexia`/hyperekplexia, `lipid proteinosis`/lipoid.

### Synonym-anchored (neither side is the label; both are synonyms)

Notable clean typos:

- **`wooly` → `woolly` hair** — the single largest cluster: ~30 synonyms across the woolly-hair / keratoderma-cardiomyopathy disease family all carry `wooly`.
- `Mediterraneanl` → Mediterranean lymphoma
- `Arthogryposis` → arthrogryposis
- `mineral duct` → mineral **dust** pneumoconiosis
- `Strept throat` → Strep throat
- `sydrome` → syndrome
- `Maligant` / `Beryllliosis` / `Perenial` / `ichtyosis` / `hypertropic` / `triations`(→striations) / `choanal atrsia` / `neurdegeneration` / `none-erupting`(→non) / `Deficincy` / `Epitherlioma`(→epithelioma) / `Neurogastrointestingal`
- `Somatotrophinoma` → somatotropinoma (×5), `gammapathy` → gammopathy, `renal Glycosuria` → glucosuria
- Eponym typos: `Kallman`→Kallmann, `Bechet`→Behcet, `Elsching`→Elschnig, `howel-Evans`→Howell, `Werdnig-Hoffman`→Hoffmann, `Minorbs`→Minor's, `bonnet-Decaume`→Dechaume, `Carotodynia`→Carotidynia
- Wrong word: `abductor` vs `adductor spasmodic dysphonia`, `S penetrans` vs `T penetrans`

A few residual non-typos survive here (e.g. `Kenya`/`Kenyan`, `spastic paraplegia 3`/`3a`) — dropped on final human review.

## Method limitations (recall)

This is a **high-precision, bounded-recall** approach. It only finds a misspelling when MONDO *also* carries a correctly-spelled name for the same class to compare against, and only within one edit / one transposition. It therefore **misses**:
- misspellings on a class whose only names are all mis-spelled (nothing to compare to),
- multi-error misspellings (edit distance ≥ 2 that aren't a single transposition).

Catching those is the domain of a dictionary/spell-checker sweep — which is essentially **Step 2** (common misspellings *not yet in* MONDO).

## Reproduce

```
python3 detect_misspellings.py mondo.obo   # -> candidates.tsv
python3 classify.py                        # -> classified.tsv (category per candidate)
python3 finalize_typos.py                  # -> typos_final.tsv (deduped genuine typos)
```

---

# Step 2 — common misspellings NOT yet in MONDO (candidates to add)

**Goal:** surface frequently-typed misspellings of well-known diseases that MONDO
does **not** currently carry as any synonym, so they could be added (as
`MISSPELLING` synonyms) to improve search/lookup recall.

**Method:** a curated seed of documented lay/phonetic misspellings for 62
high-prevalence conditions, each checked programmatically against the full set of
143k MONDO names (labels + synonyms, MONDO classes only). Kept only those (a)
absent from MONDO and (b) whose *correct* term resolves to a real MONDO class
(ID captured). Result: **250 candidate misspellings across 62 diseases**
(`step2_candidates.tsv`).

**Grounding.** "Common" here is anchored to documented usage, not invented:
- Dellavalle et al., *Common Misspellings and Their Impact on Health Sciences
  Literature Search Results* (J Hosp Librariansh, 2023) documents the pattern and
  its top offenders (`arrhythmia`, `ophthalmology`, `pruritus`, `hemorrhage`,
  `syphilis`, `ilium`/`ileum`).
- The misspellings occur in real biomedical text — e.g. a PMC case-report title
  reads "Guillian-Barré syndrome" — which is precisely MONDO's stated rationale
  for the type: *"recorded for consistency with another source but is a misspelling."*

**Recommendation on scope:** MONDO curators should validate frequency against
search-log / "did-you-mean" data before bulk-adding; treat this list as vetted
*candidates*, tiered:

### Tier A — classic, high-frequency misspellings (strongest add candidates)
`prostrate cancer` (prostate cancer, MONDO:0005159); `chrons disease`/`chron disease`
(Crohn disease, MONDO:0005011); `diabetis`/`diabeties` (diabetes mellitus);
`arthritus` (arthritis); `hemroid`/`hemorroid` (hemorrhoid, MONDO:0004872);
`guillian-barre`/`gullian-barre` (Guillain-Barré, via MONDO GBS class);
`asma`/`athsma` (asthma); `siphilis`/`sifilis`/`syphillis` (syphilis, MONDO:0005976);
`sjogrens`/`sjorgens` (Sjögren); `cerebal palsy`/`cerebral palsey` (cerebral palsy,
MONDO:0006497); `alzeimers`/`altzheimers` (Alzheimer disease, MONDO:0004975);
`parkisons`→`parkison` (Parkinson disease); `tay-sachs desease`; `wilsons disease`.

### Tier B — plausible generated variants (need frequency confirmation)
The remaining phonetic/keyboard variants (`ashma`, `siyatica`, `meazles`,
`gonorreaha`, `epalepsy`, …). Real but lower-frequency; confirm before adding.

### Tier C — informal apostrophe/possessive forms (style, not strictly typos)
`parkinsons disease`, `huntingtons disease`, `tourettes syndrome`,
`downs syndrome`, `wilsons disease`. Common in lay usage; MONDO uses the
non-possessive label, so these are arguably worth adding but as a distinct class
from true misspellings.

**Method limitation:** the seed is hand-curated (high precision, bounded
coverage). A complete Step-2 sweep would apply an empirical typo model + a
frequency corpus (search logs) across *all* MONDO labels — out of scope here but
the natural next iteration.
