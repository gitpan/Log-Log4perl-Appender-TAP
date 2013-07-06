use strict;
use warnings;
use Test::More tests => 1;
use Log::Log4perl qw( :easy );

Log::Log4perl::init(\<<CONF);
log4perl.rootLogger=DEBUG, AppDebug, AppError

log4perl.filter.MatchError = Log::Log4perl::Filter::LevelMatch
log4perl.filter.MatchError.LevelToMatch = ERROR
log4perl.filter.MatchError.AcceptOnMatch = true

log4perl.filter.MatchDebug = Log::Log4perl::Filter::LevelMatch
log4perl.filter.MatchDebug.LevelToMatch = DEBUG
log4perl.filter.MatchDebug.AcceptOnMatch = true

log4perl.appender.AppDebug=Log::Log4perl::Appender::TAP
log4perl.appender.AppDebug.method=note
log4perl.appender.AppDebug.layout=PatternLayout
log4perl.appender.AppDebug.layout.ConversionPattern=[%rms] %m%n
log4perl.appender.AppDebug.Filter = MatchDebug

log4perl.appender.AppError=Log::Log4perl::Appender::TAP
log4perl.appender.AppError.method=diag
log4perl.appender.AppError.layout=PatternLayout
log4perl.appender.AppError.layout.ConversionPattern=[%rms] %m%n
log4perl.appender.AppError.Filter = MatchError

CONF

DEBUG "this is debug";
ERROR "this is error";

pass 'okay';
