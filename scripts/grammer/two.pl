#!/usr/bin/perl
use strict;
use warnings;
use utf8;

use v5.30;
use feature qw/signatures/;
no warnings qw/experimental::signatures/;

binmode(STDOUT, ":utf8");

# chomp(my $radius = <STDIN>);
# if ($radius < 0) {
#     say 0;
#     exit(0);
# }
# say $radius * 2 * 3.141592654;

# my $first = <STDIN>;
# chomp(my $second = <STDIN>);
# say $first x $second;

# my @people = qw(fred betty barney dino wilma pebbles bamm-bamm);
# chomp(my @lines = <STDIN>);
# for (@lines) {
#     say $people[$_];
# }

# sub sum($m, $n) {
#     $m + $n;
# }
# say sum(2,4);

sub total(@numbers) {
    my $num = 0;
    for (@numbers) {
        $num += $_;
    }
    $num;
}
my @fred = qw{1 3 5 7 9};
my $fred_total = total(@fred);
say "The total of \@fred is $fred_total.";

my $fileName = "test.dat";
open my $rocks_fh, '<', $fileName
    or die "Could not open rocks.txt: $!";

while (<$rocks_fh>) {
    chomp;
    say;
}
close $rocks_fh;