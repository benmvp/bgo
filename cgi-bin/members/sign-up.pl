#!/usr/bin/perl

use CGI;

# Sends Errors to Browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

$member_file = "members.txt";

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
  <title>Members Sign-Up</title>
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

<b><font size="4">Members Sign-Up</font></b>
<hr>

<table border="0" cellspacing="0" cellpadding="2" width="100\%">
  <tr>
	<td class="hlb"><a href="../../home.html">HOME</a> <b>>></b> <a href="../../members/index.html">Members</a> <b>>> <i>Members Sign-Up</i></b></td>
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
<p align="justify">Having membership with BASIC Guru Online allows you to receive updates to the site through email, an addition of a link to your site in the Links Page, an advanced copy of soon-to-be released programs, along with other things.</p>

<p align="justify"><b>DO NOT</b> use this form if you are currently a member and want to change your member profile information.  Use the <a href="changeinfo.pl">Change Member Info</a> form to do that.</p>

<p align="justify"><font color="\#0000FF">*</font> Indicates that you must fill in an answer.  Leave all fields that aren't applicable or you don't want to answer <u><i><b>blank</b></i></u>, except for the ones with a star by them.  DO NOT put "n/a" or something similar for a field that isn't applicable or that you don't want to fill in.</p>

<form name="memberform" method="post" action="sign-up.pl" onSubmit="return disableForm(this)\;">
<table border="0" cellspacing="0" cellpadding="0" width="100\%">
	<colgroup>
		<col span="1" width="40\%">
		<col span="1" width="60\%">
	</colgroup>
INTRO

if ($name_error) {
	print "<tr><td></td><td><font size=\"2\" color=\"\#FF0000\">$name_error</font></td></tr>\n";
}
print "<tr valign=\"middle\"><td><font color=\"\#0000FF\">*</font>Name:</td><td><input type=\"text\" name=\"name\" size=\"40\" value=\"$name\"></td></tr>\n";

if ($username_error) {
	print "<tr><td></td><td><font size=\"2\" color=\"\#FF0000\">$username_error</font></td></tr>\n";
}
print "<tr valign=\"middle\"><td><font color=\"\#0000FF\">*</font>User Name:</td><td><input type=\"text\" name=\"username\" size=\"40\" maxlength=\"15\" value=\"$username\"></td></tr>\n";

if ($email_error) {
	print "<tr><td></td><td><font size=\"2\" color=\"\#FF0000\">$email_error</font></td></tr>\n";
}
print<<MIDDLEFORM;
	<tr valign="middle">
		<td><font color="\#0000FF">*</font>Email:</td>
		<td><input type="text" name="email" size="40" value="$email"></td>
	</tr>
	<tr valign="middle">
		<td>Age:</td>
		<td><input type="text" name="age" size="10" value="$age" maxlength="2"></td>
	</tr>
	<tr valign="middle">
		<td>City:</td>
		<td><input type="text" name="city" size="40" value="$city"></td>
	</tr>
	<tr valign="middle">
		<td>AIM:</td>
		<td><input type="text" name="aim" size="40" value="$aim"></td>
	</tr>
	<tr valign="middle">
		<td>Yahoo! Messenger:</td>
		<td><input type="text" name="yahooid" size="40" value="$yahooid"></td>
	</tr>
	<tr valign="middle">
		<td>ICQ:</td>
		<td><input type="text" name="icq" size="40" value="$icq"></td>
	</tr>
	<tr valign="middle">
		<td>Name of Website:</td>
		<td><input type="text" name="webname" size="40" value="$webname"></td>
	</tr>
	<tr valign="middle">
		<td>Website Address:</td>
		<td><input type="text" name="webaddy" size="40" value="http://" value="$webaddy"></td>
	</tr>
	<tr valign="middle">
		<td>Description of Website:</td>
		<td><input type="text" name="webdes" size="40" maxlength="150" value="$webdes"></td>
	</tr>
	<tr>
		<td>\&nbsp;</td>
		<td>\&nbsp;</td>
	</tr>
MIDDLEFORM

