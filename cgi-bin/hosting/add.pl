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
  <title>Add New/Change Email Address</title>
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

<b><font size="4">Add New/Change Email Address</font></b>
<hr>

<table border="0" cellspacing="0" cellpadding="2" width="100\%">
  <tr>
	<td class="hlb"><a href="../../home.html">HOME</a> <b>>></b> <a href="../../hosting/index.html">Hosting</a> <b>>> <i>Add New/Change Email Address</i></b></td>
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
<p align="justify">The email address that you put when applying for BASIC Guru Online hosting, will be the one that all your new email addresses will be redirected to. If you have more than five emails that you want to add, send the first five in and then come back to this page and send the rest. Remember that your email addresses will be <i>address.hostname</i>\@basicguruonline.com. You do not have to put the "<i>.hostname</i>" in the email fields. Just put the "<i>address</i>" part.</p>

<form name="hostingform" method="post" action="add.pl" onSubmit="return disableForm(this)\;">
<table border="0" cellspacing="0" cellpadding="0" width="100\%">
<colgroup span="2" width="50\%"></colgroup>
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

if ($there eq 'no') {
	print "<tr><td></td><td><font size=\"2\" color=\"\#FF0000\">Invalid Host Name (Host Name not found)</font></td></tr>\n";
}
print "<tr valign=\"middle\"><td>Host Name:</td><td><input type=\"text\" name=\"hostname\" size=\"10\" value=\"$hostname\">.basicguruonline.com</td></tr>\n";

if ($emaila_error) {
	print "<tr><td></td><td><font size=\"2\" color=\"\#FF0000\">$emaila_error</font></td></tr>\n";
}
print "<tr valign=\"middle\"><td>Email Address You'd Like \#1:</td><td><input type=\"text\" name=\"emaila\" size=\"20\" value=\"$emaila\"></td></tr>\n";

print<<MIDFORM;
	<tr>
		<td valign="middle">Email Address You'd Like \#2:</td>
		<td><input type="text" name="emailb" size="20" value="$emailb" /></td>
	</tr>
	<tr>
		<td valign="middle">Email Address You'd Like \#3:</td>
		<td><input type="text" name="emailc" size="20" value="$emailc" /></td>
	</tr>
	<tr>
		<td valign="middle">Email Address You'd Like \#4:</td>
		<td><input type="text" name="emaild" size="20" value="$emaild" /></td>
	</tr>
	<tr>
		<td valign="middle">Email Address You'd Like \#5:</td>
		<td><input type="text" name="emaile" size="20" value="$emaile" /></td>
	</tr>
  <tr>
MIDFORM

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
	$hostname = $query->param('hostname');
	$emaila = $query->param('emaila');
	$emailb = $query->param('emailb');
	$emailc = $query->param('emailc');
	$emaild = $query->param('emaild');
	$emaile = $query->param('emaile');
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
	if (!$emaila) {
		$emaila_error = "Please enter an email address you'd like";
		$success = "no";
	}

	open(HOSTING,$hosting_file);
	my @hosting = <HOSTING>;
	close(HOSTING);

	$there = "no";
	foreach $domain (@hosting) {
    chomp($domain);
		if ($hostname eq $domain) {
			$there = "yes";
		}
	}
	if ($success eq 'yes') {
		$success = $there;
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
<b>Host Name:</b> $hostname<br>
<b>Email Address You'd Like \#1:</b> $emaila<br>
<b>Email Address You'd Like \#2:</b> $emailb<br>
<b>Email Address You'd Like \#3:</b> $emailc<br>
<b>Email Address You'd Like \#4:</b> $emaild<br>
<b>Email Address You'd Like \#5:</b> $emaile
</font>
</p>

<p align="center">If any of the information you see above is incorrect, <a href="javascript:history.back()">GO BACK</a> and reenter the correct information.  If everything is correct, click on SEND APPLICATION below.</p>

<p align="center">
<form method="post" action="processapp2.pl" onSubmit="return disableForm(this)\;">
	<input type="hidden" name="name" value="$name">
	<input type="hidden" name="username" value="$username">
	<input type="hidden" name="userid" value="$userid">
	<input type="hidden" name="email" value="$email">
	<input type="hidden" name="hostname" value="$hostname">
	<input type="hidden" name="emaila" value="$emaila">
	<input type="hidden" name="emailb" value="$emailb">
	<input type="hidden" name="emailc" value="$emailc">
	<input type="hidden" name="emaild" value="$emaild">
	<input type="hidden" name="emaile" value="$emaile">
	<input type="submit" value="SEND APPLICATION">
</form>
</p>

CHECKPAGE
}