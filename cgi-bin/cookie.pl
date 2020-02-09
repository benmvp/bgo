#!/usr/bin/perl

use CGI;

# Sends Errors to Browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

$value = $query->cookie(-name=>'poll3');

print $query->header;

print $value;