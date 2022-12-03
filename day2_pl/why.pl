#!/usr/bin/perl

#use warnings;
#use strict;

open(D, '<', './datum') or die $!;

our %win = ('A' => 'Y', 'B' => 'Z', 'C' => 'X');
our %draw = ('A' => 'X', 'B' => 'Y', 'C' => 'Z');
our %lose = ('A' => 'Z', 'B' => 'X', 'C' => 'Y');
our %points = (X => 1, Y => 2, Z => 3);

my $p = 0;
my $p2 = 0;

our %map = (
  X => \%lose,
  Y => \%draw,
  Z => \%win
);

while(<D>){
    my ($a, $b) = split / /, $_;
    $b =~ s/^\s+|\s+$//;
    $p = $p + $points{$b};
    $p2 += ($points{$b}-1)*3;
    $p2 += $points{$map{$b}{$a}};
    if($win{$a} eq $b){
      $p += 6;
    } elsif ($draw{$a} eq $b){
      $p += 3;
    }
}

print('part 1: ', $p, "\n");
print('part 2: ', $p2, "\n");

#use Lingua::Romana::Perligata;
#Hello tum lacunam inquementum tum world tum novumversum egresso scribe.

