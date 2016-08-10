#!/usr/bin/env perl6

use v6.c;
use Test;

use Unicode::Stringprep::Mapping;

my Unicode::Stringprep::Mapping $mapping .= new;
say $mapping.^attributes;

is $mapping.B1[0], 173, "Map {$mapping.B1[0]} to '{$mapping.B1[1]}'";
is $mapping.B2[0], 65, "Map {$mapping.B2[0]} to '{$mapping.B2[1]}'";

done-testing;
