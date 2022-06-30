#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use v5.10;

# スカラー変数: $

my $msg = "Hello world";
print "$msg\n";

my $x = 10;
my $y = 10.77;
my $z = 123_234_345;

# 演算
my $xx = $x * $y;
print($xx . "\n");

$z += 5;
print $z . "\n";

# 再代入を防げない？

my $aText = 'a' . 'b';
$aText .= 'c';
print $aText . "\n";

# 配列変数
my @mixed = (100, 'red', 1.5);
print @mixed . "\n";

my @inc = (1 .. 100);
print("@inc\n");

my @colors = qw(red green blue);
print("@colors\n");

print("$colors[1]\n");
print("$colors[-1]\n");
print("@colors[0 .. 1]\n");
print("@colors[0 .. 0]\n");
print("@colors[1 .. $#colors]\n");

# ハッシュ変数
my %sales = ("tanaka" => 300, "suzuki" => 150, "ohira" => 200);
print $sales{"tanaka"} . "\n";

# 条件分岐
## 数値: < > <= >= == !=
## 文字列: eq ne gt lt ge le
### 0-9 < A-Z < a-z
my $score = 85;

if ($score >= 88) {
    print("OK\n");
} elsif ($score < 9) {
    print("NG!!\n");
} else {
    print("so so..\n");
}

my $name = "Luke";

if ($name eq "Luke") {
    print("I am your father!!\n");
}

## 論理演算子
### && || !

if ($name eq "Luke" && $score >= 80) {
    print("great!!\n");
}

## if文の後置
print("OK!!\n") if ($score >= 80);

## 三項演算子
$score >= 80 ? print("三項演算子\n") : print("三項演算子else\n");

## 繰り返し処理
my $index = 0;

while ($index < 10) {
    print "i = $index\n";
    $index++;
}

# for
for (my $i = 0; $i < 10; $i++) {
    print "for i = $i\n";
}

# 配列ループ(foreach)
my @loop_colors = qw(red green blue orange pink);

foreach my $color (@loop_colors) {
    print("color is $color\n");
}

print("-----\n");

for my $color (@loop_colors) {
    print("color is $color\n");
}

print("-----\n");

for (@loop_colors) {
    print("color is $_\n");
}

# hash のループ(特殊変数で省略)
print("-----\n");
my %hashSales = ("tanaka" => 150, "suzuki" => 300, "ohira" => 200);

foreach my $key (keys(%hashSales)) {
    print("sales person is $key, sale is $hashSales{$key}\n");
}
print("-----\n");
for (keys %sales) {
    print("sales person is $_, sale is $sales{$_}\n");
}

# ファイル操作
# 正規表現 特殊変数への処理は省略可能...

open(my $in, "<", "test.dat") or die("could not open file");
while (<$in>) {
    # $_ =~ s/a/A/;
    s/a/A/;

    # if ($_ =~ /[a-z]/) {
    if (/[a-z]/) {
        print $_;
    }
}
close($in);

# サブルーチン
# 最後の評価変数が return される
sub sum {
    my $max = $_[0];
    if ($_[1] > $max) {
        $max = $_[1];
    }
    # return $max;
    $max;
}

print sum(12, 1)."\n";

sub multiMax {
    # my $max = shift(@_);
    my $max = shift;
    for (@_) {
        $max = $_ if $_ > $max;
    }
    $max;
}

print multiMax(1,2,3,4,5,6)."\n";

my @lines = `perldoc -u -f atan2`;
for (@lines) {
    print;
}

print 0x1f."\n";
say 0x1f.p3; # = 0x1f * 2**3

say "The answer is", 6*7;

chomp(my $stdin = <STDIN>);
if ($stdin eq "\n") {
    say "That was just a blank line";
} else {
    say $stdin;
}