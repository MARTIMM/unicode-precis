#!/usr/bin/env perl6

use v6.c;
use Test;

use Unicode::Stringprep::Prohibited;

my Array $C4 = $Unicode::Stringprep::Prohibited::C4;
my Array $C8 = $Unicode::Stringprep::Prohibited::C8;

is $C4[0], 64976, "Map {$C4[0]} to '{$C4[1]}'";
is $C8[0], 832, "Map {$C8[0]} to '{$C8[1]//'-'}'";


done-testing;
