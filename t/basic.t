use strict;
use warnings;
use Test::More tests => 2;
use Log::Log4perl::Appender::TAP;

my $appender = eval { Log::Log4perl::Appender::TAP->new };
diag $@ if $@;
isa_ok $appender, 'Log::Log4perl::Appender::TAP';
isa_ok $appender, 'Log::Log4perl::Appender';
