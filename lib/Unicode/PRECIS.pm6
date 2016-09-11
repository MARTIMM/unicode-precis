use v6.c;

#-------------------------------------------------------------------------------
# Texts are also taken directly from rfc7564 and rfc5892
#-------------------------------------------------------------------------------
unit package Unicode;

# 2.1   LetterDigits (A)
#   A: General_Category(cp) is in {Ll, Lu, Lo, Nd, Lm, Mn, Mc}

class PRECIS {

  enum Behavioural < Valid ContextJ ContextO Disallowed Unassigned>;
  enum PropertyValue < PValid IdPValid FreePValid ContextJReq ContextOReq
                       PDisallowed SCDisallowed PUnassigned
                     >;

  my Set $Execptions .= new();
  my Set $BackwardCompatible .= new();
  my Set $Unassigned .= new();
  my Set $ASCII7 .= new();
  my Set $JoinControl .= new();
  my Set $OldHangulJamo .= new();
  my Set $PrecisIgnorableProperties .= new();
  my Set $Controls .= new();
  my Set $HasCompat .= new();
  my Set $LetterDigits .= new();
  my Set $OtherLetterDigits .= new();
  my Set $Spaces .= new();
  my Set $Symbols .= new();
  my Set $Punctuation .= new();

  #-----------------------------------------------------------------------------
  submethod BUILD ( ) {
  
  }

  #-----------------------------------------------------------------------------
  # 7.  Order of Operations
  #
  #   To ensure proper comparison, the rules specified for a particular
  #   string class or profile MUST be applied in the following order:
  #   width-map-rule, additional-map-rule, case-map-rule, normalization-rule,
  #   directionality-rule and behavioural-rule.
  #
  method width-mapping-rule ( ) {
  
  }

  #-----------------------------------------------------------------------------
  method additional-mapping-rule ( ) {
  
  }

  #-----------------------------------------------------------------------------
  method case-mapping-rule ( ) {
  
  }

  #-----------------------------------------------------------------------------
  method normalization-rule ( ) {
  
  }

  #-----------------------------------------------------------------------------
  method directionality-rule ( ) {
  
  }

  #-----------------------------------------------------------------------------
  method behavioural-rule ( ) {
  
  }


  #-----------------------------------------------------------------------------
  method calculate-value ( Int $codepoint ) {
  
    if $codepoint (elem) $Exceptions { self.exceptions($codepoint); }
    elsif $codepoint (elem) $BackwardCompatible { self.backwardcompatible($codepoint); }
    elsif $codepoint (elem) $Unassigned { UNASSIGNED; }
    elsif $codepoint (elem) $ASCII7 { PVALID; }
    elsif $codepoint (elem) $JoinControl { CONTEXTJ; }
    elsif $codepoint (elem) $OldHangulJamo { DISALLOWED; }
    elsif $codepoint (elem) $PrecisIgnorableProperties { DISALLOWED; }
    elsif $codepoint (elem) $Controls { DISALLOWED; }
    elsif $codepoint (elem) $HasCompat { ID_DIS or FREE_PVAL; }
    elsif $codepoint (elem) $LetterDigits { PVALID; }
    elsif $codepoint (elem) $OtherLetterDigits { ID_DIS or FREE_PVAL; }
    elsif $codepoint (elem) $Spaces { ID_DIS or FREE_PVAL; }
    elsif $codepoint (elem) $Symbols { ID_DIS or FREE_PVAL; }
    elsif $codepoint (elem) $Punctuation { ID_DIS or FREE_PVAL; }
    else { DISALLOWED; }
  }

  #-----------------------------------------------------------------------------
  method exceptions ( Int $codepoint ) {
  
  }

  #-----------------------------------------------------------------------------
  method backwardcompatible ( Int $codepoint ) {
  
  }
}
