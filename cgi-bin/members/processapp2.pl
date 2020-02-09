#!/usr/bin/perl

use CGI;

# Sends Errors to Browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

$member_file = "members.txt";

$sendmail = "/usr/lib/sendmail -t";

$redirect = "changeinfo.pl";

if ($query->param()) {
	$id = "changeinfo";
	if ($query->cookie($id)) {
		&alreadyvoted;
	}
	else {
		&changeinfo;
		&sendveri;
		&sendmeinfo;
		&setcookie;
		&thanks;
	}
}
else {
	print $query->redirect($redirect);
}

sub changeinfo {
	open(MEMBERS,"+>>$member_file");
	flock MEMBERS, 2;
	seek MEMBERS, 0, 0;
	my @members = <MEMBERS>;
	my @update = ();

	foreach $member (@members) {
    chomp($member);
    ($userid, $name, $username, $email, $age, $city, $aim, $yahooid, $icq, $webname, $webaddy, $webdes, $calcown, $calcprog, $calclang, $complang, $otherinfo, $date, $progs, $dloads) = split(/\|/,$member);
		if (($name eq $query->param('name')) && ($username eq $query->param('username')) && ($userid eq $query->param('userid'))) {
			&setvars;
		}
		$member .= "\n";
		push @update, $member;
	}
	seek MEMBERS, 0, 0;
	truncate MEMBERS, 0;
	print MEMBERS @update;
	close(MEMBERS);
}

sub setvars {
	$member = $query->param('userid') . "|";
	$member .= $query->param('name') . "|";
	$name = $query->param('name');
	$member .= $query->param('username') . "|";
	$username = $query->param('username');
	$member .= $query->param('email') . "|";
	$email = $query->param('email');
	if ($query->param('age'))	{
		$member .= $query->param('age') . "|";
	}
	else {
		$member .= "null" . "|";
	}
	$age = $query->param('age');

	if ($query->param('city'))	{
		$member .= $query->param('city') . "|";
	}
	else {
		$member .= "null" . "|";
	}
	$city = $query->param('city');

	if ($query->param('aim'))	{
		$member .= $query->param('aim') . "|";
	}
	else {
		$member .= "null" . "|";
	}
	$aim= $query->param('aim');

	if ($query->param('yahooid'))	{
		$member .= $query->param('yahooid') . "|";
	}
	else {
		$member .= "null" . "|";
	}
	$yahooid = $query->param('yahooid');

	if ($query->param('icq'))	{
		$member .= $query->param('icq') . "|";
	}
	else {
		$member .= "null" . "|";
	}
	$icq = $query->param('icq');

	if ($query->param('webname'))	{
		$member .= $query->param('webname') . "|";
	}
	else {
		$member .= "null" . "|";
	}
	$webname = $query->param('webname');

	if ($query->param('webaddy'))	{
		$member .= $query->param('webaddy') . "|";
	}
	else {
		$member .= "null" . "|";
	}
	$webaddy = $query->param('webaddy');

	if ($query->param('webdes')) {
		$member .= $query->param('webdes') . "|";
	}
	else {
		$member .= "null" . "|";
	}
		$webdes = $query->param('webdes');

	$calcsown = $query->param('calcown');
	foreach $calc ($calcsown) {
		(@calcown)=split(/\, /,$calc);
	}
	$numcalcs = scalar @calcown - 1;
	foreach $calcs (@calcown) {
		$member .= $calcs;
		if ($calcs ne $calcown[$numcalcs]) {
			$member .= "*";
		}
	}
	$member .= "|";
	$calcown = $query->param('calcown');
	
	if ($query->param('calcprog')) {
		$calcsprog = $query->param('calcprog');
		foreach $prog ($calcsprog) {
			(@calcprog)=split(/\, /,$prog);
		}
		$numprogs = scalar @calcprog - 1;
		foreach $progs (@calcprog) {
			$member .= $progs;
			if ($progs ne $calcprog[$numprogs]) {
				$member .= "*";
			}
		}
			$member .= "|";
	}
	else {
		$member .= "null" . "|";
	}
	$calcprog = $query->param('calcprog');

	if ($query->param('calclang')) {
		$calcslang = $query->param('calclang');
		foreach $lang ($calcslang) {
			(@calclang)=split(/\, /,$lang);
		}
		$numlangs = scalar @calclang - 1;
		foreach $langs (@calclang) {
			$member .= $langs;
			if ($langs ne $calclang[$numlangs]) {
				$member .= "*";
			}
		}
		$member .= "|";
	}
	else {
		$member .= "null" . "|";
	}
	$calclang = $query->param('calclang');

	if ($query->param('complang'))	{
		$member .= $query->param('complang') . "|";
	}
	else {
		$member .= "null" . "|";
	}
	$complang = $query->param('complang');

	if ($query->param('otherinfo'))	{
		$member .= $query->param('otherinfo') . "|";
	}
	else {
		$member .= "null" . "|";
	}
	$otherinfo = $query->param('otherinfo');

	$updates = $query->param('updates');

	$member .= $date . "|" . $progs . "|" . $dloads;
}

