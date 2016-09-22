use v6.c;
use Unicode::PRECIS::FreeForm;

#-------------------------------------------------------------------------------
unit package Unicode;

class PRECIS::FreeForm::OpaqueString {
  also is Unicode::PRECIS::FreeForm;

  #-----------------------------------------------------------------------------
  # rfc7613 4.2.1.  Preparation
  method prepare ( Str $s --> Bool ) {

  }

  #-----------------------------------------------------------------------------
  # rfc7613 4.2.2.  Enforcement
  method enforce ( Str $s --> Bool ) {

  }

  #-----------------------------------------------------------------------------
  # rfc7613 4.2.3.  Comparison
  method compare ( Str $s1, Str $s2 --> Bool ) {

  }
}
