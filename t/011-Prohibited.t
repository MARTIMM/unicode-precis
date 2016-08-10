#!/usr/bin/env perl6

use v6.c;
use Test;

use Unicode::Stringprep::Prohibited;

my Unicode::Stringprep::Prohibited $prohibited .= new;
#say $prohibited.^attributes;

is $prohibited.C4[0], 64976, "Map {$prohibited.C4[0]} to '{$prohibited.C4[1]}'";
is $prohibited.C8[0], 832, "Map {$prohibited.C8[0]} to '{$prohibited.C8[1]//'-'}'";


done-testing;
