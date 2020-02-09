#!/usr/bin/perl

use CGI;

# Sends Errors to Browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

print $query->header;

$id = scalar time();

print time;
print "<br>Hey";