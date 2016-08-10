#!/usr/bin/env perl6

use v6.c;
use Test;

use Unicode::Stringprep::Common;

my Array $B1 = mk-map(Q:to/ENDTABLE/);
   00AD; ; Map to nothing
   034F; ; Map to nothing
   ENDTABLE
#say $B1.perl;

my Array $B2 = mk-map(Q:to/ENDTABLE/);
   0041; 0061; Case map
   0042; 0062; Case map
   ENDTABLE
#say $B2.perl;

my Array $C12 = mk-set(q:to/ENDTABLE/);
   00A0; NO-BREAK SPACE
   1680; OGHAM SPACE MARK
   206A-206F; [CONTROL CHARACTERS]
   ENDTABLE
say $C12.perl;

is $B1[0], 173, "Map $B1[0] to '$B1[1]'";
is $B2[0], 65, "Map $B2[0] to '$B2[1]'";
is $C12[0], 160, "Set $C12[0] to {$C12[1]//'-'}";

done-testing;

