use warnings;
use strict;

use Test::More tests => 5;
BEGIN {use_ok('Net::Ping')};

SKIP: {
    eval {
       require Net::Ping::External;
    };
    skip "No Net::Ping::External", 2 if $@;
    my $p = Net::Ping->new('external');
    isa_ok($p, "Net::Ping");
    my $result = $p->ping("www.google.com");
    is($result, 1, 'tested $p->ping using external');
}

SKIP: {
    eval {
       require Net::Ping::External;
    };
    skip "No Net::Ping::External", 2 unless $@;
    my $p = Net::Ping->new('external');
    isa_ok($p, "Net::Ping");
    eval {
        my $result = $p->ping("www.google.com");
    };
    like($@, qr/Protocol "external" not supported on your system: Net::Ping::External not found/, "Missing Net::Ping::External handled correctly");
}
