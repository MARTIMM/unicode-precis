#!/usr/bin/env perl6

use v6.c;

#-------------------------------------------------------------------------------
# http://www.unicode.org/reports/tr44/
#   4.2.3 Code Point Ranges in UnicodeData.txt
#   4.2.4 Comments
#

#-------------------------------------------------------------------------------
#say "A: ", @*ARGS.perl;

my Str $module-name;
my Str $unicode-db;
my Bool $table-too;

# Search through UnicodeData.txt
multi sub MAIN ( 'UCD', Str $ucd-dir = '9.0', Str :$mod-name!, Str :$cat!, Bool :$table = False ) {

  $module-name = $mod-name;
  $unicode-db = $ucd-dir;
  $table-too = $table;

  the-work( :$cat, :worker(&ucd-db));
}

# Search through PropList.txt
multi sub MAIN ( 'PRL', Str $ucd-dir = '9.0', Str :$mod-name!, Str :$cat!, Bool :$table = False ) {

  $module-name = $mod-name;
  $unicode-db = $ucd-dir;
  $table-too = $table;

  the-work( :$cat, :worker(&prl-db));
}

# Search through HangulSyllableType.txt
multi sub MAIN ( 'HST', Str $ucd-dir = '9.0', Str :$mod-name!, Str :$cat!, Bool :$table = False ) {

  $module-name = $mod-name;
  $unicode-db = $ucd-dir;
  $table-too = $table;

  the-work( :$cat, :worker(&hst-db));
}

# Search through extracted/DerivedGeneralCategory.txt
multi sub MAIN ( 'DGC', Str $ucd-dir = '9.0', Str :$mod-name!, Str :$cat!, Bool :$table = False ) {

  $module-name = $mod-name;
  $unicode-db = $ucd-dir;
  $table-too = $table;

  the-work( :$cat, :worker(&dgc-db));
}

# Search through extracted/DerivedBidiClass.txt
multi sub MAIN ( 'BDI', Str $ucd-dir = '9.0', Str :$mod-name!, Str :$cat!, Bool :$table = False ) {

  $module-name = $mod-name;
  $unicode-db = $ucd-dir;
  $table-too = $table;

  the-work( :$cat, :worker(&bdi-db));
}

#-------------------------------------------------------------------------------
sub the-work ( Str :$cat, Callable :$worker ) {

  die "Directory $unicode-db not found" unless $unicode-db.IO ~~ :d;

  # Go to unicode data dir
  my $current-dir = $*CWD.Str;
  chdir $unicode-db;

  # Go to unicode data dir
  my Hash $data = &$worker(:cat($cat.split(/\h* ',' \h*/)));

  # Return to original dir
  chdir $current-dir;

  # Generate module
  generate-module(:$data);
}

#-------------------------------------------------------------------------------
sub USAGE ( ) {

  say Q:to/EO-USE/;

  Generate modules based on character tables from several sources.

  Usage:

    Search through the UnicodeData.txt file
    > generate-module.pl6 --mod-name=<Str> --cat=<List> [--table] [<ucd-dir> ='9.0'] UCD

    Search through the PropList.txt file
    > generate-module.pl6 --mod-name=<Str> --cat=<List> [--table] [<ucd-dir> ='9.0'] PRL

    Search through the HangulSyllableType.txt file
    > generate-module.pl6 --mod-name=<Str> --cat=<List> [--table] [<ucd-dir> ='9.0'] HST

    Search through the extracted/DerivedGeneralCategory.txt file
    > generate-module.pl6 --mod-name=<Str> --cat=<List> [--table] [<ucd-dir> ='9.0'] DGC

    Search through the extracted/DerivedBidiClass.txt file
    > generate-module.pl6 --mod-name=<Str> --cat=<List> [--table] [<ucd-dir> ='9.0'] DGC

  Arguments
    ucd-dir             Directory where unicode data is to be found. Default
                        is set to './9.0'.
    type                Any of UCD, PRL, HST, DGC, BDI to select data from a
                        specific file from the unicode database.

  Options:
    --mod-name        Name of the class generated. This will be a
                        generated as follows;

                          unit package Unicode;
                          module PRECIS::Tables::$mod-name {
                            ...
                          }

                        The module is generated in the current directory as
                        $mod-name.pm6. After generating the file, it can be
                        moved to other places.

    --table             Generate a table too. Default is to define a set only.
                        our $set = Set.new: ( ... code points ... ).flat;

                        our $table = %( codepoint => codepoint-info-hash );

    When UCD (Search through UnicodeData.txt)
    --cat               This is a list of comma separated strings. These
                        strings are searched in the UnicodeData.txt from
                        http://unicode.org/Public/9.0.0/ucd/UnicodeData.txt.
                        This file must be found in the current directory

    When PRL (Search through PropList.txt)
    --cat               This is a list of comma separated strings just as above
                        but has other catagory names.

    When HST (Search through HangulSyllableType.txt)
    --cat               This is a list of comma separated strings just as above
                        but has other catagory names.

    When DGC (Search through extracted/DerivedGeneralCategory.txt)
    --cat               This is a list of comma separated strings just as above
                        but has other catagory names.

  EO-USE
}

