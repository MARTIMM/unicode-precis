#!/usr/bin/env perl6

use v6.c;
use Test;

use Unicode::Stringprep::Unassigned;

my Array $A1 = $Unicode::Stringprep::Unassigned::A1;

is $A1[0], 545, "Map {$A1[0]} to '{$A1[1]//'-'}'";
is $A1[2], 564, "Map {$A1[2]} to '{$A1[3]}'";


done-testing;
