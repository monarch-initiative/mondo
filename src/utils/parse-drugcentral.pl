#!/usr/bin/perl
while(<>) {
    last if m@^COPY public.omop_relationship@;

}
while(<>) {
    chomp;
    #my @f = split(/\t/, $_);
    last if m@^\\\.$@;
    print "$_\n";

}

=head1


COPY public.omop_relationship (id, struct_id, concept_id, relationship_name, concept_name, umls_cui, snomed_full_name, cui_semantic_type, snomed_conceptid) FROM stdin;
173432  965     40249340        indication      Malignant tumor of breast       C0006142        Malignant tumor of breast       T191    254837009
173433  318     21000716        indication      Gout    C0018099        Gout    T047    90560007
173434  318     21003276        indication      Hyperuricemia   C0740394        Hyperuricemia   T047    35885006
173435  1031    21001432        indication      Hypertensive disorder   C0020538        Hypertensive disorder   T047    38341003
173397  5226    21001068        indication      Tardive dyskinesia      C0686347        Tardive dyskinesia      T047    102449007
173398  5253    21002338        indication      Urinary tract infection caused by Klebsiella    C4076057        Urinary tract infection caused by Klebsiella    T047    \N
173399  5253    21002327        indication      Escherichia coli urinary tract infection        C0577708        Escherichia coli urinary tract infection        T047    301011002
173400  5256    40249311        indication      Follicular lymphoma     C0024301        Follicular lymphoma     T191    55150002
173401  2427    21002473        indication      Bacterial vaginosis     C0085166        Bacterial vaginosis     T047    419760006
173402  5257    40249281        indication      Ischemic stroke C0948008        Ischemic stroke T047    422504002

=cut


    
