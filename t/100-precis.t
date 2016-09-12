use v6.c;
use Test;
use Unicode::PRECIS;
use Unicode::PRECIS::Tables::Cc;

#-------------------------------------------------------------------------------
subtest {
say $Unicode::PRECIS::Tables::Cc::set;
  ok 0x0000 (elem) $Unicode::PRECIS::Tables::Cc::set, '0x0000 in Cc table';
}, 'Test tables';

#-------------------------------------------------------------------------------
subtest {

  is $exceptions{0x00DF}, 'PVALID', 'exceptions check for PVALID';
  is $properties{$exceptions{0x00DF}}, $properties<PVALID>,
     "properties check for PVALID";

  is $exceptions{0x0660}, 'CONTEXTO', 'exceptions check for CONTEXTO';
  is $properties{$exceptions{0x0660}}, $properties<CONTEXTO>,
     "properties check for CONTEXTO";
}, 'Test exceptions';

#-------------------------------------------------------------------------------
done-testing;
