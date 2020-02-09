#!/usr/bin/perl

use CGI;

# Sends Errors to Browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

$sendmail = "/usr/lib/sendmail -t";

# File location of the member info
$puds_file = "puds.txt";

&pagestart;

open(INFO,"+>>$puds_file");
flock INFO, 2;
seek INFO, 0, 0;
@puds = <INFO>;
@new_puds = ();

foreach $pud (@puds){
	chomp($pud);
	($title, $author, $userid, $email, $plat, $lang, $type, $status, $description, $date, $ss, $days, $monthday) = split(/\|/,$pud);

	($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
	if ($mday != $monthday) {
		$days++;
		if ($days == 30) {
			&sendwarn;
		}
	}
	if ($days < 55 ) {
		&dispinfo($title, $author, $userid, $email, $plat, $lang, $type, $status, $description, $date, $ss);
		$pud = "$title|$author|$userid|$email|$plat|$lang|$type|$status|$description|$date|$ss|$days|$mday\n";
		push @new_puds, $pud;
	}
}
seek INFO, 0, 0;
truncate INFO, 0;
print INFO @new_puds;
close(INFO);

&pageend;

sub pagestart {
	print $query->header;
	print<<HEADING;
<head>
  <title>Programs Under Development (PUDs)</title>
<link href="/tablefontsize.css" rel="stylesheet">
<link href="/hlb.css" rel="stylesheet">
<link href="/palignjustify.css" rel="stylesheet" />
<link href="/textalignjustify.css" rel="stylesheet" />
<basefont size="2">
</head>

<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">
<font face="Times New Roman, Times, Serif">

<p><script language="javascript" src="/navi.js"></script></p>

<b><font size="4">Programs Under Development (PUDs)</font></b><br />

<font size="3">Programs That the Members are Currently Creating</font>
<hr>

<table border="0" cellspacing="0" cellpadding="2" width="100\%">
  <tr>
	<td class="hlb"><a href="/home.html">HOME</a> <b>>></b> <a href="/archives/index.html">Program Archives</a> <b>>> <i>Programs Under Development (PUDs)</i></b></td>
	</tr>
</table>

<a name="submit"></a>
<dl>
  <dt><a href="submit.pl">Submit Your PUD</a></dt><dd>If you have a program that you are currently creating and would like to post it here, in the PUDs page, you need to submit it.  However, for you to submit a PUD, you must currently be a member of BASIC Guru Online.  You can sign-up for membership in the <a href="/members/index.html">Members Home Page</a>.  If you are currently a member, then you can proceed to submit your PUD information.</dd>
</dl>

<dl>
  <dt><a href="mailto:pudupdate\@basicguruonline.com?subject=Update\&nbsp\;Your\&nbsp\;PUD">Update Your PUD</a></dt><dd>If your PUD is currently on this page and you want to update anything about it (espcially the status or add a screenshot), then send an email to <a href="mailto:pudupdate\@basicguruonline.com?subject=Update\&nbsp\;Your\&nbsp\;PUD">pudupdate\@basicguruonline.com</a>.  <b>Make sure to include your Name, UserName, and User ID\#</b>.  If the new status of your PUD is that it is currently being tested, you can submit the .zip file along with it so that people who view the PUD can also download it to test it.</dd>
</dl>
HEADING
}

sub pageend {
	print<<ENDING;
</table>

<p><script language="javascript" src="/navi.js"></script></p>

<br><br>

<script src="/foot.js"></script>

<hr />
<br />
<center><small>Problems with this page?<br>
Contact the <a href="/contactme.html">Webmaster</a>.
</small>
</center>

</font>
</body>
</html>
ENDING
}

sub dispinfo {
	print<<PUD;
<table bgcolor="\#00008B" border="0" cellspacing="0" cellpadding="2" width="100\%">
  <tr align="center">
    <td><font face="Arial, Helvetica, Sans Serif" color="\#FFFFFF" size="4">$title</font></td>
  </tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="100\%">
<colgroup span="2" width="50\%"></colgroup>
	<tr>
		<td>
			<table border="0" cellspacing="2" cellpading="2" width="100\%">
			<colgroup>
				<col span="1" width="35\%" />
				<col span="1" width="65\%" />
			</colgroup>
				<tr>
					<td><b>Author:</b></td>
					<td><a href="../../members/users.pl?user=$userid">$author</a></td>
				</tr>
				<tr>
					<td><b>Platform:</b></td>
					<td>$plat</td>
				</tr>
				<tr>
					<td><b>Language:</b></td>
					<td>$lang</td>
				</tr>
				<tr>
					<td><b>Type:</b></td>
					<td>$type</td>
				</tr>
				<tr>
					<td><b>Status:</b></td>
PUD

	($stat,$file) = split(/\*/,$status);
	
	if ($file) {
		print "<td><a href=\"/archives/puds/$file\">$stat</a>";
	}
	else {
		print "<td>$status</td>";
	}
	
	print<<PUD2;
				</tr>
				<tr>
					<td><b>Description:</b></td>
					<td>$description</td>
				</tr>
				<tr>
					<td><b>Date Posted:</b></td>
					<td>$date</td>
				</tr>
			</table>
		</td>
		<td align="center">
PUD2

	if ($ss ne 'null') {
		open(FILE,"$ss");
		read(FILE, $dat, 6);
		read(FILE, $dat, 4);
		close(FILE);
		($width, $height) = unpack("SS", $dat);
		if ($width <= 150) {
			$width *= 2;
			$height *= 2;
		}
		if ($width > 300) {
			$width /= 2;
			$height /= 2;
		}
		print<<SHOT;
<img src="/archives/puds/$ss" width="$width" height="$height" border="0" alt="$title">
SHOT
	}
	else {
		print<<SHOT;
<img src="/archives/puds/noshot.gif" width="185" height="123" border="0" alt="No screenshot">
SHOT
	}

	print<<ENDPUD;
</td>
	</tr>
</table></p>
ENDPUD
}

sub sendwarn {
	open(MAIL, "|$sendmail");
	print MAIL <<SV;
From: puds\@basicguruonline.com (BASIC Guru Online PUDs)
To: $email
Subject: $title (PUD) has not been updated in 30 days

You are recieving this email because your PUD, $title, has not been updated in 30 days.  The whole purpose of posting PUDs is to update the progress of the production of the program.  A PUD is a Program Under Development so you should actually be developing it.  Anyway, you must update your PUD within 20 days or it will be removed from the PUDs page.  BASIC Guru Online is doing this in an effort to push you to continue progress on your PUD.  If BGO doesn't push you, who will?  Thank you for your cooperation.  If you have any questions, concerns, or anything else, just reply to this email.

Thanks for being a part of BASIC Guru Online.

-Ben Ilegbodu (BASIC Guru Online webmaster).

SV
	close (MAIL);
}