use v6.c;
use Unicode::PRECIS;
use Unicode::PRECIS::Identifier;

#-------------------------------------------------------------------------------
# rfc7613 7.1.  UsernameCaseMapped Profile
#
#   IANA has added the following entry to the "PRECIS Profiles" registry.
#
#   Name:  UsernameCaseMapped.
#
#   Base Class:  IdentifierClass.
#
#   Applicability:  Usernames in security and application protocols.
#
#   Replaces:  The SASLprep profile of stringprep.
#
#   Width-Mapping Rule:  Map fullwidth and halfwidth characters to their
#   decomposition mappings.
#
#   Additional Mapping Rule:  None.
#
#   Case-Mapping Rule:  Map uppercase and titlecase characters to
#   lowercase.
#
#   Normalization Rule:  NFC.
#-------------------------------------------------------------------------------
unit package Unicode;

class PRECIS::Identifier::UsernameCaseMapped {
  also is Unicode::PRECIS::Identifier;

  #-----------------------------------------------------------------------------
  # rfc7613 3.2.1.  Preparation
  method prepare ( Str $s is copy --> TestValue ) {

    $s = self!map-string($s);

    # 3.1.  Definition
    return False unless $s.chars;
    return self.test-string($s) ?? $s.NFC.Str !! False;
  }

  #-----------------------------------------------------------------------------
  # rfc7613 3.2.2.  Enforcement
  method enforce ( Str $s --> TestValue ) {

    my TestValue $tv = self.prepare($s);
    return $tv if $tv ~~ Bool;
    if $tv ~~ Str {
    
      # rfc7613 5.  Directionality Rule:
      self.directionality-rule($s);
    }
  }

  #-----------------------------------------------------------------------------
  # rfc7613 3.2.3.  Comparison
  method compare ( Str $s1, Str $s2 --> Bool ) {

  }

  #-----------------------------------------------------------------------------
  # Mapping and other rules
  method !map-string( Str $s is copy --> Str ) {

    $s = self.width-mapping-rule($s);
    $s = self.case-mapping-rule($s);
  }
}
