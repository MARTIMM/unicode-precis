use v6.c;

use Unicode::PRECIS::Tables;

#-------------------------------------------------------------------------------
# Texts are also taken directly from rfc7564 and rfc5892
#-------------------------------------------------------------------------------
unit package Unicode;

class PRECIS {

#  enum Behavioural < Valid ContextJ ContextO Disallowed Unassigned>;
  enum PropValue is export <
    PVALID ID-PVAL FREE-PVAL CONTEXTJ CONTEXTO
    DISALLOWED ID-DIS FREE-DIS UNASSIGNED

    NOT-IN-SET
  >;
#  subset PropValue of Str where $_ (elem) $properties;

  #-----------------------------------------------------------------------------
  sub mk-map ( Str $map-table --> Hash ) {

    my Hash $data = {};
    for $map-table.lines -> $line {

      next if $line ~~ m:s/^ \s* '#'/;
      next if $line ~~ m:s/^ \s* $/;

      ( my Str $codepoint, my Str $property, my Str $comment
      ) = $line.split(/[';'\s+]|[\s+\#\s+]/); 

      $data{:16($codepoint)} = PropValue::{$property};
    }

    $data;
  };

  # rfc5892 2.6.  Exceptions (F)
  our $exceptions is export = mk-map(q:to/ENDTABLE/);
    # PVALID -- Would otherwise have been DISALLOWED

    00DF; PVALID     # LATIN SMALL LETTER SHARP S
    03C2; PVALID     # GREEK SMALL LETTER FINAL SIGMA
    06FD; PVALID     # ARABIC SIGN SINDHI AMPERSAND
    06FE; PVALID     # ARABIC SIGN SINDHI POSTPOSITION MEN
    0F0B; PVALID     # TIBETAN MARK INTERSYLLABIC TSHEG
    3007; PVALID     # IDEOGRAPHIC NUMBER ZERO

    # CONTEXTO -- Would otherwise have been DISALLOWED

    00B7; CONTEXTO   # MIDDLE DOT
    0375; CONTEXTO   # GREEK LOWER NUMERAL SIGN (KERAIA)
    05F3; CONTEXTO   # HEBREW PUNCTUATION GERESH
    05F4; CONTEXTO   # HEBREW PUNCTUATION GERSHAYIM
    30FB; CONTEXTO   # KATAKANA MIDDLE DOT

    # CONTEXTO -- Would otherwise have been PVALID

    0660; CONTEXTO   # ARABIC-INDIC DIGIT ZERO
    0661; CONTEXTO   # ARABIC-INDIC DIGIT ONE
    0662; CONTEXTO   # ARABIC-INDIC DIGIT TWO
    0663; CONTEXTO   # ARABIC-INDIC DIGIT THREE
    0664; CONTEXTO   # ARABIC-INDIC DIGIT FOUR
    0665; CONTEXTO   # ARABIC-INDIC DIGIT FIVE
    0666; CONTEXTO   # ARABIC-INDIC DIGIT SIX
    0667; CONTEXTO   # ARABIC-INDIC DIGIT SEVEN
    0668; CONTEXTO   # ARABIC-INDIC DIGIT EIGHT
    0669; CONTEXTO   # ARABIC-INDIC DIGIT NINE
    06F0; CONTEXTO   # EXTENDED ARABIC-INDIC DIGIT ZERO
    06F1; CONTEXTO   # EXTENDED ARABIC-INDIC DIGIT ONE
    06F2; CONTEXTO   # EXTENDED ARABIC-INDIC DIGIT TWO
    06F3; CONTEXTO   # EXTENDED ARABIC-INDIC DIGIT THREE
    06F4; CONTEXTO   # EXTENDED ARABIC-INDIC DIGIT FOUR
    06F5; CONTEXTO   # EXTENDED ARABIC-INDIC DIGIT FIVE
    06F6; CONTEXTO   # EXTENDED ARABIC-INDIC DIGIT SIX
    06F7; CONTEXTO   # EXTENDED ARABIC-INDIC DIGIT SEVEN
    06F8; CONTEXTO   # EXTENDED ARABIC-INDIC DIGIT EIGHT
    06F9; CONTEXTO   # EXTENDED ARABIC-INDIC DIGIT NINE

    # DISALLOWED -- Would otherwise have been PVALID

    0640; DISALLOWED # ARABIC TATWEEL
    07FA; DISALLOWED # NKO LAJANYALAN
    302E; DISALLOWED # HANGUL SINGLE DOT TONE MARK
    302F; DISALLOWED # HANGUL DOUBLE DOT TONE MARK
    3031; DISALLOWED # VERTICAL KANA REPEAT MARK
    3032; DISALLOWED # VERTICAL KANA REPEAT WITH VOICED SOUND MARK
    3033; DISALLOWED # VERTICAL KANA REPEAT MARK UPPER HALF
    3034; DISALLOWED # VERTICAL KANA REPEAT WITH VOICED SOUND MARK UPPER HA
    3035; DISALLOWED # VERTICAL KANA REPEAT MARK LOWER HALF
    303B; DISALLOWED # VERTICAL IDEOGRAPHIC ITERATION MARK

    ENDTABLE

  # rfc5892 2.7.  BackwardCompatible (G)
  our $backward-compatible is export = mk-map(q:to/ENDTABLE/);

    ENDTABLE

  # rfc7564 9.11.  ASCII7 (K)
  our $ascii7 is export = Set.new: ( 0x0021..0x007E ).flat;


#  my Set $Unassigned .= new();
#  my Set $ASCII7 .= new();
#  my Set $JoinControl .= new();
#  my Set $OldHangulJamo .= new();
  my Set $PrecisIgnorableProperties .= new();
#  my Set $Controls .= new();
  my Set $HasCompat .= new();
#  my Set $LetterDigits .= new();
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
  # 9.1.  LetterDigits (A)
  method letter-digits ( Int $codepoint --> Bool ) {

    state $set = Set.new(<Ll Lu Lo Nd Lm Mn Mc>);
    $codepoint.uniprop('General_Category') (elem) $set;
  }

  #-----------------------------------------------------------------------------
  # 9.6.  Exceptions (F)
  method exceptions ( Int $codepoint --> PropValue ) {

    $exceptions{$codepoint} // PropValue::<NOT-IN-SET>;
  }

  #-----------------------------------------------------------------------------
  # 9.7.  BackwardCompatible (G)
  method backward-compatible ( Int $codepoint --> PropValue) {

    $backward-compatible{$codepoint} // PropValue::<NOT-IN-SET>;
  }

  #-----------------------------------------------------------------------------
  # 9.8.  JoinControl (H)
  method join-control ( Int $codepoint --> Bool ) {

    $codepoint.uniprop-bool('Join_Control');
  }

  #-----------------------------------------------------------------------------
  # 9.9.  OldHangulJamo (I)
  method old-hangul-jamo ( Int $codepoint --> Bool ) {

    state $set = Set.new(<L V T>);
    $codepoint.uniprop('Hangul_Syllable_Type') (elem) $set;
  }

  #-----------------------------------------------------------------------------
  # 9.10.  Unassigned (J)
  method unassigned ( Int $codepoint --> Bool ) {

    $codepoint.uniprop('General_Category') eq 'Cn'
    and not ($codepoint (elem) $Unicode::PRECIS::Tables::NonCharCodepoint);
  }

  #-----------------------------------------------------------------------------
  # 9.11.  ASCII7 (K)
  method ascii7 ( Int $codepoint --> Bool ) {

    $codepoint (elem) $ascii7;
  }

  #-----------------------------------------------------------------------------
  # 9.12.  Controls (L)
  method control ( Int $codepoint --> Bool ) {

    $codepoint.uniprop('General_Category') eq 'Cc';
  }

  #-----------------------------------------------------------------------------
  # 9.13.  PrecisIgnorableProperties (M)
  method precis-ignorable-properties ( Int $codepoint --> Bool ) {

    $codepoint.uniprop-bool('Default_Ignorable_Code_Point')
    or ($codepoint (elem) $Unicode::PRECIS::Tables::NonCharCodepoint::set);
  }

  #-----------------------------------------------------------------------------
  # 9.14.  Spaces (N)
  method space ( Int $codepoint --> Bool ) {

    $codepoint.uniprop('General_Category') eq 'Zs';
  }

  #-----------------------------------------------------------------------------
  # 9.15   Symbols (O)
  method symbol ( Int $codepoint --> Bool ) {

    state $set = Set.new(<Sm Sc Sk So>);
    $codepoint.uniprop('General_Category') (elem) $set;
  }

  #-----------------------------------------------------------------------------
  # 9.16.  Punctuation (P)
  method punctuation ( Int $codepoint --> Bool ) {

    state $set = Set.new(<Pc Pd Ps Pe Pi Pf Po>);
    $codepoint.uniprop('General_Category') (elem) $set;
  }

  #-----------------------------------------------------------------------------
  # 9.17.  HasCompat (Q)
  method has-compat ( Int $codepoint --> Bool ) {

    my Bool $no-compat;
    for Uni.new($codepoint).NFKC -> $cp {
      $no-compat = ($codepoint == $cp);
      last unless $no-compat;
    }

    not $no-compat;
  }
}
