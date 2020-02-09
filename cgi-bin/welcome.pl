#!/usr/bin/perl

use CGI;

$query = new CGI;

$redirect = "/home.html";

if (!$query->param()) {
	print $query->redirect($redirect);
}
else {
	$id = "welcome";
	if ($query->cookie($id)) {
		&welback;
	}
	else {
		&setcookie;
		&welcome;
		&popup;
	}
}

sub welback {
	$name = $query->cookie(-name=>'$id');
	print<<WELBACK;
Content-type:application/x-javascript\n\n
document.write("Welcome back, $name, ")
WELBACK
}

sub setcookie {
	$cookie = $query->cookie(-name=>$id,
													 -value=>'$name',
													 -expires=>'+100M',
													 -path=>'/');
	print $query->header(-cookie=>$cookie);
}


sub welcome {
	print "Content-type:application/x-javascript\n\n";
	$name = prompt('Please enter your name', ' ');
	if (($name eq ' ') || ($name eq 'null')) {
		$name = "Guest";
	}
	print<<WELCOME;
document.write("Welcome, $name, ")
WELCOME
}

sub popup {
	$page = "/pop-up.html";
	$windowprops = "width=300,height=250,location=no,toolbar=no,menubar=no,scrollbars=no,resizable=no";
	print<<POPUP;
	window.open($page, "", $windowprops);
POPUP
}