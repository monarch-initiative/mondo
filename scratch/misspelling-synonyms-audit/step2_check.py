#!/usr/bin/env python3
"""Step 2: check curated common disease misspellings against MONDO.
Report those ABSENT from MONDO (candidates to add), with the MONDO id of the
correct term."""
import re, unicodedata, sys
def acc(s): return "".join(c for c in unicodedata.normalize("NFKD", s) if not unicodedata.combining(c))
def norm(s): return re.sub(r"\s+"," ", acc(s).lower().strip())

name2id={}; allnames=set()
syn_re=re.compile(r'^synonym:\s+"((?:[^"\\]|\\.)*)"')
cur=None; cid=None; clabel=None
with open("mondo.obo") as f:
    for line in f:
        line=line.rstrip("\n")
        if line=="[Term]": cur=True; cid=None; clabel=None; continue
        if line.startswith("[") and line!="[Term]": cur=None; continue
        if not cur: continue
        if line.startswith("id: "): cid=line[4:].strip()
        elif line.startswith("name: "):
            clabel=line[6:].strip()
            if cid and cid.startswith("MONDO:"):
                allnames.add(norm(clabel)); name2id.setdefault(norm(clabel),(cid,clabel))
        elif line.startswith("synonym: "):
            m=syn_re.match(line)
            if m and cid and cid.startswith("MONDO:"):
                s=norm(m.group(1).replace('\\"','"'))
                allnames.add(s)
                # map a synonym to its MONDO class+label so seed terms that are
                # synonyms (eczema, shingles) still resolve to a MONDO id
                name2id.setdefault(s,(cid,clabel))

