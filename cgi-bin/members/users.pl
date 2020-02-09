#!/usr/bin/perl

use CGI;

# Sends Errors to Browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

# File location of the member info
$user_file = "members.txt";

# File location of member program info
$progs_file = "memprogs.txt";


# Gets value from information string
$user = $query->param('user');

# Retrieve data
open(USERS,$user_file);
@users=<USERS>;
close(USERS);

# Look for member and print info
$match = 0;
foreach $member (@users){
    chomp($member);
      ($userid, $name, $username, $email, $age, $city, $aim, $yahooid, $icq, $webname, $webaddy, $webdes, $calcown, $calcprog, $calclang, $complang, $otherinfo, $date, $progs, $dloads) = split(/\|/,$member);
    if ($userid eq $user){
				$match = 1;
        &print_page($userid, $name, $username, $email, $age, $city, $aim, $yahooid, $icq, $webname, $webaddy, $webdes, $calcown, $calcprog, $calclang, $complang, $otherinfo, $date, $progs, $dloads);
    }
}

# Displays if a member match isn't found
if ($match==0){
print $query->header;
print<<NOMATCH;
<html>
<head>
	<title>Member Profile Not Found</title>
	<basefont size="2">
</head>
<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">
<font face="Times New Roman, Times, Serif">

<p><script language="javascript" src="../../navi.js"></script></p>

<center><h1>Member Profile Not Found</h1></center>

<p align="justify">The member profile that you are trying to display was not found.  If you are receiving this message becuase you tried to type in the URL to the member's profile, then <a href="list.pl">click here</a> to go to the List of Members page.  If you got here by clicking on a link on this site, please <a href="mailto:links\@basicguruonline.com?subject=Links Change/Problems">let me know</a> about it so that I can fix it.  Make sure to include where on the page the link was that got you here.</p>

<p><script language="javascript" src="../../navi.js"></script></p>

</font>
</body>
</head>
NOMATCH
}

