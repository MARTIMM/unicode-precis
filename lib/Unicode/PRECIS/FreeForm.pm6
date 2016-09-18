use v6.c;
use Unicode::PRECIS;

#-------------------------------------------------------------------------------
# Texts are also taken directly from rfc7564
#-------------------------------------------------------------------------------
# FreeformClass:  a sequence of letters, numbers, symbols, spaces, and other
#    characters that is used for free-form strings, including passwords as well
#    as display elements such as human-friendly nicknames for devices or for
#    participants in a chatroom; the intent is that this class will allow nearly
#    any Unicode character, with the result that expressiveness has been
#    prioritized over safety for this class.  Note well that protocol designers,
#    application developers, service providers, and end users might not
#    understand or be able to enter all of the characters that can be included
#    in the FreeformClass -- see Section 12.3 for details.
unit package Unicode;

class PRECIS::FreeForm is Unicode::PRECIS {

  #-----------------------------------------------------------------------------
  submethod BUILD ( ) {

  }

  #-----------------------------------------------------------------------------
  # Preparation entails only ensuring that the characters in an individual string
  # are allowed by the underlying PRECIS string class.
  method prepare ( Str $s --> Bool ) {

  }

  #-----------------------------------------------------------------------------
  # Enforcement entails applying all of the rules specified for a particular
  # string class or profile thereof to an individual string, for the purpose of
  # determining if the string can be used in a given protocol slot.
  method enforce ( Str $s --> Bool ) {

  }

  #-----------------------------------------------------------------------------
  # Comparison entails applying all of the rules specified for a particular
  # string class or profile thereof to two separate strings, for the purpose of
  # determining if the two strings are equivalent.
  method compare ( Str $s1, Str $s2 --> Bool ) {

  }

  #-----------------------------------------------------------------------------
  method calculate-value ( Int $codepoint --> PropValue ) {

    if $codepoint (elem) $exceptions { self.exceptions($codepoint); }

    elsif $codepoint (elem) $backwardcompatible {
      self.backwardcompatible($codepoint);
    }

    elsif self.unassigned($codepoint) { UNASSIGNED; }
    elsif self.ascii7($codepoint) { PVALID; }
    elsif self.join-control($codepoint) { CONTEXTJ; }
    elsif self.old-hangul-jamo($codepoint) { DISALLOWED; }
    elsif self.precis-ignorable-properties($codepoint) { DISALLOWED; }
    elsif self.control($codepoint) { DISALLOWED; }
    elsif self.has-compat($codepoint) { FREE-PVAL; }
    elsif self.letter-digits($codepoint) { PVALID; }
    elsif self.other-letter-digits($codepoint) { FREE-PVAL; }
    elsif self.space($codepoint) { FREE-PVAL; }
    elsif self.symbol($codepoint) { FREE-PVAL; }
    elsif self.punctuation($codepoint) { FREE-PVAL; }
    else { DISALLOWED; }
  }
}
