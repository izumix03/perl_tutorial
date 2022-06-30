#!/usr/bin/perl
package MyObj;
use Moose;

has 'aaa' => (is => 'rw');

__PACKAGE__->meta->make_immutable();

no Moose;

use v5.30;

# my $obj = MyObj->new(aaa => 11);
# say $obj->aaa;

####################

package EchoServer;
use Moose;
has 'address' => (
    is       => 'rw',
    isa      => 'Str',
    required => 1,
);

has 'port' => (
    is       => 'rw',
    isa      => 'Int',
    required => 1,
    default  => 9999,
);
has 'server_socket' => (
    is         => 'rw',
    isa        => 'IO::Socket',
    # オブジェクトのデフォルト指定はこれだとだめ
    # default => sub {
    #     my $self = shift;
    #     IO::Socket::INET->new(
    #         Listen    => 5,
    #         LocalAddr => $self->address,
    #         LocalPort => $self->port,
    #         Proto     => 'tcp'
    #     )
    # }
    lazy_build => 1,
    # builder => 'build_server_socket'
);
sub _build_server_socket {
    my $self = shift;
    IO::Socket::INET->new(
        Listen    => 5,
        LocalAddr => $self->address,
        LocalPort => $self->port,
        Proto     => 'tcp',
    )
}

__PACKAGE__->meta->make_immutable();
no Moose;

use IO::Socket::INET;

# あとから追加
sub BUILD {
    my $self = shift;
    $self->bind();
    return $self;
}

sub bind {
    my $self = shift;
    my $socket = IO::Socket::INET->new(
        Listen    => 5,
        LocalAddr => $self->address,
        LocalPort => $self->port,
        Proto     => 'tcp',
    );
    if (!defined $socket) {die "failed to create socket: $@"};
    $self->server_socket($socket)
}

sub run {
    my $self = shift;
    my $socket = $self->server_socket;
    while (my $client = $socket->accept) {
        $self->process_request($client);
    }
}

sub process_request {
    my ($self, $client) = @_;
    while (!$client->eof) {
        my $req = $self->read_request($client);
        $self->write_response($client, $req);
    }
}

sub read_request {
    my ($self, $client) = @_;
    my $line = <$client>;
    return $line;
}

sub write_response {
    my ($self, $client, $request) = @_;
    print $client $request;
}

# EchoServer->new(); # Error

# my $s = EchoServer->new(address => '127.0.0.1', port => 9999);
# $s->bind;
# $s->run;

#####################################
package TimestampEchoServer;
use Moose;

extends 'EchoServer';

use Moose::Util::TypeConstraints;

subtype 'TimestampEchoServer::MultipleOfThree'
    => as 'Int'
    => where {$_ % 3 == 0}
    => message {"This number ($_) is not divisible by three!"};

coerce 'TimestampEchoServer::MultipleOfThree'
    => from 'Int'
    => via {$_ - $_ % 3};

has 'number' => (
    is     => 'rw',
    isa    => 'TimestampEchoServer::MultipleOfThree',
    coerce => => 1
);

# override して `super()` するのもOK
# 他のトリガーは after や around がある
# before 'write_response' => sub {
#     my ($self, $client, $request) = @_;
#     print $client scalar(localtime), " ";
# };

around 'write_response' => sub {
    my ($next, $self, $client, $request) = @_;
    $request = join(' ', scalar(localtime), $request);
    $next->($self, $client, $request);
};

no Moose;
no Moose::Util::TypeConstraints;

package main;

my $s = TimestampEchoServer->new(address => '127.0.0.1', port => 9999);
$s->number(4);
print $s->number;

# $s->bind;
# $s->run;

