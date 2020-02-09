#!/usr/bin/perl

use CGI;

# Sends Errors to Browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

$sendmail = "/usr/lib/sendmail -t";

$redirect = "/home.html";

$updates_file = "updates.txt";

if ($query->param()) {
	&setvars;
	if ($sent eq 'yes') {
		&sendform;
		&sent;
	}
	else {
		&displayform;
		&sendupdates;
	}
}
else {
	print $query->redirect($redirect);
}

sub setvars {
	$sent = $query->param('sent');
	$subject = $query->param('subject');
	$body = $query->param('body');
}

sub displayform {
	print $query->header;
	print<<FORM;
	<head>
		<title>Updates Form</title>
<link href="/hlb.css" rel="stylesheet">
	</head>
<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">

<font face="Times New Roman, Times, Serif">

<p><script language="javascript" src="/navi.js"></script></p>

<b><font size="4">Updates Form</font></b>
<hr>

<table border="0" cellspacing="0" cellpadding="2" width="100\%">
  <tr>
	<td class="hlb"><a href="/home.html">HOME</a> <b>>> <i>Updates Form</i></b></td>
	</tr>
</table>


<form action="updates.pl" method="post">

<p align="center"><input type="text" name="subject" size="65" /></p>

<p align="center">
<textarea name="body" rows="30" cols="65" wrap="on"></textarea>
</p>

<input type="hidden" name="sent" value="yes" />
<p align="center"><input type="submit" value="Send Updates"></p>
</form>

<p><script language="javascript" src="/navi.js"></script></p>
<br><br>

<script src="/foot.js"></script>

<hr>
<br>
<center><small>Problems with this page?<br>
Contact the <a href="/contactme.html">Webmaster</a>.
</small>
</center>

</font>
</body>
</html>
FORM
}

sub sendform {
	open(UPDATES,$updates_file);
	@updates=<UPDATES>;
	close(UPDATES);

	$email = @updates[0];

	$email = 'ben@basicguruonline.com, archives@basicguruonline.com, Benahimvp@aol.com';

	open(MAIL, "|$sendmail");
	print MAIL <<SV;
From: updates\@basicguruonline.com (BASIC Guru Online Updates)
To: $email
Subject: $subject
Content-type: text/html

$body

<p align="justify">
-Ben Ilegbodu<br />
(<a href="http://www.basicguruonline.com/">http://basicguruonline.com</a>)
</p>

SV
	close (MAIL);
}

sub sent {
	print $query->header;
	print "Sent";
}