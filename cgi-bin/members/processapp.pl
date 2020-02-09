#!/usr/bin/perl

use CGI;

# Sends Errors to Browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

$member_file = "members.txt";

$sendmail = "/usr/lib/sendmail -t";

$redirect = "sign-up.pl";

if ($query->param()) {
	$id = "signup";
	if ($query->cookie($id)) {
		&alreadyvoted;
	}
	else {
		&addmember;
		&sendveri;
		&sendmeinfo;
		&setcookie;
		&thanks;
	}
}
else {
	print $query->redirect($redirect);
}

sub addmember {
	open(MEMBERS,$member_file);
	my @members = <MEMBERS>;
	close(MEMBERS);

	foreach $member (@members) {
    chomp($member);
    ($userid, $name, $username, $email, $age, $city, $aim, $yahooid, $icq, $webname, $webaddy, $webdes, $calcown, $calcprog, $calclang, $complang, $otherinfo, $date, $progs, $dloads) = split(/\|/,$member);
		$last_userid = $userid;
	}

	$newmember = $last_userid + 1;
	$userid = $newmember;
	$newmember .= "|";
	$newmember .= $query->param('name') . "|";
	$name = $query->param('name');
	$newmember .= $query->param('username') . "|";
	$username = $query->param('username');
	$newmember .= $query->param('email') . "|";
	$email = $query->param('email');
	if ($query->param('age'))	{
		$newmember .= $query->param('age') . "|";
	}
	else {
		$newmember .= "null" . "|";
	}
	$age = $query->param('age');

	if ($query->param('city'))	{
		$newmember .= $query->param('city') . "|";
	}
	else {
		$newmember .= "null" . "|";
	}
	$city = $query->param('city');

	if ($query->param('aim'))	{
		$newmember .= $query->param('aim') . "|";
	}
	else {
		$newmember .= "null" . "|";
	}
	$aim= $query->param('aim');

	if ($query->param('yahooid'))	{
		$newmember .= $query->param('yahooid') . "|";
	}
	else {
		$newmember .= "null" . "|";
	}
	$yahooid = $query->param('yahooid');

	if ($query->param('icq'))	{
		$newmember .= $query->param('icq') . "|";
	}
	else {
		$newmember .= "null" . "|";
	}
	$icq = $query->param('icq');

	if ($query->param('webname'))	{
		$newmember .= $query->param('webname') . "|";
	}
	else {
		$newmember .= "null" . "|";
	}
	$webname = $query->param('webname');

	if ($query->param('webaddy'))	{
		$newmember .= $query->param('webaddy') . "|";
	}
	else {
		$newmember .= "null" . "|";
	}
	$webaddy = $query->param('webaddy');

	if ($query->param('webdes')) {
		$newmember .= $query->param('webdes') . "|";
	}
	else {
		$newmember .= "null" . "|";
	}
		$webdes = $query->param('webdes');

	$calcsown = $query->param('calcown');
	foreach $calc ($calcsown) {
		(@calcown)=split(/\, /,$calc);
	}
	$numcalcs = scalar @calcown - 1;
	foreach $calcs (@calcown) {
		$newmember .= $calcs;
		if ($calcs ne $calcown[$numcalcs]) {
			$newmember .= "*";
		}
	}
	$newmember .= "|";
	$calcown = $query->param('calcown');
	
	if ($query->param('calcprog')) {
		$calcsprog = $query->param('calcprog');
		foreach $prog ($calcsprog) {
			(@calcprog)=split(/\, /,$prog);
		}
		$numprogs = scalar @calcprog - 1;
		foreach $progs (@calcprog) {
			$newmember .= $progs;
			if ($progs ne $calcprog[$numprogs]) {
				$newmember .= "*";
			}
		}
			$newmember .= "|";
	}
	else {
		$newmember .= "null" . "|";
	}
	$calcprog = $query->param('calcprog');

	if ($query->param('calclang')) {
		$calcslang = $query->param('calclang');
		foreach $lang ($calcslang) {
			(@calclang)=split(/\, /,$lang);
		}
		$numlangs = scalar @calclang - 1;
		foreach $langs (@calclang) {
			$newmember .= $langs;
			if ($langs ne $calclang[$numlangs]) {
				$newmember .= "*";
			}
		}
		$newmember .= "|";
	}
	else {
		$newmember .= "null" . "|";
	}
	$calclang = $query->param('calclang');

	if ($query->param('complang'))	{
		$newmember .= $query->param('complang') . "|";
	}
	else {
		$newmember .= "null" . "|";
	}
	$complang = $query->param('complang');

	if ($query->param('otherinfo'))	{
		$newmember .= $query->param('otherinfo') . "|";
	}
	else {
		$newmember .= "null" . "|";
	}
	$otherinfo = $query->param('otherinfo');

	$updates = $query->param('updates');

	($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
	if ($mon == 0) {
		$month = "January";
	}
	elsif ($mon == 1)
	{
		$month = "February";
	}
	elsif ($mon == 2)
	{
		$month = "March";
	}
	elsif ($mon == 3) {
		$month = "April";
	}
	elsif ($mon == 4) {
		$month = "May";
	}
	elsif ($mon == 5) {
		$month = "June";
	}
	elsif ($mon == 6) {
		$month = "July";
	}
	elsif ($mon == 7) {
		$month = "August";
	}
	elsif ($mon == 8) {
		$month = "Septemeber";
	}
	elsif ($mon == 9) {
		$month = "October";
	}
	elsif ($mon == 10) {
		$month = "November";
	}
	else {
		$month = "December";
	}
	$year += 1900;
	$newmember .= $month . "*" . $mday . "*" . $year . "|";

	$newmember .= "0|0";

	open (ADDMEMBERS, ">> $member_file");
	flock ADDMEMBERS, 2;
	print ADDMEMBERS $newmember;
	print ADDMEMBERS "\n";
	close ADDMEMBERS;
}

sub sendveri {
	open(MAIL, "|$sendmail");
	print MAIL <<SV;
From: membership\@basicguruonline.com (BASIC Guru Online Membership)
To: $email
Subject: You are now a member of BASIC Guru Online

Congratulations, $name!  You are now a member of BASIC Guru Online.  This email has been sent to you just to let you know that your application has been accepted and that you are now a member.  Here is some of your member information:

Name: $name
User Name: $username
User ID\#: $userid

Make sure and remember the User ID\# because you're going to need it whenever you want to send programs or even change your member profile.  You can find your User ID\# along with the rest of your member information on your member profile page, which you can access by going to the List of Members page.

Now that you are a member of BASIC Guru Online, you can submit programs to the Program Archive and/or submit programs that you are currently making to the PUDs page. You will be receiving updates \& news about the site pretty much on a daily basis.  Being a member entitles you for the opportunity to win the Member of the Month (MOM) award.

Thanks for becoming a part of BASIC Guru Online.

-Ben Ilegbodu (BASIC Guru Online webmaster)

SV
	close (MAIL);
}

sub sendmeinfo {
	open(MAIL, "|$sendmail");
	print MAIL<<SI;
From: $email ($name)
To: Benahimvp\@aol.com
Subject: BASIC Guru Online -- New Member \#$userid

Here is all the information about the new member: $name

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
													 -value=>'signup',
													 -expires=>'+20M',
													 -path=>'/');
	print $query->header(-cookie=>$cookie);
}

