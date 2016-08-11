#!/usr/bin/env perl6

use v6.c;
use Test;

use Unicode::Stringprep::BiDi;

my Array $D1 = $Unicode::Stringprep::BiDi::D1;
my Array $D2 = $Unicode::Stringprep::BiDi::D2;

is $D1[0], 1470, "Map {$D1[0]} to '{$D1[1]//'-'}'";
is $D2[0], 65, "Map {$D2[0]} to '{$D2[1]}'";


done-testing;
