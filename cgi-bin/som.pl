#!/usr/bin/perl

use CGI;

# Sends Errors to Browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

$sendmail = "/usr/lib/sendmail -t";

$redirect = "/awards.html\#som";

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
	$som = $query->param('som');
	$member = $query->param('member');
	$id = "som";
}

sub sendmeinfo {
	$ip = $query->remote_addr();
	open(MAIL, "|$sendmail");
	print MAIL<<SI;
From: som\@basicguruonline.com
To: Benahimvp\@aol.com
Subject: Site of the Month Poll

Somebody voted for $som for this month's Site of the Month poll.  Here's the info:

Site: $som
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
	<title>Site of the Month poll</title>
<link href="../hlb.css" rel="stylesheet">
</head>

<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">
<font face="Times New Roman, Times, Serif">

<p align="center">Your vote for <font color="#008000">$som</font> has been submitted.  Check back on the 14<sup>th</sup> to see the results of the poll.</p>

<p align="center"><a href="/awards.html\#pom">Back to awards page</a></p>

</font>
</body>
</html>
PAGE
}

sub alreadyvoted {
print $query->header;
print<<VOTED;
<head>
	<title>Site of the Month poll</title>
<link href="../hlb.css" rel="stylesheet">
</head>

<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">
<font face="Times New Roman, Times, Serif">

<p align="center">Your vote for <font color="#008000">$som</font> was NOT counted because you have already voted in the Site of the Month poll for this month.  You will have to wait for next month's poll in order to vote again.</p>

<p align="center"><a href="/awards.html\#pom">Back to awards page</a></p>

</font>
</body>
</html>
VOTED
}