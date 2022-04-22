#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

# スカラー変数: $

my $msg = "Hello world";
print "$msg\n";

my $x = 10;
my $y = 10.77;
my $z = 123_234_345;

# 演算
my $xx = $x * $y;
print($xx."\n");

$z += 5;
print $z."\n";

# 再代入を防げない？

my $aText = 'a'.'b';
$aText .= 'c';
print $aText."\n";

# 配列変数
my @mixed = (100, 'red', 1.5);
print @mixed."\n";

my @inc = (1..100);
print("@inc\n");

my @colors = qw(red green blue);
print("@colors\n");

print("$colors[1]\n");
print("$colors[-1]\n");
print("@colors[0..1]\n");
print("@colors[1..$#colors]\n");

