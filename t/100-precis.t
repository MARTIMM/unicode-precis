use v6.c;
use Test;

use Unicode::PRECIS;
use Unicode::PRECIS::Tables;

#-------------------------------------------------------------------------------
subtest {
  test-match( 0x00C0, 'Lu');
  test-match( 0x00e9, 'Ll');

  ok 0x5FFFE (elem) $Unicode::PRECIS::Tables::NonCharCodepoint::set,
     '0x5FFFE in NonCharCodepoint set';

  ok 0xFDD0 (elem) $Unicode::PRECIS::Tables::NonCharCodepoint::set,
     '0x5FFFE in NonCharCodepoint set';

  ok 
#`{{
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

  ok 0x0BE5 (elem) $Unicode::PRECIS::Tables::Unassigned::set,
     '0x0BE5 in Unassigned set';

  ok 0x10CF4 (elem) $Unicode::PRECIS::Tables::Unassigned::set,
     '0x10CF4 in Unassigned set';

  ok 0x001C (elem) $Unicode::PRECIS::Tables::Controls::set,
     '0x001C in Controls set';

  ok 0x008A (elem) $Unicode::PRECIS::Tables::Controls::set,
     '0x008A in Controls set';
}}

  ok 0x0064 (elem) $ascii7, '0x0064 in Ascii7 set';

}, 'Test tables';

#-------------------------------------------------------------------------------
subtest {

  is $exceptions{0x00DF}, 'PVALID', 'exceptions check for PVALID';
  is $exceptions{0x0660}, 'CONTEXTO', 'exceptions check for CONTEXTO';

}, 'Test exceptions';

#-------------------------------------------------------------------------------
subtest {

  my Unicode::PRECIS $p .= new;

  my Int $codepoint = 0x05DD;
  ok $p.letter-digits($codepoint),
     "$codepoint.fmt('0x%06x') in letter-digits set";

  $codepoint = 0x05C6;
  nok $p.letter-digits($codepoint),
     "$codepoint.fmt('0x%06x') not in letter-digits set";

  $codepoint = 0x0660;
  ok $p.exceptions($codepoint) ~~ 'CONTEXTO',
     "$codepoint.fmt('0x%06x') is a $p.exceptions($codepoint) exception";

  $codepoint = 0x00DF;
  ok $p.exceptions($codepoint) ~~ 'PVALID',
     "$codepoint.fmt('0x%06x') is a $p.exceptions($codepoint) exception";

  $codepoint = 0x10FEEE;
  ok $p.exceptions($codepoint) ~~ 'NOT-IN-SET',
     "$codepoint.fmt('0x%06x') is a $p.exceptions($codepoint) exception";

  $codepoint = 0x100E;
  ok $p.backward-compatible($codepoint) ~~ 'NOT-IN-SET',
     "$codepoint.fmt('0x%06x') is a $p.backward-compatible($codepoint) backwards compatible";

  $codepoint = 0x00DF;
  nok $p.join-control($codepoint),
     "$codepoint.fmt('0x%06x') is not a join control";

  $codepoint = 0x200C;
  ok $p.join-control($codepoint),
     "$codepoint.fmt('0x%06x') is a join control";

  $codepoint = 0x11A7;
  ok $p.old-hangul-jamo($codepoint),
     "$codepoint.fmt('0x%06x') in old-hangul-jamo set";

  $codepoint = 0x01A7;
  nok $p.old-hangul-jamo($codepoint),
     "$codepoint.fmt('0x%06x') not in old-hangul-jamo set";

  $codepoint = 0xFDDA;
  ok $p.unassigned($codepoint),
     "$codepoint.fmt('0x%06x') in unassigned set";

  $codepoint = 0xFDC0;
  nok $p.unassigned($codepoint),
     "$codepoint.fmt('0x%06x') not in unassigned set";

  $codepoint = 0x0024;
  ok $p.ascii7($codepoint),
     "$codepoint.fmt('0x%06x') in ascii 7 set";

  $codepoint = 0xF143;
  nok $p.ascii7($codepoint),
     "$codepoint.fmt('0x%06x') not in ascii 7 set";

  $codepoint = 0x008A;
  ok $p.control($codepoint),
     "$codepoint.fmt('0x%06x') in control set";

  $codepoint = 0xF140;
  nok $p.control($codepoint),
     "$codepoint.fmt('0x%06x') not in control set";

  $codepoint = 0x00AD;
  ok $p.precis-ignorable-properties($codepoint),
     "$codepoint.fmt('0x%06x') in ignorable set";

  $codepoint = 0x5FFFE;
  ok $p.precis-ignorable-properties($codepoint),
     "$codepoint.fmt('0x%06x') in ignorable set";

  $codepoint = 0xFFFC;
  nok $p.precis-ignorable-properties($codepoint),
     "$codepoint.fmt('0x%06x') not in ignorable set";

}, "Test PRECIS";

#-------------------------------------------------------------------------------
done-testing;


#-------------------------------------------------------------------------------
sub test-match ( Int $codepoint, Str $category) {

  ok $codepoint.unimatch($category),
     chrs($codepoint) ~ " ($codepoint.fmt('0x%06x')) in $category set";
}