# Print the member's profile
sub print_page{
print $query->header;
print<<TEXT1;
<html>
<head>
	<title>$name ($username)</title>
	<link href="../../hlb.css" rel="stylesheet">
	<basefont size="2">
</head>

<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">
<font face="Times New Roman, Times, Serif">

<p><script language="javascript" src="../../navi.js"></script></p>

<table border="0" cellspacing="0" cellpadding="2" width="100\%">
  <tr>
	<td class="hlb"><a href="../../home.html">HOME</a> <b>>></b> <a href="../../members/index.html">Members</a> <b>>></b> <a href="list.pl">List of Members</a> <b>>> <i>$name</i></b></td>
	</tr>
</table>

<p><table border="5" cellspacing="0" cellpadding="2" width="100\%" rules="none">
<colgroup>
  <col span="1" width="35\%">
  <col span="1" width="65\%">
</colgroup>
  <tr bgcolor="\#00008B">
    <th colspan="2"><font size="4" color="\#FFFFFF">$name</font></th>
  </tr>
  <tr valign="middle" align="center">
    <td bgcolor="\#FF0000">User Name:</td>
    <td><font size="2">$username</font></td>
  </tr>
  <tr valign="middle" align="center">
    <td bgcolor="\#FF0000">User ID\#:</td>
    <td><font size="2">$userid</font></td>
  </tr>
  <tr valign="middle" align="center">
    <td bgcolor="\#FF0000">E-Mail:</td>
    <td><font size="2"><a href="mailto:$email">$email</a></font></td>
  </tr>
TEXT1

if ($age != null) {
print<<AGE;
  <tr valign="middle" align="center">
    <td bgcolor="\#FF0000">Age:</td>
    <td><font size="2">$age</font></td>
  </tr>
AGE
}

if ($city ne "null") {
print<<CITY;
  <tr valign="middle" align="center">
    <td bgcolor="\#FF0000">City:</td>
    <td><font size="2">$city</font></td>
  </tr>
CITY
}

if ($aim ne "null") {
print<<AIM;
  <tr valign="middle" align="center">
    <td bgcolor="\#FF0000">AIM:</td>
    <td><font size="2"><a href="aol://9293:$aim">$aim</a></font></td>
  </tr>
AIM
}

if ($yahooid ne "null") {
print<<YAHOOID;
  <tr valign="middle" align="center">
    <td bgcolor="\#FF0000">Yahoo! Messenger:</td>
    <td><font size="2"><a href="http://edit.yahoo.com/config/send_webmesg?.target=$yahooid\&.src=pg" target="_blank">$yahooid</font></td>
  </tr>
YAHOOID
}

if ($icq ne "null") {
print<<ICQ;
  <tr valign="middle" align="center">
    <td bgcolor="\#FF0000">ICQ:</td>
    <td><font size="2"><a href="http://wwp.icq.com/scripts/contact.dll?msgto=&icq\" target="_blank">$icq</a></font></td>
  </tr>
ICQ
}

if (($webname ne "null") && ($webaddy ne "null")) {
print<<WEBSITE;
  <tr valign="middle" align="center">
    <td bgcolor="\#FF0000">Website</td>
    <td align="center"><font size="2"><a href="$webaddy" target="_blank">$webname</a>
WEBSITE
	if ($webdes ne "null") {
		print " -- " . $webdes;
	}
	print "</font></td>\n</tr>\n";
}

if (calcown ne "null") {
print<<CALCOWN;
  <tr valign="middle" align="center">
    <td bgcolor="\#FF0000">Calculator(s) Owned:</td>
    <td><font size="2">
CALCOWN
	foreach $calcs ($calcown){
		(@calculators)=split(/\*/,$calcs);
	}
	$numcalcs = scalar @calculators - 1;
	foreach $calc (@calculators){
		print $calc;
		if ($calc ne $calculators[$numcalcs]) {
			if ($calc eq $calculators[$numcalcs-1]) {
				print " & ";
			}
			else {
			print ", ";
			}
		}
	}
	print "</font></td>\n</tr>\n";
}

if ($calcprog ne "null") {
print<<CALCPROG;
  <tr valign="middle" align="center">
    <td bgcolor="\#FF0000">Calculator(s) Programmed For:</td>
    <td><font size="2">
CALCPROG
foreach $calcsprog ($calcprog){
		(@calculatorsprog)=split(/\*/,$calcsprog);
	}
	$numcalcsprog = scalar @calculatorsprog - 1;
	foreach $calcsprog (@calculatorsprog){
		print $calcsprog;
		if ($calcsprog ne $calculatorsprog[$numcalcsprog]) {
			if ($calcsprog eq $calculatorsprog[$numcalcsprog-1]) {
				print " & ";
			}
			else {
			print ", ";
			}
		}
	}
	print "</font></td>\n</tr>\n";
}

if ($calclang ne "null") {
print<<CALCLANG;
  <tr valign="middle" align="center">
    <td bgcolor="\#FF0000">Calculator Language(s) Known:</td>
    <td><font size="2">
CALCLANG
foreach $calclangs ($calclang){
		(@calculatorlangs)=split(/\*/,$calclangs);
	}
	$numcalclangs = scalar @calculatorlangs - 1;
	foreach $calclangs (@calculatorlangs){
		print $calclangs;
		if ($calclangs ne $calculatorlangs[$numcalclangs]) {
			if ($calclangs eq $calculatorlangs[$numcalclangs-1]) {
				print " & ";
			}
			else {
			print ", ";
			}
		}
	}
	print "</font></td>\n</tr>\n";
}

if ($complang ne "null") {
print<<COMPLANG;
  <tr valign="middle" align="center">
    <td bgcolor="\#FF0000">Computer Language(s) Known:</td>
    <td><font size="2">$complang</font></td>
  </tr>
COMPLANG
}

if ($otherinfo ne "null") {
print<<OTHERINFO;
  <tr valign="middle" align="center">
    <td bgcolor="\#FF0000">Other Info:</td>
    <td><font size="2">$otherinfo</font></td>
  </tr>
OTHERINFO
}

if ($date ne "null") {
foreach $membersince ($date){
		($month, $day, $year)=split(/\*/,$membersince);
	}
print<<DATE;
  <tr valign="middle" align="center">
    <td bgcolor="#FF0000">Member Since:</td>
    <td><font size="2">$month $day, $year</font></td>
  </tr>
DATE
}

print "</table>\n";

if ($progs > 0){
	open(USERS,$user_file);
	@users=<USERS>;
	close(USERS);

	$index = 0;
	@list = ();
	foreach $member (@users){
    chomp($member);
    (@members) = split(/\|/,$member);
		@list[$index] = $members[19] . "|" . $members[0];
		$index++;
	}

	$length = scalar @list;
	for ($p = 1; $p < ($length-1); $p++) {
		for ($q = 0; $q < ($length-$p); $q++) {
			($dloads_a, $userid_a) = split(/\|/,@list[$q]);
			($dloads_b, $userid_b) = split(/\|/,@list[$q+1]);
			if ($dloads_a < $dloads_b) {
				$temp = @list[$q];
				@list[$q] = @list[$q+1];
				@list[$q+1] = $temp;
			}
		}
	}

	for ($i = 0; $i < $length; $i++) {
		($dloads_c, $userid_c) = split(/\|/,@list[$i]);
		if ($userid == $userid_c) {
			$rank = $i + 1;
		}
	}

	open(USERS,$user_file);
	@users=<USERS>;
	close(USERS);

	$index = 0;
	@list = ();
	foreach $member (@users){
    chomp($member);
    (@members) = split(/\|/,$member);
		@list[$index] = $members[18] . "|" . $members[0];
		$index++;
	}

	$length = scalar @list;
	for ($p = 1; $p < ($length-1); $p++) {
		for ($q = 0; $q < ($length-$p); $q++) {
			($progs_a, $userid_a) = split(/\|/,@list[$q]);
			($progs_b, $userid_b) = split(/\|/,@list[$q+1]);
			if ($progs_a < $progs_b) {
				$temp = @list[$q];
				@list[$q] = @list[$q+1];
				@list[$q+1] = $temp;
			}
		}
	}

	for ($i = 0; $i < $length; $i++) {
		($progs_c, $userid_c) = split(/\|/,@list[$i]);
		if ($userid == $userid_c) {
			$ranka = $i + 1;
		}
	}

	print "<font size=\"3\"><p align=\"center\">" . $name . " is <a href=\"progs.pl\">ranked</a> <font color=\"\#FF0000\">\#" . $ranka . "</font> with <font color=\"\#FF0000\">" . $progs  . "</font >";
	if ($progs == 1) {
		print " program";
	}
	else {
		print " programs";
	}
	print " and <a href=\"dloads.pl\">ranked</a> <font color=\"\#FF0000\">\#" . $rank . "</font> with <font color=\"\#FF0000\">" . $dloads . "</font>";
	if ($dloads == 1) {
		print " program download\n";
	}
	else {
		print " program downloads\n";
	}
	print "</p></font>\n";

print<<TABLEBEGIN;
<p><table border="5" cellspacing="0" cellpadding="2" width="100\%" rules="none">
<colgroup span="2" width="50\%"></colgroup>
  <tr bgcolor="\#00008B">
    <th colspan="3"><font size="4" color="\#FFFFFF">MY PROGRAMS</font></th>
  </tr>
  <tr bgcolor="\#ADD8E6">
    <th>Title</th>
    <th>File Type</th>
  </tr>
TABLEBEGIN

	open(PROGS,$progs_file);
	@programs=<PROGS>;
	close(PROGS);

	foreach $memprog (@programs){
    chomp($memprog);
      (@progs) = split(/\|/,$memprog);
    if ($progs[0] eq $user){
        &display_progs(@progs);
    }
	}
	print "</table></p>\n";
}

print<<TEXT3;
<p align="center"><a href="list.pl">Back to List of Members</a></p>

<p><script language="javascript" src="../../navi.js"></script></p>

<br><br>

<script src="../../foot.js"></script>

<hr />
<br />
<center><small>Problems with this page?<br />
Contact the <a href="../../contactme.html">Webmaster</a>.
</small>
</center>

</font>
</body>
</html>
TEXT3
}

sub display_progs {
	$bgcolor = 0;
	$i = 0;
	foreach $proginfo (@progs) {
		(@calcinfo)=split(/\*/,$proginfo);
		if ($calcinfo[0] ne $user) {
			if ($bgcolor == 1) {
				$color = "ADD8E6";
			}
			else {
				$color = "FFFFFF";
			}
print<<ROW;
  <tr align="center" valign="middle" bgcolor="\#$color">
    <td><img name="name$i" src="/archives/discmanu.gif" style="cursor:hand" width="30" height="30" border="0" onMouseOver="javascript:document.images.name$i.src='/archives/discman.gif'" onMouseOut="javascript:document.images.name$i.src='/archives/discmanu.gif'" onClick="window.location='../archives/counter.pl?prog=$calcinfo[1]\&directory=$calcinfo[2]'" align="middle" /><a href="../archives/$calcinfo[2]/progs.pl?prog=$calcinfo[1]">$calcinfo[0]</a></td>
    <td><a href="../archives/$calcinfo[2]/index.pl">$calcinfo[3]</a></td>
  </tr>
ROW
			$bgcolor = !($bgcolor);
			$i++;
		}
	}
}
