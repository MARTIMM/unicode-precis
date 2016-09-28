use v6.c;
use Unicode::PRECIS;
use Unicode::PRECIS::FreeForm;

#-------------------------------------------------------------------------------
# rfc7613 7.3.  OpaqueString Profile
#
#   IANA has added the following entry to the "PRECIS Profiles" registry.
#
#   Name:  OpaqueString.
#
#   Base Class:  FreeformClass.
#
#   Applicability:  Passwords and other opaque strings in security and
#   application protocols.
#
#   Replaces:  The SASLprep profile of stringprep.
#
#   Width-Mapping Rule:  None.
#
#   Additional Mapping Rule:  Map non-ASCII space characters to ASCII space.
#
#   Case-Mapping Rule:  None.
#
#   Normalization Rule:  NFC.
#
#   Directionality Rule:  None.
#
#   Enforcement:  To be defined by security or application protocols that
#   use this profile.
#
#   Specification:  RFC 7613 (this document), Section 4.2.
#
#-------------------------------------------------------------------------------
unit package Unicode;

class PRECIS::FreeForm::OpaqueString {
  also is Unicode::PRECIS::FreeForm;

  #-----------------------------------------------------------------------------
  # rfc7613 4.2.1.  Preparation
  method prepare ( Str $s --> TestValue ) {

  }

  #-----------------------------------------------------------------------------
  # rfc7613 4.2.2.  Enforcement
  method enforce ( Str $s --> TestValue ) {

  }

  #-----------------------------------------------------------------------------
  # rfc7613 4.2.3.  Comparison
  method compare ( Str $s1, Str $s2 --> Bool ) {

  }
}