#-------------------------------------------------------------------------------
# ftp://unicode.org/Public/3.2-Update/UnicodeData-3.2.0.html
# Field Name                            N/I Explanation
# 0     Code point                      N   Code point.
# 1     Character name                  N   These names match exactly the names published in the code charts of the Unicode Standard.
# 2     General Category                N   This is a useful breakdown into various "character types" which can be used as a default categorization in implementations. See below for a brief explanation.
# 3     Canonical Combining Classes     N   The classes used for the Canonical Ordering Algorithm in the Unicode Standard. These classes are also printed in Chapter 4 of the Unicode Standard.
# 4     Bidirectional Category          N   See the list below for an explanation of the abbreviations used in this field. These are the categories required by the Bidirectional Behavior Algorithm in the Unicode Standard. These categories are summarized in Chapter 3 of the Unicode Standard.
# 5     Character Decomposition Mapping N   In the Unicode Standard, not all of the mappings are full (maximal) decompositions. Recursive application of look-up for decompositions will, in all cases, lead to a maximal decomposition. The decomposition mappings match exactly the decomposition mappings published with the character names in the Unicode Standard.
# 6     Decimal digit value             N   This is a numeric field. If the character has the decimal digit property, as specified in Chapter 4 of the Unicode Standard, the value of that digit is represented with an integer value in this field
# 7     Digit value                     N   This is a numeric field. If the character represents a digit, not necessarily a decimal digit, the value is here. This covers digits which do not form decimal radix forms, such as the compatibility superscript digits
# 8     Numeric value                   N   This is a numeric field. If the character has the numeric property, as specified in Chapter 4 of the Unicode Standard, the value of that character is represented with an integer or rational number in this field. This includes fractions as, e.g., "1/5" for U+2155 VULGAR FRACTION ONE FIFTH Also included are numerical values for compatibility characters such as circled numbers.
# 9     Mirrored                        N   If the character has been identified as a "mirrored" character in bidirectional text, this field has the value "Y"; otherwise "N". The list of mirrored characters is also printed in Chapter 4 of the Unicode Standard.
# 10    Unicode 1.0 Name                I   This is the old name as published in Unicode 1.0. This name is only provided when it is significantly different from the current name for the character. The value of field 10 for control characters does not always match the Unicode 1.0 names. Instead, field 10 contains ISO 6429 names for control functions, for printing in the code charts.
# 11    10646 comment field             I   This is the ISO 10646 comment field. It appears in parentheses in the 10646 names list, or contains an asterisk to mark an Annex P note.
# 12    Uppercase Mapping               N   Upper case equivalent mapping. If a character is part of an alphabet with case distinctions, and has a simple upper case equivalent, then the upper case equivalent is in this field. See the explanation below on case distinctions. These mappings are always one-to-one, not one-to-many or many-to-one.
#                                           Note: This field is omitted if the uppercase is the same as field 0. For full case mappings, see UAX #21 Case Mappings and SpecialCasing.txt.
# 13 	Lowercase Mapping 	        N   Similar to Uppercase mapping
#                                           Note: This field is omitted if the lowercase is the same as field 0. For full case mappings, see UAX #21 Case Mappings and SpecialCasing.txt.
# 14 	Titlecase Mapping 	        N   Similar to Uppercase mapping.
#                                           Note: This field is omitted if the titlecase is the same as field 12. For full case mappings, see UAX #21 Case Mappings and SpecialCasing.txt.
sub ucd-db ( List :cat($ucd-cat) --> Hash ) {

  my Map $ucd-names .= new(
    < codepoint character-name general-catagory
      canonical-combining-classes bidirectional-category
      character-decomposition-mapping decimal-digit-value
      digit-value numeric-value mirrored unicode10name
      iso10646-comment-field uppercase-mapping lowercase-mapping
      titlecase-mapping
    >.kv
  );

  my Hash $unicode-data = {};
  my Bool $first-of-range-found = False;
  my Str $codepoint-start;

  for 'UnicodeData.txt'.IO.lines -> $line is copy {

    # Comments and empty lines are removed
    $line ~~ s/ \s* '#' .* $//;
    next if $line ~~ m/^ \h* $/;

    # Split into the several fields
    my Array $unicode-data-entry = [$line.split(';')];
    my Str $catagory = $unicode-data-entry[2];

    # Check for the requested catagories
    if $ucd-cat[0] eq '*' or $unicode-data-entry[2] ~~ any(@$ucd-cat) {

      # Check for range start and save codepoint of start
      if !$first-of-range-found and $unicode-data-entry[1] ~~ m/ 'First>' / {
        $first-of-range-found = True;
        $codepoint-start = $unicode-data-entry[0];
      }

      # Check end of range and store
      elsif $first-of-range-found and $unicode-data-entry[1] ~~ m/ 'Last>' / {
        $first-of-range-found = False;

        my Str $entry = "0x$codepoint-start..0x$unicode-data-entry[0]";
        for ^ $ucd-names.elems -> $ui {
          $unicode-data{$entry}{$ucd-names{$ui}} =
            $unicode-data-entry[$ui] if ? $unicode-data-entry[$ui];
        }

        $unicode-data{$entry}<codepoint> = $entry;
      }

      # All else store directly
      else {
        my Str $entry = "0x$unicode-data-entry[0]";
        for ^ $ucd-names.elems -> $ui {
          $unicode-data{$entry}{$ucd-names{$ui}} =
            $unicode-data-entry[$ui] if ? $unicode-data-entry[$ui];
        }

        $unicode-data{$entry}<codepoint> = $entry;
      }
    }
  }

  $unicode-data;
};

