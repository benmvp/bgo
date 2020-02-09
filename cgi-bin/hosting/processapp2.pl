#!/usr/bin/perl

use CGI;

# Sends Errors to Browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

$hosting_file = "hosting.txt";

$sendmail = "/usr/lib/sendmail -t";

$redirect = "add.pl";

if ($query->param()) {
	&setvars;
	&sendveri;
	&sendmeinfo;
	&thanks;
}
else {
	print $query->redirect($redirect);
}

sub setvars {
	$name = $query->param('name');
	$username = $query->param('username');
	$userid = $query->param('userid');
	$email = $query->param('email');
	$hostname = $query->param('hostname');
	$emaila = $query->param('emaila');
	$emailb = $query->param('emailb');
	$emailc = $query->param('emailc');
	$emaild = $query->param('emaild');
	$emaile = $query->param('emaile');
	$addys = "$emaila.$hostname\@basicguruonline.com";
	if ($emailb) {
		$addys .= ", $emailb.$hostname\@basicguruonline.com";
	}
	if ($emailc) {
		$addys .= ", $emailc.$hostname\@basicguruonline.com";
	}
	if ($emaild) {
		$addys .= ", $emaild.$hostname\@basicguruonline.com";
	}
	if ($emaile) {
		$addys .= ", $emaile.$hostname\@basicguruonline.com";
	}
}

sub sendveri {
	open(MAIL, "|$sendmail");
	print MAIL <<SV;
From: hosting\@basicguruonline.com (BASIC Guru Online Hosting)
To: $email
Subject: Your email address submissions have been received

Hi $name, you are receiving this email to notify you that the email addresses that you submitted have been received.  Just like with the web address, they will not work immediately.  You will most likely receive word that your email addresses work in the same email that tells you that your web address works.  It just may happen that the email addresses begin working before the web address.  Just as a last check, here is the information you submitted:

Host Name: $hostname
Email Addresses: $addys

If any of this information is invalid, reply to this email and send the correct information, along with your Name, User Name, and User ID\#.

Thanks for becoming a part of BASIC Guru Online!

-Ben Ilegbodu (BASIC Guru Online webmaster)

SV
	close (MAIL);
}

sub sendmeinfo {
	open(MAIL, "|$sendmail");
	print MAIL<<SI;
From: $email ($name)
To: Benahimvp\@aol.com
Subject: Hosting Application for $hostname

Here is all the information from $name for his/her domain name: $hostname

User ID\#: $userid
Name: $name
User Name: $username
E-mail: $email
Host Name: $hostname
Email Addresses: $addys

Go and add this email lists to the list at basicguruonline.com.

SI
	close (MAIL);
}

sub thanks {
print $query->header;
print<<THANKS;

<head>
  <title>Email Addresses Sucessfully Submitted!</title>
<link href="../../hlb.css" rel="stylesheet">
<basefont size="2">
</head>

<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">

<p><script language="javascript" src="../../navi.js"></script></p>

<font size="5" color="#FF0000"><center>Email Addresses Sucessfully Submitted!</center></font>
<br>

<table border="0" cellspacing="0" cellpadding="2" width="100%">
  <tr>
	<td class="hlb"><a href="../../home.html">HOME</a> <b>>></b> <a href="/hosting/index.html">Hosting</a> <b>>></b>  <a href="sign-up.pl">Hosting Sign-Up</a>  <b>>> <i>Email Addresses Sucessfully Submitted!</i></b></td>
	</tr>
</table>

<br>
<font size="3">
<p align="justify">$name, your email addresses for your site hosted BASIC Guru Online have been successfully submitted.  You should be receiving an email shortly, which will be the final confirmation that your email addresses were in fact received.  As the email will tell you, the email addresses you chose are not operational yet.  You will receive another email later, when they are working.  If you don't receive the email within <b>24 hours</b>, <a href="/contactme.html">let me know</a>.  Thanks for being a part of BASIC Guru Online!</p>
</font>

<p><script language="javascript" src="../../navi.js"></script></p>

<br><br>

<script src="../../foot.js"></script>

<hr>
<br>
<center><small>Problems with this page?<br>
Contact the <a href="../../contactme.html">Webmaster</a>.
</small>
</center>

</font>
</body>
</html>
THANKS
}