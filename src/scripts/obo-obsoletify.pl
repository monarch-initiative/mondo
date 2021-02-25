#!/usr/bin/perl -w

use strict;
my %tag_h=();
my $negate = 0;
my $typedef = 1;
my $show_header = 1;
my $obsidfile;
my $replfile;
my @obsids = ();
my $seeAlso;
while ($ARGV[0] =~ /^\-/) {
    my $opt = shift @ARGV;
    if ($opt eq '-h' || $opt eq '--help') {
        print usage();
        exit 0;
    }
    elsif ($opt eq '--typedef') {
        $typedef = 1; # now the default
    }
    elsif ($opt eq '--no-typedef') {
        $typedef = 0;
    }
    elsif ($opt eq '--no-header') {
        $show_header = 0;
    }
    elsif ($opt eq '-i' || $opt eq '--idfile') {
        $obsidfile = shift @ARGV;
    }
    elsif ($opt eq '-r' || $opt eq '--replacementfile') {
        $replfile = shift @ARGV;
    }
    elsif ($opt eq '-l' || $opt eq '--idlist') {
        @obsids = split(/,/,shift @ARGV);
    }
    elsif ($opt eq '-n' || $opt eq '--negate') {
        $negate = 1;
    }
    elsif ($opt eq '-s' || $opt eq '--seeAlso') {
        $seeAlso = shift;
    }
    elsif ($opt eq '-t' || $opt eq '--tag') {
        $tag_h{shift @ARGV} = 1;
    }
    elsif ($opt eq '-') {
    }
    else {
        die "$opt";
    }
}
#if (!@ARGV) {
#    print usage();
#    exit 1;
#}
print STDERR "Tags: ", join(', ',keys %tag_h),"\n";
my %logictag = (
    is_a => 1,
    intersection_of => 1,
    disjoint_from => 1,
    relationship => 1
    );

if ($obsidfile) {
    open(F,$obsidfile) || die $obsidfile;
    while(<F>) {
        chomp;
        s/^\s+//;
        s/\s+$//;
        push(@obsids, $_);
    }
    close(F);
}

my %rmap = ();
if ($replfile) {
    open(F,$replfile) || die $replfile;
    while(<F>) {
        chomp;
        s/^\s+//;
        s/\s+$//;
        my ($id, $repl) = split(/ /);
        push(@obsids, $id);
        $rmap{$id} = $repl;
        print STDERR "$id --> $repl\n";
    }
    close(F);
}


my $id;
my $n;
my $is_obs = 0;
my @lines = <>;
my %obsh = map {($_=>1)} @obsids;

my %isah = ();
foreach (@lines) {
    if (m@^id:\s+(\S+)@) {
        $id = $1;
    }    
    elsif (m@^is_a:\s+(\S+)@) {
        $isah{$id}->{$1}++;
    }    
}
foreach (@lines) {
    chomp;

    # rewire isas
    if (m@is_a: (\S+)(.*)@) {
        my $is_a = $1;
        my $rest = $2;
        my @is_as = replace_isa($is_a);
        if (@is_as != 1 || $is_as[0] ne $is_a) {
            $_ = join("\n", (map {"is_a: $_ {source=\"$is_a-obsoleted\"}"} @is_as));
        }
    }
    
    if (m@^id:\s+(\S+)@) {
        $id = $1;
        if (grep {$_ eq $id} @obsids) {
            $is_obs = 1;
        }
        else {
            $is_obs = 0;
        }
    }
    elsif (m@^name:\s+(.*)@) {
        $n = $1;
        if (grep {lc($_) eq lc($n)} @obsids) {
            $is_obs = 1;
        }
        if ($is_obs) {
            $_ = "name: obsolete $n\nis_obsolete: true";
            if ($rmap{$id}) {
                $_ .= "\nreplaced_by: $rmap{$id}";
            }
            if ($seeAlso) {
                $_ .= "\nproperty_value: seeAlso $seeAlso xsd:anyURI";

            }
        }
    }
    elsif (m@^(\S+):\s+(.*)@) {
        my ($tag, $val) = ($1, $2);
        if ($is_obs) {
            if (m@intersection_of: \s+(\S+)\s+(\S+)\s+\!\s+(.*)@) {
                # HACK:
                #print "consider: $2 ! $3\n";
            }
            if ($logictag{$tag}) {
                print STDERR "SKIPPING: $_\n";
                next;
            }
            # MONDO specific
            if (m@xref:\s+(.*).*equivalentTo@) {
                s@equivalentTo@obsoleteEquivalent@;
            }
            elsif (m@xref:\s+(.*)@) {
                $_ = "consider: $1";
            }
        }
    }
    else {
    }

    print "$_\n";
    
}


exit 0;

sub replace_isa {
    my $p = shift;
    if ($obsh{$p}) {
        my @parents = keys %{$isah{$p}};
        return map {replace_isa($_)} @parents;
    }
    else {
        return ($p);
    }
} 

sub scriptname {
    my @p = split(/\//,$0);
    pop @p;
}


sub usage {
    my $sn = scriptname();

    <<EOM;
$sn [-l ID]* [--no-header] FILE [FILE...]

obsoletes stanzas

Example:

$sn  -l ID1 -l ID2 foo.obo
$sn  -i idfile.txt foo.obo

EOM
}