#-------------------------------------------------------------------------------
sub prl-db ( List :cat($prl-cat) --> Hash ) {

  my Map $prop-names .= new( < codepoint property >.kv );
  my Hash $prop-data = {};

  for 'PropList.txt'.IO.lines -> $line is copy {

    # Comments and empty lines are removed
    $line ~~ s/ \s* '#' .* $//;
    next if $line ~~ m/^ \h* $/;

    # Split into the several fields
    my Array $prop-entry = [$line.split(/ \s* ';' \s* /)];
    my Str $catagory = $prop-entry[1];

    if $prl-cat[0] eq '*' or $catagory ~~ any (@$prl-cat) {
      for ^ $prop-names.elems -> $ui {
        my $entry = "0x$prop-entry[0]";
        $entry ~~ s/ '..' /..0x/;

        $prop-data{$entry}{$prop-names{$ui}} =
          $prop-entry[$ui] if ? $prop-entry[$ui];
      }
    }
  }
  
  $prop-data;
}

#-------------------------------------------------------------------------------
sub hst-db ( List :cat($hst-cat) --> Hash ) {

  my Map $hst-names .= new( < codepoint property >.kv );
  my Hash $hst-data = {};

  for 'HangulSyllableType.txt'.IO.lines -> $line is copy {

    # Comments and empty lines are removed
    $line ~~ s/ \s* '#' .* $//;
    next if $line ~~ m/^ \h* $/;

    # Split into the several fields
    my Array $hst-entry = [$line.split(/ \s* ';' \s* /)];
    my Str $catagory = $hst-entry[1];

    if $hst-cat[0] eq '*' or $catagory ~~ any (@$hst-cat) {
      for ^ $hst-names.elems -> $ui {
        my $entry = "0x$hst-entry[0]";
        $entry ~~ s/ '..' /..0x/;

        $hst-data{$entry}{$hst-names{$ui}} =
          $hst-entry[$ui] if ? $hst-entry[$ui];
      }
    }
  }

  $hst-data;
}

#-------------------------------------------------------------------------------
sub dgc-db ( List :cat($dgc-cat) --> Hash ) {

  my Map $dgc-names .= new( < codepoint property >.kv );
  my Hash $dgc-data = {};

  for 'extracted/DerivedGeneralCategory.txt'.IO.lines -> $line is copy {

    # Comments and empty lines are removed
    $line ~~ s/ \s* '#' .* $//;
    next if $line ~~ m/^ \h* $/;

    # Split into the several fields
    my Array $dgc-entry = [$line.split(/ \s* ';' \s* /)];
    my Str $catagory = $dgc-entry[1];

    if $dgc-cat[0] eq '*' or $catagory ~~ any (@$dgc-cat) {
      for ^ $dgc-names.elems -> $ui {
        my $entry = "0x$dgc-entry[0]";
        $entry ~~ s/ '..' /..0x/;

        $dgc-data{$entry}{$dgc-names{$ui}} =
          $dgc-entry[$ui] if ? $dgc-entry[$ui];
      }
    }
  }

  $dgc-data;
}

