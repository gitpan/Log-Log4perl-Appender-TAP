package Log::Log4perl::Appender::TAP;

use strict;
use warnings;
use v5.10;
use Test::Builder::Module;
our @ISA = qw( Log::Log4perl::Appender );

# ABSTRACT: Append to TAP output
our $VERSION = '0.01'; # VERSION


sub new
{
  my $proto = shift;
  my $class = ref $proto || $proto;
  my %args = @_;
  bless {
    builder => Test::Builder::Module->builder,
    method  => $args{method} // 'note',
  }, $class;
}

sub _builder { shift->{builder} }

sub log
{
  my $self = shift;
  my %args = @_;
  my $method = $self->{method};
  $self->_builder->$method($args{message});
  return;
}

1;

__END__

=pod

=head1 NAME

Log::Log4perl::Appender::TAP - Append to TAP output

=head1 VERSION

version 0.01

=head1 SYNOPSIS

 use Test::More tests => 1;
 
 LOG::Log4perl::init(\<<CONF);
 log4perl.rootLogger=ERROR, TAP
 log4perl.appender.TAP=Log::Log4perl::Appender::TAP
 log4perl.appender.TAP.method=diag
 log4perl.appender.TAP=layout=PatternLayout
 log4perl.appender.TAP=layout.ConversionPattern="[%rms] %m%n
 CONF
 
 DEBUG "this message doesn't see the light of day";
 ERROR "This gets logged to TAP using diag";
 
 pass 'okay';

=head1 DESCRIPTION

This very simple appender sends log output to TAP using
L<Test::Builder>.  It only takes one special argument,
the method, which can be either C<diag> or C<note>.

=head1 AUTHOR

Graham Ollis <plicease@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
