#!/usr/bin/env perl6

use v6.c;
use Test;

use Unicode::Stringprep;

my Unicode::Stringprep $prepper .= new(
    3.2,
    [ Unicode::Stringprep::Mapping::B1, ],
    '',
    [ Unicode::Stringprep::Prohibited::C12,
      Unicode::Stringprep::Prohibited::C22,
    1,
  );


my Unicode::Stringprep $saslprep .= new(
  3.2,
  [ \@Unicode::Stringprep::Mapping::B1,
    \%C12_to_SPACE ],
  'KC',
  [ \@Unicode::Stringprep::Prohibited::C12,
    \@Unicode::Stringprep::Prohibited::C21,
    \@Unicode::Stringprep::Prohibited::C22,
    \@Unicode::Stringprep::Prohibited::C3,
    \@Unicode::Stringprep::Prohibited::C4,
    \@Unicode::Stringprep::Prohibited::C5,
    \@Unicode::Stringprep::Prohibited::C6,
    \@Unicode::Stringprep::Prohibited::C7,
    \@Unicode::Stringprep::Prohibited::C8,
    \@Unicode::Stringprep::Prohibited::C9,
  ],
  1
);

say $prepper;


done-testing;
