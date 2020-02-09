#!/usr/bin/perl

use CGI;

# Sends Errors to Browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

$sendmail = "/usr/lib/sendmail -t";

$redirect = "../../archives/index.html";

if (!$query->param()) {
	print $query->redirect($redirect);
}
else {
	&setvars;
	if ($query->cookie($id)) {
		&alreadynom;
	}
	else {
		&sendnom;
		&setcookie;
		&displaynom;
	}
}

sub setvars {
	$title = $query->param('title');
	$category = $query->param('category');
	$filename = $query->param('filename');
	$directory = $query->param('directory');
	$id = $directory . "/" . $filename . "-nom";
	$nextpage = $directory. "/progs.pl?prog=" . $filename;
}

sub sendnom {
	$ip = $query->remote_addr();
	open(MAIL, "|$sendmail");
	print MAIL <<SN;
From: archives\@basicguruonline.com (BASIC Guru Online Program Archives)
To: Benahimvp\@aol.com
Subject: POM Nomination - $title ($category)

$title ($category) has been nominated for the Program of the Month poll.

IP Address: $ip

SN
	close (MAIL);
}

sub setcookie {
	($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
	$exp = 31 - $mday;
	$cookie = $query->cookie(-name=>$id,
													 -value=>'nom',
													 -expires=>'+' . $exp . 'd',
													 -path=>'/');
	print $query->header(-cookie=>$cookie);
}

sub displaynom {
	print<<NOM;
<html>
<head>
	<title>POM Nomination for $title</title>
<link href="../../hlb.css" rel="stylesheet">
</head>

<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">
<font face="Times New Roman, Times, Serif">

<p align="center">Your nomination for $title ($category) for the Program of the Month poll has been sent.  Thank you for nominating $title.</p>

<p align="center"><a href="$nextpage">Back to $title profile page</a></p>

</font>
</body>
</html>
NOM
}

sub alreadynom {
print $query->header;
	print<<ALREADY;
<html>
<head>
	<title>POM Nomination for $title</title>
<link href="../../hlb.css" rel="stylesheet">
</head>

<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">
<font face="Times New Roman, Times, Serif">

<p align="center">You have already nominated $title for the Program of the Month poll.</p>

<p align="center"><a href="$nextpage">Back to $title profile page</a></p>

</font>
</body>
</html>
ALREADY
}