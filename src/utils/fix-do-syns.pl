#!/usr/bin/perl

sub proc {
    @lines = _;
    foreach (@lines) {
        if (m@^id: (\S+)@) {
            $id = $1;
        }
        elsif (m@^name: (.*)@) {
            $syns{$id} = [ [$1, '', 'label'] ];
            add($n, $1);
        }
        elsif (m@^synonym: "(.*)" EXACT.* \[(.*)\]@) {
            push(@$syns{$id}, [$1, 'exact', $2]);
            push(@{$n{$1}}, $id);
            add($n, $1);
        }
    }
}

exit 0;

sub add {
    my ($n, $id) = @_;
    if (!$nm{$n}) {
        $nm{$n} = {};
    }
    $nm{$n}{$$id}++;
}
