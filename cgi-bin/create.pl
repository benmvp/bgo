#!/usr/bin/perl

use CGI;

# Sends Errors to Browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

$new_file = "archives/ti-82/newfile.txt";

open(NEWFILE, ">$new_file");
print NEWFILE "I hope this works";
close(NEWFILE);

print $query->header;
print "It worked!!";