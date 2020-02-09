#!/usr/bin/perl

use CGI;

# Sends Errors to Browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

$member_file = "../members/members.txt";

$hosting_file = "hosting.txt";

if (!$query->param()) {
	&pagestart;
	&form;
	&pageend;
}
else {
	&setvars;
	if (&validform eq 'yes') {
		&pagestart;
		&checkpage;
		&pageend;
	}
	else {
	&pagestart;
	&form;
	&pageend;
	}
}

sub pagestart {
print $query->header;
print<<HEADING;
<head>
  <title>Hosting Sign-Up</title>
<link href="../../hlb.css" rel="stylesheet">

<script language="javascript" src="../../disable.js"></script>

<script language="javascript">
<!--
function noreturn(){
	if (event.keyCode==13)
		event.returnValue = false;	
}
-->
</script>

<basefont size="2">
</head>

<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">
<font face="Times New Roman, Times, Serif">

<p><script language="javascript" src="../../navi.js"></script></p>

<b><font size="4">Hosting Sign-Up</font></b>
<hr>

<table border="0" cellspacing="0" cellpadding="2" width="100\%">
  <tr>
	<td class="hlb"><a href="../../home.html">HOME</a> <b>>></b> <a href="../../hosting/index.html">Hosting</a> <b>>> <i>Hosting Sign-Up</i></b></td>
	</tr>
</table>
HEADING
}

sub pageend {
print<<ENDING;

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
ENDING
}