if ($calcown_error) {
	print "<tr><td></td><td><font size=\"2\" color=\"\#FF0000\">$calcown_error</font></td></tr>\n";
}
print<<ENDFORM;
	<tr valign="middle">
		<td><font color="\#0000FF">*</font>Calculator(s) Owned:</td>
		<td><font size="2">
			<input type="checkbox" name="calcown" value="TI-73">TI-73
			<input type="checkbox" name="calcown" value="TI-80">TI-80
			<input type="checkbox" name="calcown" value="TI-81">TI-81
			<input type="checkbox" name="calcown" value="TI-82">TI-82
			<input type="checkbox" name="calcown" value="TI-83">TI-83
			<input type="checkbox" name="calcown" value="TI-83 Plus">TI-83 Plus<br>
			<input type="checkbox" name="calcown" value="TI-85">TI-85
			<input type="checkbox" name="calcown" value="TI-86">TI-86
			<input type="checkbox" name="calcown" value="TI-89">TI-89
			<input type="checkbox" name="calcown" value="TI-92">TI-92
			<input type="checkbox" name="calcown" value="TI-92 Plus">TI-92 Plus
			<input type="checkbox" name="calcown" value="Other">Other</font>
		</td>
	</tr>
	<tr>
		<td>\&nbsp;</td>
		<td>\&nbsp;</td>
	</tr>
	<tr valign="middle">
		<td>Calculator(s) Programmed For:</td>
		<td><font size="2">
			<input type="checkbox" name="calcprog" value="TI-73">TI-73
			<input type="checkbox" name="calcprog" value="TI-80">TI-80
			<input type="checkbox" name="calcprog" value="TI-81">TI-81
			<input type="checkbox" name="calcprog" value="TI-82">TI-82
			<input type="checkbox" name="calcprog" value="TI-83">TI-83
			<input type="checkbox" name="calcprog" value="TI-83 Plus">TI-83 Plus<br>
			<input type="checkbox" name="calcprog" value="TI-85">TI-85
			<input type="checkbox" name="calcprog" value="TI-86">TI-86
			<input type="checkbox" name="calcprog" value="TI-89">TI-89
			<input type="checkbox" name="calcprog" value="TI-92">TI-92
			<input type="checkbox" name="calcprog" value="TI-92 Plus">TI-92 Plus
			<input type="checkbox" name="calcprog" value="Other">Other</font>
		</td>
	</tr>
	<tr>
		<td>\&nbsp;</td>
		<td>\&nbsp;</td>
	</tr>
	<tr valign="middle">
		<td>Calculator Language(s) Known:</td>
		<td><font size="2">
			<input type="checkbox" name="calclang" value="BASIC">BASIC
			<input type="checkbox" name="calclang" value="ASM">ASM
			<input type="checkbox" name="calclang" value="Other">Other</font>
		</td>
	</tr>
	<tr>
		<td>\&nbsp;</td>
		<td>\&nbsp;</td>
	</tr>
	<tr valign="middle">
		<td>Computer Language(s) Known:</td>
		<td><input type="text" name="complang" size="40" value="$complang"></td>
	</tr>
</table>

<p align="center"><font size="3">Other Info About Yourself:</font><br><textarea name="otherinfo" wrap="physical" cols="45" rows="6" value="$otherinfo" onkeypress="noreturn()"></textarea></p>

<p align="center">Would you like to recieve updates to the site, site news, and other important things via email when they occur?<br>
			<input type="radio" name="updates" value="Yes" checked>Yes
			<input type="radio" name="updates" value="No">No</p>

<p></p>

<table border="0" cellspacing="0" cellpadding="0" width="100\%" align="center">
<colgroup span="2" width="50\%"></colgroup>
  <tr align="center">
    <td><input type="submit" value="Send Form"></td>
    <td><input type="reset" value="Clear"></td>
  </tr>
</table>
</form>
ENDFORM
}

