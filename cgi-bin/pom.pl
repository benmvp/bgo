#!/usr/bin/perl

use CGI;

# Sends Errors to Browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

$sendmail = "/usr/lib/sendmail -t";

$redirect = "/awards.html\#pom";

if ($query->param()) {
	&setvars;
	if ($query->cookie($id)) {
		&alreadyvoted;
	}
	else {
	&sendmeinfo;
	&setcookie;
	&success;
	}
}
else {
	print $query->redirect($redirect);
}

sub setvars {
	$pom = $query->param('pom');
	$member = $query->param('member');
	$id = "pom";
}

sub sendmeinfo {
	$ip = $query->remote_addr();
	open(MAIL, "|$sendmail");
	print MAIL<<SI;
From: pom\@basicguruonline.com
To: Benahimvp\@aol.com
Subject: Program of the Month Poll

Somebody voted for $pom for this month's Program of the Month poll.  Here's the info:

Program: $pom
Member: $member

IP Address: $ip

SI
	close (MAIL);
}

sub setcookie {
	($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
	$exp = 17 - $mday;
	$cookie = $query->cookie(-name=>$id,
													 -value=>'polls',
													 -expires=>'+' . $exp . 'd',
													 -path=>'/');
	print $query->header(-cookie=>$cookie);
}

sub success {
print<<PAGE;
<head>
	<title>Program of the Month poll</title>
<link href="../hlb.css" rel="stylesheet">
</head>

<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">
<font face="Times New Roman, Times, Serif">

<p align="center">Your vote for <font color="#008000">$pom</font> has been submitted.  Check back on the 14<sup>th</sup> to see the results of the poll.</p>

<p align="center"><a href="/awards.html\#som">Back to awards page</a></p>

</font>
</body>
</html>
PAGE
}

sub alreadyvoted {
print $query->header;
print<<VOTED;
<head>
	<title>Program of the Month poll</title>
<link href="../hlb.css" rel="stylesheet">
</head>

<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">
<font face="Times New Roman, Times, Serif">

<p align="center">Your vote for <font color="#008000">$pom</font> was NOT counted because you have already voted in the Program of the Month poll for this month.  You will have to wait for next month's poll in order to vote again.</p>

<p align="center"><a href="/awards.html\#som">Back to awards page</a></p>

</font>
</body>
</html>
VOTED
}