sub sendveri {
	open(MAIL, "|$sendmail");
	print MAIL <<SV;
From: membership\@basicguruonline.com (BASIC Guru Online Membership)
To: $email
Subject: Your BASIC Guru Online member profile has been updated

Hi $name, this email has been sent to you just to let you know that your member profile at BASIC Guru Online has now been updated with the new information that you submitted.  Your Name, User name, and User ID\# have remained the same and are listed below:

Name: $name
User Name: $username
User ID\#: $userid

Go to the List of Members page to find your member profile and check to make sure all of the information is now correct.  If it is not, once again use the Change Member Info form to change it again.

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
Subject: BASIC Guru Online -- Change Member Info \#$userid

Here is all the NEW information about $name

User ID\#: $userid
Name: $name
User Name: $username
E-mail: $email
Age: $age
City: $city
AIM: $aim
Yahoo! Messenger: $yahooid
ICQ: $icq
Name of Website: $webname
Website Address: $webaddy
Description of Website: $webdes
Calculator(s) Owned: $calcown
Calculator(s) Programmed For: $calcprog
Calculator Language(s) Known: $calclang
Computer Language(s) Known: $complang
Other Info About Yourself: $otherinfo
Recieve Email Updates? $updates

Go here to make sure that the profile is okay:
http://bgo.netfirms.com/cgi-bin/members/users.pl?user=$userid

SI
	close (MAIL);
}

sub setcookie {
	$cookie = $query->cookie(-name=>$id,
													 -value=>'changeinfo',
													 -expires=>'+1h',
													 -path=>'/');
	print $query->header(-cookie=>$cookie);
}

sub thanks {
print<<THANKS;

<head>
  <title>Update Sucessfully Processed!</title>
<link href="../../hlb.css" rel="stylesheet">
<basefont size="2">
</head>

<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">

<p><script language="javascript" src="../../navi.js"></script></p>

<font size="5" color="#FF0000"><center>Update Sucessfully Processed!</center></font>
<br>

<table border="0" cellspacing="0" cellpadding="2" width="100%">
  <tr>
	<td class="hlb"><a href="../../home.html">HOME</a> <b>>></b> <a href="../../members/index.html">Members</a> <b>>></b>  <a href="changeinfo.pl">Change Member Info</a>  <b>>> <i>Update Sucessfully Processed!</i></b></td>
	</tr>
</table>

<br>
<font size="3">
<p align="justify">$name, your newly updated member profile has now been processed.  You should be receiving an email shortly as the final confirmation of the process.  Once you have received this email you will know that your new profile is in the member database.  To check out the profile, go to the <a href="list.pl">List of Members page</a> and click on your name.  Your new profile should appear.  If your new profile <b>DOES NOT</b> appear or you <b>DO NOT</b> receive an email within 24 hours, <a href="../../contactme.html">let me know</a>.  Thanks!</p>
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

sub alreadyvoted {
print $query->header;
print<<VOTED;
<head>
	<title>Change Member Info</title>
<link href="../../hlb.css" rel="stylesheet">
</head>

<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">
<font face="Times New Roman, Times, Serif">

<p align="center">$name, you have just recently submitted an update of your BASIC Guru Online member profile.  You will have to wait 1 hour in order for you to be able to submit another profile.</p>

<p align="center"><a href="/members/index.html">Back to Members home page</a></p>

</font>
</body>
</html>
VOTED
}