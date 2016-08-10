#!/usr/bin/env perl6

use v6.c;
use Test;

use Unicode::Stringprep::Unassigned;

my Unicode::Stringprep::Unassigned $unassigned .= new;
#say $unassigned.^attributes;

is $unassigned.A1[0], 545, "Map {$unassigned.A1[0]} to '{$unassigned.A1[1]//'-'}'";
is $unassigned.A1[2], 564, "Map {$unassigned.A1[2]} to '{$unassigned.A1[3]}'";


done-testing;
