#!/usr/bin/perl

use CGI;

# Sends Errors to Browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

$sendmail = "/usr/lib/sendmail -t";

$redirect = "submit.pl";

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
	$title = $query->param('title');
	$platform = $query->param('platform');
	$language = $query->param('language');
	$genre = $query->param('genre');
	$description = $query->param('description');
	$filename = $query->param('filename');
	$documentation = $query->param('documentation');
	$ss = $query->param('ss');
	$update = $query->param('update');
	$pud = $query->param('pud');
}

sub sendveri {
	open(MAIL, "|$sendmail");
	print MAIL <<SV;
From: archives\@basicguruonline.com (BASIC Guru Online Archives)
To: $email
Subject: Submitted Program -- $title

Hi, $name, you are receiving this email message to notify you that the information for $title has been received.  You actually have not completed the submission process, however.  First, make a last check on the information that you just submitted:

Title: $title
Category: $platform $language $genre
Description: $description
Documentation? $documentation
Screenshot(s)? $ss
Update? $update
Former PUD? $pud

If this information is all correct, then you can go on to the final step.  Reply to this email message leaving the subject line EXACTLY how it is and send it with $filename.zip as an attachment.  This is how I will receive your actual program.  If you fail to fufill this last requirement, your program will not be added to the BASIC Guru Online Program Archives.  So just reply to this email and send $filename.zip as an attachment and it will get added shortly.  It is not necessary to put anything in the body, but if you have to put something write: $title program submission ($filename.zip).

If it so happens that some of the information above is wrong, reply to this email and send the correct information along with $filename.zip (attached) and your Name, User Name, and User ID\#.

If $title is not the only program that you want to submit, send $filename.zip first and then go back to the Program Submission form and submit your next program.

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
Subject: Program Submission for $title

Here is all the information from $name for his/her submitted program $title ($filename.zip) 

User ID\#: $userid
Name: $name
User Name: $username
E-mail: $email
Title: $title
Category: $platform $language $genre
Description: $description
Filename: $filename.zip
Documenation? $documentation
Screenshot(s)? $ss
Update? $update
Former PUD? $pud

You should have also received $filename.zip in attachment so go check and see.

SI
	close (MAIL);
}

sub thanks {
print $query->header;
print<<THANKS;

<head>
  <title>Program Information Sucessfully Submitted!</title>
<link href="../../hlb.css" rel="stylesheet">
<basefont size="2">
</head>

<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">

<p><script language="javascript" src="../../navi.js"></script></p>

<font size="5" color="#FF0000"><center>Program Information Sucessfully Submitted!</center></font>
<br>

<table border="0" cellspacing="0" cellpadding="2" width="100%">
  <tr>
	<td class="hlb"><a href="../../home.html">HOME</a> <b>>></b> <a href="/archives/index.html">Program Archives</a> <b>>></b>  <a href="submit.pl">Program Submission</a>  <b>>> <i>Program Information Sucessfully Submitted!</i></b></td>
	</tr>
</table>

<br>
<font size="3">
<p align="justify">$name, the information for $title has been successfully submitted.  You are probably wondering when you are going to submit the <b>actual</b> program ($filename.zip).  This is all addressed in the email that you should be receiving shortly.  It'll tell you all that you need to do in order to complete the program submission process.  If you don't receive the email within <b>24 hours</b>, <a href="/contactme.html">let me know</a>.</p>

<p align="justify">If you have more than one program to submit, follow the instructions given in the email and then go back to the <a href="submit.pl">Program Submission</a> form.</p>

<p align="center">Thanks for being a part of BASIC Guru Online!</p>
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