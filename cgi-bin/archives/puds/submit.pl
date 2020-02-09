#!/usr/bin/perl

use CGI;

# Sends Errors to Browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

$member_file = "../../members/members.txt";

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
  <title>PUD Submission</title>
<link href="/hlb.css" rel="stylesheet">

<script language="javascript" src="/disable.js"></script>

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

<p><script language="javascript" src="/navi.js"></script></p>

<b><font size="4">PUD Submission</font></b>
<hr>

<table border="0" cellspacing="0" cellpadding="2" width="100\%">
  <tr>
	<td class="hlb"><a href="/home.html">HOME</a> <b>>></b> <a href="/archives/index.html">Program Archives</a> <b>>></b> <a href="index.pl">PUDs</a> <b>>> <i>PUD Submission</i></b></td>
	</tr>
</table>
HEADING
}

sub pageend {
print<<ENDING;

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
ENDING
}

sub form {
print<<INTRO;
<p align="justify">Use this form to submit your PUDs.  You must fill in every field in order to successfully send out the information.</p>

<form name="submitform" method="post" action="submit.pl" onSubmit="return disableForm(this)\;">
<table border="0" cellspacing="0" cellpadding="0" width="100\%">
	<colgroup>
		<col span="1" width="40\%">
		<col span="1" width="60\%">
	</colgroup>
INTRO

if ($match eq 'no') {
	print "<tr><td colspan=\"2\"><font size=\"2\" color=\"\#FF0000\"><li>Name, User Name, and User ID\# you submitted do not match any member in the member database.  Please enter information again.  If you are not a member, you can apply for membership using the <a href=\"../../members/sign-up.pl\">Members Sign-Up</a> form.  If you are a member and the problem persists, <a href=\"/contactme.html\">contact me</a>.</li></font></td></tr>\n<tr><td colspan=\"2\">\&nbsp;</td></tr>\n";
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

if ($title_error) {
	print "<tr><td></td><td><font size=\"2\" color=\"\#FF0000\">$title_error</font></td></tr>\n";
}
print "<tr valign=\"middle\"><td>PUD's Title:</td><td><input type=\"text\" name=\"title\" size=\"40\" value=\"$title\"></td></tr>\n";

if ($platform_error) {
	print "<tr><td></td><td><font size=\"2\" color=\"\#FF0000\">$platform_error</font></td></tr>\n";
}
print "<tr valign=\"middle\"><td>PUD's Platform:</td><td><input type=\"checkbox\" name=\"platform\" value=\"TI-83\">TI-83 <input type=\"checkbox\" name=\"platform\" value=\"TI-83 Plus\">TI-83 Plus</td></tr>\n";

if ($language_error) {
	print "<tr><td></td><td><font size=\"2\" color=\"\#FF0000\">$language_error</font></td></tr>\n";
}
print "<tr valign=\"middle\"><td>PUD's Language:</td><td><input type=\"radio\" name=\"language\" value=\"BASIC\">BASIC <input type=\"radio\" name=\"language\" value=\"Assembly\">Assembly</td></tr>\n";

if ($type_error) {
	print "<tr><td></td><td><font size=\"2\" color=\"\#FF0000\">$type_error</font></td></tr>\n";
}
print "<tr valign=\"middle\"><td>Type of Program:</td><td><input type=\"text\" name=\"type\" size=\"20\" value=\"$type\"><font size=\"2\">(Math, <a href=\"/archives/puds/games.html\" target=\"_blank\">Type of Game</a> etc.)</font></td></tr>\n";

if ($description_error) {
	print "<tr><td></td><td><font size=\"2\" color=\"\#FF0000\">$description_error</font></td></tr>\n";
}
print "<tr valign=\"middle\"><td>PUD's Description:</td><td><input type=\"text\" name=\"description\" size=\"40\" value=\"$description\"></td></tr>\n";

if ($status_error) {
	print "<tr><td></td><td><font size=\"2\" color=\"\#FF0000\">$status_error</font></td></tr>\n";
}
print "<tr valign=\"middle\"><td>Status:</td><td><input type=\"text\" name=\"status\" size=\"20\" value=\"$status\"><font size=\"2\">(% or Planning stages, Beta Testing, etc)</font></td></tr>\n";

if ($ss_error) {
	print "<tr><td></td><td><font size=\"2\" color=\"\#FF0000\">$ss_error</font></td></tr>\n";
}
print "<tr valign=\"middle\"><td>Screenshot?</td><td><input type=\"radio\" name=\"ss\" value=\"Yes\">Yes <input type=\"radio\" name=\"ss\" value=\"No\">No</td></tr>\n";

print<<ENDFORM;
	<tr>
		<td colspan="2">\&nbsp;</td>
	</tr>
	<tr align="center">
		<td colspan="2"><i>If you have a file (screenshot or .zip file) to submit, you will be able to do that soon</i></td>
	</tr>
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
	$title = $query->param('title');
	@plat = $query->param('platform');
	$language = $query->param('language');
	$type = $query->param('type');
	$description = $query->param('description');
	$status = $query->param('status');
	$ss = $query->param('ss');
	$length = scalar @plat;
	if ($length == 2) {
		$platform = $plat[0] . " \& " . $plat[1];
	}
	else {
		$platform = $plat[0];
	}
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
	if (!$title) {
		$title_error = "Please enter in the title of your program";
		$success = "no";
	}
	if (!$platform) {
		$platform_error = "Please choose the platform of your program";
		$success = "no";
	}
	if (!$language) {
		$language_error = "Please choose the language your program was made in";
		$success = "no";
	}
	if (!$type) {
		$type_error = "Please enter in what type your program is";
		$success = "no";
	}
	if (!$description) {
		$description_error = "Please enter in a description of your program";
		$success = "no";
	}
	if (!$status) {
		$status_error = "Please enter in the status of your program";
		$success = "no";
	}
	if (!$ss) {
		$ss_error = "Please choose if you are also submitting a screenshot";
		$success = "no";
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
<b>Title:</b> $title<br>
<b>Platform:</b> $platform<br>
<b>Language:</b> $language<br>
<b>Type:</b> $type<br>
<b>Description:</b> $description<br>
<b>Status:</b> $status<br>
<b>Screenshot?</b> $ss<br>
</font>
</p>

<p align="center">If any of the information you see above is incorrect, <a href="javascript:history.back()">GO BACK</a> and reenter the correct information.  If everything is correct, click on SEND SUBMISSION below.</p>

<p align="center">
<form method="post" action="processapp.pl" onSubmit="return disableForm(this)\;">
	<input type="hidden" name="name" value="$name">
	<input type="hidden" name="username" value="$username">
	<input type="hidden" name="userid" value="$userid">
	<input type="hidden" name="email" value="$email">
	<input type="hidden" name="title" value="$title">
	<input type="hidden" name="platform" value="$platform">
	<input type="hidden" name="language" value="$language">
	<input type="hidden" name="type" value="$type">
	<input type="hidden" name="description" value="$description">
	<input type="hidden" name="status" value="$status">
	<input type="hidden" name="ss" value="$ss">
	<input type="submit" value="SEND SUBMISSION">
</form>
</p>

CHECKPAGE
}