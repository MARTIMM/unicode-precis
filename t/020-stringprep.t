#!/usr/bin/env perl6

use v6.c;
use Test;

use Unicode::Stringprep;
use Unicode::Stringprep::Mapping;
use Unicode::Stringprep::Prohibited;

my Unicode::Stringprep $strprep .= new(
    :unicode-version<3.2>,
    :mapping-tables( [ $Unicode::Stringprep::Mapping::B1, ]),
    :unicode-normalization(''),
    :prohibited-tables( [
      $Unicode::Stringprep::Prohibited::C12,
      $Unicode::Stringprep::Prohibited::C22,
    ]),
  );


# Space handling
my Array $C12 = $Unicode::Stringprep::Prohibited::C12;
my %C12_to_SPACE = ();
loop ( my $pos = 0; $pos < $C12.elems; $pos += 2 ) {
  loop ( my $char = $C12[$pos]; 
         defined $C12[$pos] and $char <= $C12[$pos];
         $char++) {
    %C12_to_SPACE{$char} = ' ';
  }
};

say "C12: ", %C12_to_SPACE.keys;

my Unicode::Stringprep $saslprep .= new(
  :mapping-tables( [
    $Unicode::Stringprep::Mapping::B1,
    %C12_to_SPACE
  ]),
  :unicode-normalization<KC>,
  :prohibited-tables( [
    $Unicode::Stringprep::Prohibited::C12,
    $Unicode::Stringprep::Prohibited::C21,
    $Unicode::Stringprep::Prohibited::C22,
    $Unicode::Stringprep::Prohibited::C3,
    $Unicode::Stringprep::Prohibited::C4,
    $Unicode::Stringprep::Prohibited::C5,
    $Unicode::Stringprep::Prohibited::C6,
    $Unicode::Stringprep::Prohibited::C7,
    $Unicode::Stringprep::Prohibited::C8,
    $Unicode::Stringprep::Prohibited::C9,
  ]),
  
);

say $strprep;
say $strprep.prepper;

done-testing;
