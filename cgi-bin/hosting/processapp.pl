#!/usr/bin/perl

use CGI;

# Sends Errors to Browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

$hosting_file = "hosting.txt";

$sendmail = "/usr/lib/sendmail -t";

$redirect = "sign-up.pl";

if ($query->param()) {
	&setvars;
	&addaddy;
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
	$webname = $query->param('webname');
	$webaddy = $query->param('webaddy');
	$description = $query->param('description');
	$addywanted = $query->param('addywanted');
}

sub addaddy{
	open(HOSTING,$hosting_file);
	my @hosting = <HOSTING>;
	close(HOSTING);

	open(INFO,">> $hosting_file");
	flock INFO, 2;
	print INFO "$addywanted\n";
	close(INFO);
}

sub sendveri {
	open(MAIL, "|$sendmail");
	print MAIL <<SV;
From: hosting\@basicguruonline.com (BASIC Guru Online Hosting)
To: $email
Subject: Your application for BASIC Guru Online hosting was received

Hi, $name, you are receiving this email to notify you that your application for BASIC Guru Online hosting has been recieved.  Your website address DOES NOT work yet.  You will receive another email when the URL is up and running.  Just as a last check, here is the information you submitted:

Name of Website: $webname
Old Web Address: $webaddy
Website's Description: $description
New Web Address: http://$addywanted.basicguruonline.com/

If any of this information is invalid, reply to this email and send the correct information, along with your Name, User Name, and User ID\#.

Once again, your new web address is NOT operational.  It takes some time for it to be processed.  When it finally does work you will receive another email.

Thanks for being a part of BASIC Guru Online!

-Ben Ilegbodu (BASIC Guru Online webmaster)

SV
	close (MAIL);
}

sub sendmeinfo {
	open(MAIL, "|$sendmail");
	print MAIL<<SI;
From: $email ($name)
To: Benahimvp\@aol.com
Subject: Hosting Application for $webname

Here is all the information from $name for his/her site $webname

User ID\#: $userid
Name: $name
User Name: $username
E-mail: $email
Name of Website: $webname
Old Website Address: $webaddy
Website Description: $description
New Website Address: $addywanted

Go and add this URL to the list at basicguruonline.com.

SI
	close (MAIL);
}

sub thanks {
print $query->header;
print<<THANKS;

<head>
  <title>Application Sucessfully Submitted!</title>
<link href="../../hlb.css" rel="stylesheet">
<basefont size="2">
</head>

<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">

<p><script language="javascript" src="../../navi.js"></script></p>

<font size="5" color="#FF0000"><center>Application Sucessfully Submitted!</center></font>
<br>

<table border="0" cellspacing="0" cellpadding="2" width="100%">
  <tr>
	<td class="hlb"><a href="../../home.html">HOME</a> <b>>></b> <a href="/hosting/index.html">Hosting</a> <b>>></b>  <a href="sign-up.pl">Hosting Sign-Up</a>  <b>>> <i>Application Sucessfully Submitted!</i></b></td>
	</tr>
</table>

<br>
<font size="3">
<p align="justify">$name, your application for BASIC Guru Online has been successfully submitted.  You should be receiving an email shortly, which will be the final confirmation that your application was received.  As the email will tell you, the web address you chose is not operational yet.  You will receive another email later, when it is working.  However, in the time being you can <a href="add.pl">set up email addresses</a> to use on your site.  If you don't receive the email within <b>24 hours</b>, <a href="/contactme.html">let me know</a>.  Thanks for becoming a part of BASIC Guru Online!</p>
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