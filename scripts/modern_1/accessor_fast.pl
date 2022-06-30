#!/usr/bin/perl
package MyObject;
use strict;
use warnings;
use utf8;
binmode(STDOUT, ":utf8");
use v5.30;

use base qw(Class::Accessor::Fast);

__PACKAGE__->mk_accessors(qw(aaa bbb ccc));


my $obj = MyObject->new();
print $obj->aaa(123)."\n";
print $obj->aaa."\n";

my $obj2 = MyObject->new({aaa => 222});
print $obj2->aaa."\n";