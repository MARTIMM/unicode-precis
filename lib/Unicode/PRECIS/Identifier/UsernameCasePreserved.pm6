use v6.c;
use Unicode::PRECIS::Identifier;

#-------------------------------------------------------------------------------
# Texts are also taken directly from rfc7564
#-------------------------------------------------------------------------------
unit package Unicode;

class PRECIS::Identifier::UsernameCasePreserved {
  also is Unicode::PRECIS::Identifier;

  #-----------------------------------------------------------------------------
  # rfc7613 3.3.1.  Preparation
  method prepare ( Str $s --> Bool ) {

  }

  #-----------------------------------------------------------------------------
  # rfc7613 3.3.2.  Enforcement
  method enforce ( Str $s --> Bool ) {

  }

  #-----------------------------------------------------------------------------
  # rfc7613 3.3.3.  Comparison
  method compare ( Str $s1, Str $s2 --> Bool ) {

  }
}