sub form {
print<<INTRO;
<p align="justify"><b>DO NOT</b> use this form if you are are already hosted with BASIC Guru Online and you are trying to add email addresses.  If that's what you are trying to do, then use the <a href="add.pl">Add New/Change Email Address</a> form.</p>

<p align="justify">You must fill in every field in order to successfully send out the information.  Web Address You'd like must be in all <b>lower case letters</b>.</p>

<form name="hostingform" method="post" action="sign-up.pl" onSubmit="return disableForm(this)\;">
<table border="0" cellspacing="0" cellpadding="0" width="100\%">
	<colgroup>
		<col span="1" width="40\%">
		<col span="1" width="60\%">
	</colgroup>
INTRO

if ($match eq 'no') {
	print "<tr><td colspan=\"2\"><font size=\"2\" color=\"\#FF0000\"><li>Name, User Name, and User ID\# you submitted do not match any member in the member database.  Please enter information again.  If you are not a member, you can apply for membership using the <a href=\"../members/sign-up.pl\">Members Sign-Up</a> form.  If you are a member and the problem persists, <a href=\"../../contactme.html\">contact me</a>.</li></font></td></tr>\n<tr><td colspan=\"2\">\&nbsp;</td></tr>\n";
}

if ($name_error) {
	print "<tr><td></td><td><font size=\"2\" color=\"\#FF0000\">$name_error</font></td></tr>\n";
}
print "<tr valign=\"middle\"><td>Name:</td><td><input type=\"text\" name=\"name\" size=\"40\" value=\"$name\"></td></tr>\n";

if ($username_error) {
	print "<tr><td></td><td><font size=\"2\" color=\"\#FF0000\">$username_error</font></td></tr>\n";
}
print "<tr valign=\"middle\"><td>User Name:</td><td><input type=\"text\" name=\"username\" size=\"40\" maxlength=\"15\" value=\"$username\"></td></tr>\n";

if ($userid_error) {
	print "<tr><td></td><td><font size=\"2\" color=\"\#FF0000\">$userid_error</font></td></tr>\n";
}
print "<tr valign=\"middle\"><td>User ID\#:</td><td><input type=\"text\" name=\"userid\" size=\"10\" maxlength=\"3\" value=\"$userid\"></td></tr>\n";

if ($email_error) {
	print "<tr><td></td><td><font size=\"2\" color=\"\#FF0000\">$email_error</font></td></tr>\n";
}
print "<tr valign=\"middle\"><td>E-mail:</td><td><input type=\"text\" name=\"email\" size=\"40\" value=\"$email\"></td></tr>\n";

if ($webname_error) {
	print "<tr><td></td><td><font size=\"2\" color=\"\#FF0000\">$webname_error</font></td></tr>\n";
}
print "<tr valign=\"middle\"><td>Name of Website:</td><td><input type=\"text\" name=\"webname\" size=\"40\" value=\"$webname\"></td></tr>\n";

if ($webaddy_error) {
	print "<tr><td></td><td><font size=\"2\" color=\"\#FF0000\">$webaddy_error</font></td></tr>\n";
}
print "<tr valign=\"middle\"><td>Current Web Address:</td><td><input type=\"text\" name=\"webaddy\" size=\"40\" value=\"$webaddy\"></td></tr>\n";

print "<tr><td colspan=\"2\">\&nbsp\;</td></tr>";

if ($description_error) {
	print "<tr><td colspan=\"2\" align=\"center\"><font size=\"2\" color=\"\#FF0000\">$description_error</font></td></tr>\n";
}
print "<tr valign=\"middle\" align=\"center\">\n";
print "<td colspan=\"2\">Description of site<br />\n";
print "<textarea name=\"description\" rows=\"5\" cols=\"50\" value=\"$description\" onkeypress=\"noreturn()\"></textarea>\n";
print "</td>\n</tr>";

print "<tr><td colspan=\"2\">\&nbsp\;</td></tr>";

if ($addywanted_error) {
	print "<tr><td></td><td><font size=\"2\" color=\"\#FF0000\">$addywanted_error</font></td></tr>\n";
}
print "<tr valign=\"middle\"><td>Web Address You'd Like:</td><td>http://<input type=\"text\" name=\"addywanted\" size=\"10\" value=\"$addywanted\" />.basicguruonline.com</td></tr>\n";

print<<ENDFORM;
	<tr>
		<td colspan="2">\&nbsp;</td>
	</tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="50\%" align="center">
<colgroup span="2" width="50\%"></colgroup>
  <tr align="center">
    <td><input type="submit" value="Send Form"></td>
    <td><input type="reset" value="Clear Form"></td>
  </tr>
</table>
</form>
ENDFORM
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

sub validform {
	$success = "yes";
	if (!$name) {
		$name_error = "Please enter in your name";
		$success = "no";
	}
	if (!$username) {
		$username_error = "Please enter in your user name";
		$success = "no";
	}
	if (!$userid) {
		$userid_error = "Please enter in your User ID\#";
		$success = "no";
	}
	if ((!$email) || ($email !~ /^[\w-.]+\@[\w-.]+$/)) {
		$email_error = "Invalid or blank email address";
		$success = "no";
	}
	if (!$webname) {
		$webname_error = "Please enter in the name of your website";
		$success = "no";
	}
	if (!$webaddy) {
		$webaddy_error = "Please enter in the current web address of your website";
		$success = "no";
	}
	if (!$description) {
		$description_error = "Please enter in a description of your website";
		$success = "no";
	}
	if (!$addywanted) {
		$addywanted_error = "Please enter in the web address you'd like";
		$success = "no";
	}
	if ($addywanted ne lc($addywanted)) {
		$addywanted_error = "Please enter in the web address you'd like in ALL lowercase";
		$success = "no";
	}

	open(HOSTING,$hosting_file);
	my @hosting = <HOSTING>;
	close(HOSTING);

	foreach $domain (@hosting) {
    chomp($domain);
		if ($addywanted eq $domain) {
			$success = "no";
			$addywanted_error = "Sorry, but that web address is already taken";
		}
	}

	open(MEMBERS,$member_file);
	my @members = <MEMBERS>;
	close(MEMBERS);

	$match = "no";
	foreach $member (@members) {
    chomp($member);
    (@info) = split(/\|/,$member);
		if (($name eq $info[1]) && ($username eq $info[2]) && ($userid eq $info[0])) {
			$match = "yes";
		}
	}
	if ($success eq 'yes') {
		$success = $match;
	}
	return $success;
}

sub checkpage {
print<<CHECKPAGE;

<p></p>

<p align="center"><font size="3">Here is the information that you submitted.  Check over it to make sure that everything is correct.</font></p>

<p></p>

<p align="justify">
<font face="Courier New, Courier">
<b>Name:</b> $name<br>
<b>User Name:</b> $username<br>
<b>User ID\#:</b> $userid<br>
<b>E-mail:</b> $email<br>
<b>Name of Website:</b> $webname<br>
<b>Old Website Address:</b> $webaddy<br>
<b>Description of Website:</b> $description<br>
<b>New Website Address:</b> $addywanted<br>
</font>
</p>

<p align="center">If any of the information you see above is incorrect, <a href="javascript:history.back()">GO BACK</a> and reenter the correct information.  If everything is correct, click on SEND APPLICATION below.</p>

<p align="center">
<form method="post" action="processapp.pl" onSubmit="return disableForm(this)\;">
	<input type="hidden" name="name" value="$name">
	<input type="hidden" name="username" value="$username">
	<input type="hidden" name="userid" value="$userid">
	<input type="hidden" name="email" value="$email">
	<input type="hidden" name="webname" value="$webname">
	<input type="hidden" name="webaddy" value="$webaddy">
	<input type="hidden" name="description" value="$description">
	<input type="hidden" name="addywanted" value="$addywanted">
	<input type="submit" value="SEND APPLICATION">
</form>
</p>

CHECKPAGE
}