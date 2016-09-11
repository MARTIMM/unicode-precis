use v6.c;
use Unicode::PRECIS;

#-------------------------------------------------------------------------------
# Texts are also taken directly from rfc7564
#-------------------------------------------------------------------------------
# IdentifierClass:  a sequence of letters, numbers, and some symbols that is
#    used to identify or address a network entity such as a user account, a
#    venue (e.g., a chatroom), an information source (e.g., a data feed), or a
#    collection of data (e.g., a file); the intent is that this class will
#    minimize user confusion in a wide variety of application protocols, with
#    the result that safety has been prioritized over expressiveness for this
#    class.
unit package Unicode;

class PRECIS::Identifier is Unicode::PRECIS {

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
}
