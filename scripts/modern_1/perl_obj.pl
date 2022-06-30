#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

package MyObject;

sub new {
    my $class = shift;
    my %args = @_;

    my $self = bless {
        'aaa' => $args{aaa}
    }, $class;
    return $self;
}
# sub aaa {
#     my $self = shift;
#     return $self->{aaa} + 1;
# }
sub _element {
    my $self = shift;
    my $name = shift;
    my $ret = $self->{$name};
    if (@_) {
        $self->{$name} = shift @_;
    }
    return $ret;
}

sub aaa {shift->_element('aaa', @_)}

my $obj = MyObject->new(aaa => 123);
print $obj->aaa."\n";
print $obj->aaa(2)."\n";
print $obj->aaa."\n";