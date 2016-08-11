#!/usr/bin/env perl6

use v6.c;
use Test;

use Unicode::Stringprep::Mapping;

my Array $B1 = $Unicode::Stringprep::Mapping::B1;
my Array $B2 = $Unicode::Stringprep::Mapping::B2;

is $B1[0], 173, "Map {$B1[0]} to '{$B1[1]}'";
is $B2[0], 65, "Map {$B2[0]} to '{$B2[1]}'";

done-testing;
