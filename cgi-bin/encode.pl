#!/usr/bin/perl

use CGI;

# Sends Errors to Browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

print $query->header;

$letter = "v";

print "$letter<br>";

$letter = chr(2*(ord($letter)-15));

print "$letter<br>";

$letter =~ s/([^a-zA-Z0-9])/'%'.unpack("H*",$1)/eg;

print "$letter<br>";

$letter =~ s/%([0-9a-fA-F]{2})/pack("c",hex($1))/ge;

print "$letter<br>";

$letter = chr((ord($letter)/2)+15);

print "$letter<br>hello";