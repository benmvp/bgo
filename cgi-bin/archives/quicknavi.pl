#!/usr/bin/perl

use CGI;

# Sends Errors to Browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

$redirect = "../../archives/index.html";

if (!$query->param()) {
	print $query->redirect($redirect);
}
else {
	&setvars;
	print $query->redirect($category);
}

sub setvars {
	$calc = $query->param('calc');
	$lang = $query->param('lang');
	$type = $query->param('type');
	$category = $calc . "/" . $lang . "/" . $type . "/index.pl";
	if (($calc eq "ti-82") && ($lang eq "assembly")) {
		$category = "/archives/ti-82/assembly/index.html"
	}
}