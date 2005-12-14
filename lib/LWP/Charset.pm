#!/usr/pkg/bin/perl

package LWP::Charset;

use LWP::UserAgent;
use UNIVERSAL qw(isa);

require Exporter;
@ISA = qw(Exporter);
@EXPORT_OK = qw(getCharset getCharsetFromHeader getCharsetFromMeta);

use vars qw/$VERSION/;

$VERSION = '0.05';

=head1 NAME

LWP::Charset - Retrive charset information of a response object.

=head1 SYNOPSIS

    use LWP::UserAgent;
    use LWP::Charset qw(getCharset);

    my $ua = LWP::UserAgent->new( timeout => 30 );
    $response = $ua->get('http://search.cpan.org/');

    $charset  = getCharset($response);

    print $charset;

=head1 DESCRIPTION

This module help you to determine the charset coding of web pages
(type text/plain or text/html).

=head1 FUNCTIONS

=head2 getCharset($response)

$response: A HTTP::Response object which is_success().
This is a wrapper of getCharsetFromHeader() and getCharsetFromMeta().

=cut

sub getCharset {
    my ($response) = @_;
    return getCharsetFromHeader($response) || getCharsetFromMeta($response);
}

=head2 getCharsetFromHeader($response)

Look into HTTP header to see if Content-Type containt charset
information.  Return lowercased charset string or undef if failed.

=cut

sub getCharsetFromHeader {
    my ($response) = @_;

    my $headers = $response->headers();
   
    if(isa $headers->{'content-type'}, "ARRAY") {
	$cth = $headers->{'content-type'}->[1];
    } else {
	$cth = $headers->{'content-type'};
    }
    my ($charset) = $cth =~ /charset=([^\s";]*)/ ;
    return lc($charset);
}

=head2 getCharsetFromMeta($response)

Look into HTML meta tag, to see if there's some charset
information.  Return lowercased charset string or undef if failed.

=cut

sub getCharsetFromMeta {
    my ($response) = @_;
    getCharsetFromMetaString($response->content);
}

=head2 getCharsetFromMetaString($string)

An internally used subroutine which accept a string and find meta tags inside,
retrive possible charset information. Return lowercased charset string or
undef if failed to find any.

=cut

sub getCharsetFromMetaString {
    my ($string) = @_;
    while($string =~ /(<meta.*?>)/gis) {
	my $meta = $1;
	if(my ($charset) = $meta =~ /charset=([^\s";]*)/) {
	    return lc($charset);
	}
    }
    return;
}

=head1 COPYRIGHT

Copyright 2003,2004,2005 by Kang-min Liu <gugod@gugod.org>.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

See <http://www.perl.com/perl/misc/Artistic.html>

=cut

1;
