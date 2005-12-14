#!/usr/bin/perl
use strict;
use warnings;
use LWP::Charset;
use Test::More qw(no_plan);

my $result = LWP::Charset::getCharsetFromMetaString(<<META3);
<meta http-equiv="nothing" content="loren ipsum" />
<meta http-equiv="nothing2" content="loren ipsum" />
<meta http-equiv="nothing3" content="loren ipsum" />
<meta http-equiv="nothing4" content="loren ipsum" />
META3
ok(!defined($result));

ok(LWP::Charset::getCharsetFromMetaString(<<META2) eq "utf-8");
<meta http-equiv="nothing" content="loren ipsum" />
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
META2

ok(LWP::Charset::getCharsetFromMetaString(<<META1) eq "utf-8");
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
META1