sub thanks {
print<<THANKS;

<head>
  <title>Application Sucessfully Processed!</title>
<link href="../../hlb.css" rel="stylesheet">
<basefont size="2">
</head>

<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">

<p><script language="javascript" src="../../navi.js"></script></p>

<font size="5" color="#FF0000"><center>Application Sucessfully Processed!</center></font>
<br>

<table border="0" cellspacing="0" cellpadding="2" width="100%">
  <tr>
	<td class="hlb"><a href="../../home.html">HOME</a> <b>>></b> <a href="../../members/index.html">Members</a> <b>>></b>  <a href="sign-up.pl">Members Sign-Up</a>  <b>>> <i>Application Sucessfully Processed!</i></b></td>
	</tr>
</table>

<br>
<font size="3">
<p align="justify">$name, your application to be a BASIC Guru Online Member has been processed.  You should be receiving an email at any moment completing the application process.  The email contains some important information, especially your User ID\#.  The User ID\# is very important because it is basically how you are identified, and you won't be able to do any member-related tasks (like submitting a program) without giving it.  Once you have received the email, you know that you are now a member of BASIC Guru Online.  You'll be able to visit your member profile by going to the <a href="list.pl">List of Members page</a> and clicking on your name.  Your name should be the last one on the list.  If you find some things that you would like to change in your profile, go to the <a href="../../members/index.html">Members page</a> and click on the <a href="changeinfo.pl">Change Member Info</a> link.  If you have included your website in the sign-up form, make sure you create a link back to this site somewhere on yours.  Also make sure that you have the correct description of the site: <i>An online set of BASIC programming tutorials for the TI-83 and TI-83 Plus.</i>  If you don't receive an email or see your new member profile listed on the List of Members page within <b>24 hours</b>, <a href="../../contactme.html">let me know</a>.  Thanks!</p>
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
	<title>Membership Application</title>
<link href="../../hlb.css" rel="stylesheet">
</head>

<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">
<font face="Times New Roman, Times, Serif">

<p align="center">You have already applied for membership at BASIC Guru Online and cannot apply again.  If what you are trying to do is update, your profile, go to the <a href="changeinfo.pl">Change Member Info form</a>.</p>

<p align="center"><a href="/members/index.html">Back to Members home page</a></p>

</font>
</body>
</html>
VOTED
}