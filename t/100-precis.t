use v6.c;
use Test;

use Unicode::PRECIS;
use Unicode::PRECIS::Tables::GeneralCatagory;
use Unicode::PRECIS::Tables::JoinControl;
use Unicode::PRECIS::Tables::OldHangulJamo;
use Unicode::PRECIS::Tables::NonCharCodepoint;

#-------------------------------------------------------------------------------
subtest {
  ok 0x00C0 (elem) $Unicode::PRECIS::Tables::GeneralCatagory::set,
     '0x00C0 in GeneralCatagory set';

  for "abc\x[0398]\x[30c7]\x[17010]\x[17820]".NFC -> $codepoint {
    ok $codepoint (elem) $Unicode::PRECIS::Tables::GeneralCatagory::set,
      Uni.new($codepoint).Str() ~ " ($codepoint.fmt('0x%04x')) in general set";
  }

  ok 0x200C (elem) $Unicode::PRECIS::Tables::JoinControl::set,
     '0x200C in JoinControl set';

  ok 0x114E (elem) $Unicode::PRECIS::Tables::OldHangulJamo::set,
     '0x114E in OldHangulJamo set';

  ok 0x11A0 (elem) $Unicode::PRECIS::Tables::OldHangulJamo::set,
     '0x11A0 in OldHangulJamo set';

  ok 0x11A0 (elem) $Unicode::PRECIS::Tables::OldHangulJamo::set,
     '0x11A0 in OldHangulJamo set';

  ok 0x5FFFE (elem) $Unicode::PRECIS::Tables::NonCharCodepoint::set,
     '0x5FFFE in NonCharCodepoint set';
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