# curated seed: (correct term as it appears in MONDO, [common misspellings])
SEED = [
 ("asthma", ["asma","athsma","asthama","ashma","astma"]),
 ("diabetes mellitus", []),
 ("diabetes", ["diabetis","diabeties","diabetus","diabetees","diabetes melitus","diabetis mellitus"]),
 ("pneumonia", ["newmonia","pnumonia","pnemonia","pneumonia ","pneumona","neumonia"]),
 ("Alzheimer disease", ["alzeimers disease","altzheimers disease","alzhiemer disease","alzeimer disease","alzheimers desease"]),
 ("Parkinson disease", ["parkinsons disease","parkison disease","parkinson's desease","parkingson disease"]),
 ("leukemia", ["leukimia","lukemia","leukema","luekemia","leukiemia"]),
 ("psoriasis", ["soriasis","psorisis","sorisis","psoriaisis","psriasis"]),
 ("eczema", ["exczema","ekzema","eczma","exzema","eggzema"]),
 ("gonorrhea", ["gonorreah","gonorhea","gonorrea","gonnorhea","gonhorrea","gonorreaha"]),
 ("syphilis", ["syphillis","siphilis","syphilus","sifilis","syphlis","syphillus"]),
 ("hemorrhoid", ["hemroid","hemorroid","hemorhoid","hemmoroid","haemorroid"]),
 ("diarrhea", ["diarhea","diarrea","diahrrea","diarreah","diarhoea"]),
 ("arthritis", ["arthritus","arthiritis","athritis","arthrytis","arthirtis"]),
 ("migraine", ["migrane","migraene","migrain","migrainne","migreine"]),
 ("schizophrenia", ["schizophernia","skitzophrenia","schitzophrenia","schizofrenia","schizoprenia"]),
 ("tuberculosis", ["tuberculosus","tubercolosis","tubersculosis","tuburculosis"]),
 ("fibromyalgia", ["fibromialgia","fibromyaglia","fibermyalgia","fibromyalga"]),
 ("epilepsy", ["epilepsi","epillepsy","epalepsy","epilipsy","epelepsy"]),
 ("multiple sclerosis", ["multiple schlerosis","multiple sclerois","multiple sclorosis"]),
 ("meningitis", ["meningitus","menningitis","meningites","meningtis"]),
 ("bronchitis", ["bronchitus","broncitis","brochitis","bronchities"]),
 ("hepatitis", ["hepititis","hepatitus","hepetitis","hepatities"]),
 ("cirrhosis", ["cirosis","cirrosis","cirrohsis","sirrhosis","cirhosis"]),
 ("glaucoma", ["glacoma","glaukoma","glacuoma","glaocoma"]),
 ("osteoporosis", ["osteoperosis","osteoporosos","ostioporosis","osteoprosis","osteporosis"]),
 ("influenza", ["influensa","influena","infuenza","influeza"]),
 ("measles", ["measels","meesles","meazles","measales"]),
 ("appendicitis", ["appendicitus","apendicitis","appendisitis","appendicites"]),
 ("diverticulitis", ["diverticulitus","divirticulitis","diverticulits"]),
 ("sciatica", ["syatica","siatica","schiatica","siyatica","sciatca"]),
 ("endometriosis", ["endometriosus","endometreosis","endrometriosis","endometrios"]),
 ("rheumatoid arthritis", ["rheumetoid arthritis","rhumatoid arthritis","rheumatiod arthritis","rheumotoid arthritis"]),
 ("melanoma", ["melanona","melenoma","melanomia","melinoma"]),
 ("dementia", ["dementiia","dimentia","dementa","demensia"]),
 ("anemia", ["anemea","anemya","anaemea","aneamia"]),
 ("vertigo", ["vertico","vertago"]),
 ("chlamydia", ["clamidia","chlamidia","clamydia","chlymidia","chalmydia"]),
 ("herpes", ["herpies","herpese","hurpes"]),
 ("HIV infection", []),
 ("scoliosis", ["scoleosis","scholiosis","scoliois","skoliosis"]),
 ("psoriatic arthritis", ["psoriatic arthritus","soriatic arthritis"]),
 ("Tourette syndrome", ["tourettes syndrome","tourrette syndrome","torettes syndrome","tourette's syndrome"]),
 ("Crohn disease", ["chrons disease","chron disease","crohns desease","crohn's desease"]),
 ("celiac disease", ["celiacs disease","cileac disease","coeliacs disease"]),
 ("gout", ["goute"]),
 ("shingles", ["shingels"]),
 ("pertussis", ["pertusis","pertussus","pertusiss"]),
 ("hemophilia", ["hemophelia","hemofilia","haemophelia","hemophillia"]),
 ("leukemia, acute lymphoblastic", []),
 ("myocardial infarction", ["myocardial infarcation","myocardial infartion","myocardial infraction"]),
 ("hypothyroidism", ["hypthyroidism","hypothroidism","hypothyroidism ","hypothyrodism"]),
 ("hyperthyroidism", ["hyperthroidism","hyperthyrodism"]),
 ("Down syndrome", ["downs syndrome","down's syndrom"]),
 ("cystic fibrosis", ["cystic fibrosis ","sistic fibrosis","cystic fibrossis"]),
 ("prostate cancer", ["prostrate cancer"]),
 ("Achilles tendinitis", ["achilles tendonitis","achiles tendinitis"]),
 ("Wilson disease", ["wilsons disease","wilson's desease"]),
 ("varicella", ["varicela","varacella"]),
 # notoriously-misspelled eponymous / hard names
 ("Guillain-Barre syndrome", ["guillian-barre syndrome","gullian-barre syndrome","guillian barre syndrome","gullain-barre syndrome","guillaine-barre syndrome","gillian-barre syndrome"]),
 ("Ehlers-Danlos syndrome", ["ehler-danlos syndrome","elhers-danlos syndrome","ehlers danlos syndrom","ehler danlos syndrome","ehlers-danos syndrome"]),
 ("amyotrophic lateral sclerosis", ["amyotropic lateral sclerosis","amytrophic lateral sclerosis","amyotrophic lateral sclerosus"]),
 ("sickle cell anemia", ["sicle cell anemia","sickel cell anemia","sikle cell anemia"]),
 ("Kawasaki disease", ["kawaski disease","kawasaky disease","kawazaki disease"]),
 ("Sjogren syndrome", ["sjogrens syndrome","showgren syndrome","sjorgens syndrome","sjogren's syndrom","shogren syndrome"]),
 ("Huntington disease", ["huntingtons disease","huntingdon disease","hutington disease","huntinton disease"]),
 ("Duchenne muscular dystrophy", ["duchennes muscular dystrophy","duchene muscular dystrophy","duchenne muscular dystropy","duschenne muscular dystrophy"]),
 ("Tay-Sachs disease", ["tay sachs disease","taysachs disease","tay-sach disease","tay-sachs desease","taysachs desease"]),
 ("cerebral palsy", ["cerebal palsy","cerebral palsey","cerebral paulsy","celebral palsy"]),
 ("hypertension", ["hypertention","hyertension","hypertentions"]),
 ("chickenpox", ["chiken pox","chikenpox"]),
 ("eczema", ["exczema","ekzema","eczma","exzema","eggzema"]),
 ("shingles", ["shingels","shinges"]),
]

rows=[]
for correct,misspellings in SEED:
    ident=name2id.get(norm(correct))
    for ms in misspellings:
        if norm(ms) in allnames: continue    # already present
        rows.append((correct, ident[0] if ident else "?", ms))
# only keep ones whose correct term resolves in MONDO
rows=[r for r in rows if r[1]!="?"]
print(f"absent common misspellings (correct term in MONDO): {len(rows)}\n")
cur=None
for correct,mid,ms in rows:
    if correct!=cur: print(f"\n{correct}  [{mid}]"); cur=correct
    print(f"    + {ms}")
# also flag seeds whose 'correct' didn't resolve (so I can fix the seed)
missing=[c for c,_ in SEED if norm(c) not in name2id]
if missing: print("\n[seed correct-terms NOT found as a MONDO label]:", missing)