#-------------------------------------------------------------------------------
sub bdi-db ( List :cat($bdi-cat) --> Hash ) {

  my Map $bdi-names .= new( < codepoint property >.kv );
  my Hash $bdi-data = {};

  for 'extracted/DerivedBidiClass.txt'.IO.lines -> $line {
    extract-db( $bdi-cat, $line, $bdi-names, $bdi-data);
#`{{
    # Comments and empty lines are removed
    $line ~~ s/ \s* '#' .* $//;
    next if $line ~~ m/^ \h* $/;

    # Split into the several fields
    my Array $bdi-entry = [$line.split(/ \s* ';' \s* /)];
    my Str $catagory = $bdi-entry[1];

    if $bdi-cat[0] eq '*' or $catagory ~~ any (@$bdi-cat) {
      for ^ $bdi-names.elems -> $ui {
        my $entry = "0x$bdi-entry[0]";
        $entry ~~ s/ '..' /..0x/;

        $bdi-data{$entry}{ $bdi-names{$ui} } =
          $bdi-entry[$ui] if ? $bdi-entry[$ui];
      }
    }
}}
  }

  $bdi-data;
}

#-------------------------------------------------------------------------------
sub extract-db ( List $cat, Str $line is copy, Map $names, Hash $data ) {

#  my Map $bdi-names .= new( < codepoint property >.kv );
#  my Hash $bdi-data = {};

#  for 'extracted/DerivedBidiClass.txt'.IO.lines -> $line is copy {

    # Comments and empty lines are removed
    $line ~~ s/ \s* '#' .* $//;
    if $line !~~ m/^ \h* $/ {

      # Split into the several fields
      my Array $entry = [$line.split(/ \s* ';' \s* /)];
      my Str $catagory = $entry[1];

      if $cat[0] eq '*' or $catagory ~~ any (@$cat) {
        for ^ $names.elems -> $ui {
          my $cp-entry = "0x$entry[0]";
          $cp-entry ~~ s/ '..' /..0x/;

          $data{$cp-entry}{$names{$ui}} = $entry[$ui] if ? $entry[$ui];
        }
      }
    }
#  }

#  $data;
}

#-------------------------------------------------------------------------------
sub generate-module ( Hash :$data, --> Nil ) {

  my Str $class-text;
  my Str $modpath-name ='PRECIS::Tables::' ~  $module-name;
  my Str $fn = 'Tables.pm6';
  if $fn.IO ~~ :r {

    $class-text = slurp($fn);

    my Str $new-class-text = "module $modpath-name \{\n\n";
    $new-class-text ~= data-to-set( $modpath-name, $data);
    $new-class-text ~= data-to-table( $modpath-name, $data) if $table-too;
    $new-class-text ~= "};\n\n### NEW DATA ###\n";

    $class-text ~~ s/'### NEW DATA ###'/$new-class-text/;
  }
  
  else {
    $class-text = qq:to/HEADER/;
      use v6.c;
      
      # Place file Tables.pm6 in directory ./Unicode/PRECIS
      # Load with 'use Unicode::PRECIS::Tables'

      unit package Unicode;

      module $modpath-name \{

      HEADER

    $class-text ~= data-to-set( $modpath-name, $data);
    $class-text ~= data-to-table( $modpath-name, $data) if $table-too;
    $class-text ~= "};\n\n### NEW DATA ###\n";
  }

say "\n$class-text";

  spurt( $fn, $class-text);
}

#-------------------------------------------------------------------------------
sub data-to-set ( Str $modpath-name, Hash $data --> Str ) {

  my Str $text =
     "  # Use e.g. as '0x200C (elem) \$Unicode::{$modpath-name}::set;\n";
  $text ~= '  our $set = Set.new: (' ~ "\n    ";
  my Int $cnt = 1;
  for $data.keys.sort -> $cp {
    $text ~= "$cp, ";
    $text ~= "\n    " unless $cnt++ % 8;
  }

  $text ~= "\n  ).flat;\n";
}

#-------------------------------------------------------------------------------
sub data-to-table ( Str $modpath-name, Hash $data --> Str ) {

  my Str $text =
     "\n  # Use e.g. as '\$Unicode::{$modpath-name}::table\{0x200C}\<codepoint>;\n";
  $text ~= "  our \$table = \%(\n";
  my Int $cnt = 1;

  for $data.keys.sort -> $cp {
    $text ~= "    '$cp' => \%(\n";

    for $data{$cp}.keys.sort -> $cp-field {

      my Str $field-value = $data{$cp}{$cp-field};
      if $field-value ~~ m:i/^ <[0..9A..F\.]>+ $/ {
        $field-value = "0x$field-value";
        $field-value ~~ s/\.\./..0x/;
        $text ~= "      $cp-field => $field-value,\n";
      }

      else {
        $text ~= "      $cp-field => '$field-value',\n";
      }
    }

    $text ~= "    ),\n\n";
  }

  $text ~= "\n  );\n";
}

