#!/usr/bin/perl
use strict;
use warnings;
use utf8;
binmode(STDOUT, ":utf8");

use v5.30;
use feature qw/signatures/;
no warnings qw/experimental::signatures/;

my %family_name = ('foo', 35, 'bar', 20);
my $foo_name =  $family_name{'foo'};
say $foo_name;

my @to_arr =  %family_name;
say "@to_arr";

$_ = 'yabba dabba doo';
if (my @place = /y(....)/) {
    print @place;
}