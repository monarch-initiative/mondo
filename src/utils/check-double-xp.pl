#!/usr/bin/perl
while(<>) {
    if (m@^id: (\S+)@) {
        $id = $1;
    }
    if (m@^intersection_of:@) {
        if (!$in) {
            if ($in_xp eq $id) {
                die "$id";
            }
        }
        $in = 1;
        $in_xp = $id;
    }
    else {
        $in = 0;
    }
}