sub setvars {
	$name = $query->param('name');
	$username = $query->param('username');
	$email = $query->param('email');
	$age = $query->param('age');
	$city = $query->param('city');
	$aim = $query->param('aim');
	$yahooid = $query->param('yahooid');
	$icq = $query->param('icq');
	$webname = $query->param('webname');
	$webaddy = $query->param('webaddy');
	if ($webaddy eq "http://") {
		$webaddy = "";
	}
	$webdes = $query->param('webdes');

	@calcown = $query->param('calcown');
	$calcown = "";
	$numcalcs = scalar @calcown - 1;
	foreach $calc (@calcown){
		$calcown .= $calc;
		if ($calc ne $calcown[$numcalcs]) {
			$calcown .= ", ";
		}
	}

	@calcprog = $query->param('calcprog');
	$calcprog = "";
	$numprogs = scalar @calcprog - 1;
	foreach $prog (@calcprog) {
		$calcprog .= $prog;
		if ($prog ne $calcprog[$numprogs]) {
			$calcprog .= ", ";
		}
	}

	@calclang = $query->param('calclang');
	$calclang = "";
	$numlangs = scalar @calclang - 1;
	foreach $lang (@calclang) {
		$calclang .= $lang;
		if ($lang ne $calclang[$numlangs]) {
			$calclang .= ", ";
		}
	}

	$complang = $query->param('complang');
	$otherinfo = $query->param('otherinfo');
	$updates = $query->param('updates');
}

sub validform {
	$success = "yes";
	if (!$name) {
		$name_error = "You need to enter in your name for your profile";
		$success = "no";
	}
	if (!$username) {
		$username_error = "You need to enter in a user name for your profile";
		$success = "no";
	}
	if ((!$email) || ($email !~ /^[\w-.]+\@[\w-.]+$/)) {
		$email_error = "Invalid or blank email address";
		$success = "no";
	}
	if (!@calcown) {
		$calcown_error = "Please choose a calculator that you own";
		$success = "no";
	}

	open(MEMBERS,$member_file);
	my @members = <MEMBERS>;
	close(MEMBERS);

	$there = "no";
	foreach $member (@members) {
    chomp($member);
    (@data) = split(/\|/,$member);
		if ($username eq $data[2]) {
			$there = "yes";
			$username_error = "Sorry, but that User Name is already taken";
			$success = "no";
		}
		if ($name eq $data[1]) {
			$there = "yes";
			$name_error = "Sorry, but that Name is already taken";
			$success = "no";
		}
	}

	return $success;
}

sub checkpage{
print<<CHECKPAGE;

<p></p>

<p align="center"><font size="3">Here is the information that you submitted.  Check over it to make sure that everything is correct.</font></p>

<p></p>

<p align="justify">
<font face="Courier New, Courier">
<b>Name:</b> $name<br>
<b>User Name:</b> $username<br>
<b>E-mail:</b> $email<br>
<b>Age:</b> $age<br>
<b>City:</b> $city<br>
<b>AIM:</b> $aim<br>
<b>Yahoo! Messenger:</b> $yahooid<br>
<b>ICQ:</b> $icq<br>
<b>Name of Website:</b> $webname<br>
<b>Website Address:</b> $webaddy<br>
<b>Description of Website:</b> $webdes<br>
<b>Calculator(s) Owned:</b> $calcown<br>
<b>Calculator(s) Programmed For:</b> $calcprog<br>
<b>Calculator Language(s) Known:</b> $calclang<br>
<b>Computer Language(s) Known:</b> $complang<br>
<b>Other Info About Yourself:</b> $otherinfo<br>
<b>Recieve Email Updates?</b> $updates
</font>
</p>

<p align="center">If any of the information you see above is incorrect, <a href="javascript:history.back()">GO BACK</a> and reenter the correct information.  If everything is correct, click on SEND APPLICATION below.</p>

<p align="center">
<form method="post" action="processapp.pl" onSubmit="return disableForm(this)\;">
	<input type="hidden" name="name" value="$name">
	<input type="hidden" name="username" value="$username">
	<input type="hidden" name="email" value="$email">
	<input type="hidden" name="age" value="$age">
	<input type="hidden" name="city" value="$city">
	<input type="hidden" name="aim" value="$aim">
	<input type="hidden" name="yahooid" value="$yahooid">
	<input type="hidden" name="icq" value="$icq">
	<input type="hidden" name="webname" value="$webname">
	<input type="hidden" name="webaddy" value="$webaddy">
	<input type="hidden" name="webdes" value="$webdes">
	<input type="hidden" name="calcown" value="$calcown">
	<input type="hidden" name="calcprog" value="$calcprog">
	<input type="hidden" name="calclang" value="$calclang">
	<input type="hidden" name="complang" value="$complang">
	<input type="hidden" name="otherinfo" value="$otherinfo">
	<input type="hidden" name="updates" value="$updates">
	<input type="submit" value="SEND APPLICATION">
</form>
</p>

CHECKPAGE
}