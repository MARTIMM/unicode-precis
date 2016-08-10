use v6.c;

unit package Unicode;

#-------------------------------------------------------------------------------
module Stringprep::Common {

  #-----------------------------------------------------------------------------
  sub mk-set ( Str $set-table --> Array ) is export {

    my Array $data = [];
    for $set-table.lines -> $line {

      ( my $from, my $comment) = $line.split(';');
      ( $from, my $to) = $from.split( '-', 2);

      $from ~~ s:g:i/<-[0..9A..Z-]>//;
      $to ~~ s:g:i/<-[0..9A..Z-]>// if $to.defined;

      $data.push: :16($from), $to ?? :16($to) !! Any;
    }

    $data;
  };

  #-----------------------------------------------------------------------------
  sub mk-map ( Str $map-table --> Array ) is export {

    my Array $data = [];
    for $map-table.lines -> $line {

      ( my Str $from, my Str $to, my Str $comment) = $line.split(';'); 

      $from ~~ s:g:i/<-[0..9A..F]>//;
      $to ~~ s:g:i/<-[0..9A..F ]>//;

      $data.push:
        :16($from), 
        join( '', map {  $_ eq '' ?? '' !! chr(:16($_))}, $to.split(' '))
        ;
    }

    $data;
  };
}
