#!/usr/bin/perl
my $n;
my $ch = 0;
my %smap = ();
while(<>) {
    chomp;
    if (m@^(MONDO:\d+) \! (.*)\t(.*)@) {
        $smap{$1} = $3;
    }
    else {
        print "$_\n";
        last;
    }
}
my $id;
while (<>) {
    chomp;
    if (m@^id: (\S+)@) {
        $id = $1;
    }
    if (m@^synonym: "(.*)" RELATED (.*)@) {
        my ($syn,$rest) = ($1,$2);
        my $csyn = $smap{$id};
        if ($csyn && lc($csyn) eq lc($syn)) {
            $_ = 'synonym: "'.$smap{$id}.'" EXACT '.$rest;
            $ch++;
        }
    }
    print "$_\n";
}
print STDERR "CHANGES: $ch\n";

=head1

blip-findall  -r mondoe "entity_synonym_scope(E,S,exact),entity_synonym_scope(E,S,related),downcase_atom(S,Sd),\+((entity_synonym_scope(E2,S2,_),downcase_atom(S2,Sd),E2\=E))" -label -select "x(E,S)" -no_pred  > x

=cut
