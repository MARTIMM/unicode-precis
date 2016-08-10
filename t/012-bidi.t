#!/usr/bin/env perl6

use v6.c;
use Test;

use Unicode::Stringprep::BiDi;

my Unicode::Stringprep::BiDi $bidi .= new;
#say $bidi.^attributes;

is $bidi.D1[0], 1470, "Map {$bidi.D1[0]} to '{$bidi.D1[1]//'-'}'";
is $bidi.D2[0], 65, "Map {$bidi.D2[0]} to '{$bidi.D2[1]}'";


done-testing;
