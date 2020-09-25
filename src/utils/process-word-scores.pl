#!/usr/bin/perl

my @override = qw(
    Disease
    Diseases
    Syndrome
    SYNDROME
    Tumor
    TUMOR
    Cell
    CELL
    CANCER
    Cancer
    Pneumonias
    Dysmetrias
    Lung
    RIGHT
    LEFT
    VENTRICULAR
    GREAT
    Great
    POSTERIOR
    GLUCOSE
    FUSED
    SVEINSSON
    ATRIOVENTRICULAR
    TRANSPORT
    BLEPHARONASOFACIAL
    HYPOPLASIA
    HYPERTROPHY

    Agnosias
    Pure
    Fallopian
    Ocular
    Biliary
    Papilloma
    Schwannoma
    Blastic
    Deficiency

    Pulmonary
    Corpus
    Canal
    Blood
    Sinus

    Rich
    Small
    Middle
    Adult
    Ring
    High
    Type
    Non
    Not

    fiedler
    edict
    canvas
    Steel
    );

my %overh = map {($_=>1)} @override;

my $last;
while(<>) {
    my ($nf,$w,$s,$c) = split(/\t/, $_);
    next if $overh{$w};
    if ($last ne $nf) {
        summarize();
    }
    push(@rawscores, [$w, $s, $c]);
    $last = $nf;
}
summarize();

exit 0;

sub summarize {

    my $n=0;
    my %form2scores = ();
    foreach (@rawscores) {
        my ($w, $s, $c) = @$_;
        push(@{$form2scores{$w}}, $s);
    }
    my @results = ();
    foreach my $form (keys %form2scores) {
        my $scores = $form2scores{$form};
        my $sum = 0;
        my $min=999;
        my $max=0;
        next unless @$scores;
        foreach (@$scores) {
            $sum += $_;
            if ($_ < $min) {
                $min = $_;
            }
            if ($_ > $max) {
                $max = $_;
            }
        }
        my $avg = $sum / scalar(@$scores);
        if ($max > 2) {
            push(@results, [$form, $min, $max, $avg]);
        }
    }
    my $ambiguous = "IS_AMBIGUOUS";
    if (scalar(@results) == 1) {
        $ambiguous = "NOT_AMBIGUOUS";
    }
    foreach my $result (@results) {
        print join("\t", @{$result});
        print "\t$ambiguous\n";
    }
    @rawscores = ();
}
