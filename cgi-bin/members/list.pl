#!/usr/bin/perl

use CGI;

# Sends Errors to Browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

# File location of the member info
$list_file = "members.txt";

# Retrieve data
open(LIST,$list_file);
@list=<LIST>;
close(LIST);

&pagestart;

$bgcolor = 1;

# Get member info and display it
foreach $member (@list){
    chomp($member);
    ($userid, $name, $username, $email, $age, $city, $aim, $yahooid, $icq, $webname, $webaddy, $webdes, $calcown, $calcprog, $calclang, $complang, $otherinfo, $date, $progs, $dloads) = split(/\|/,$member);
		if ($bgcolor == 1) {
			$color = "ADD8E6";
		}
		else {
			$color = "FFFFFF";
		}
		&displayinfo($userid, $name, $username, $email, $color);
		$bgcolor = !($bgcolor);
}

&pageend;

sub pagestart {
print $query->header;
print<<HEADING;
<head>
  <title>List of Members</title>
<link href="../../tablefontsize.css" rel="stylesheet">
<link href="../../hlb.css" rel="stylesheet">
<basefont size="2">
</head>

<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">
<font face="Times New Roman, Times, Serif">

<p><script language="javascript" src="../../navi.js"></script></p>

<b><font size="4">List of Members</font></b>
<hr>

<table border="0" cellspacing="0" cellpadding="2" width="100\%">
  <tr>
	<td class="hlb"><a href="../../home.html">HOME</a> <b>>></b> <a href="../../members/index.html">Members</a> <b>>> <i>List of Members</i></b></td>
	</tr>
</table>

<p align="center">
<a href="\#info">Information</a><br>
<a href="\#all">Members</a>
</p>
<hr>

<a name="info"></a>
<p align="justify">Here are a list of all the members of BASIC Guru Online.  Below is a list of all the members in order of their User ID#.  You can either click on the User Name or the actual name of the person in order to look at their member profile.  The profiles contain information about them relating to TI calculators.  AIM screen names are linked, but only work if you have AOL.  If you have AOL, you can click on the member's screen name and an IM window will appear with their screen name in the "To:" field.  Click on their e-mail address to send them an email.</p>

<p align="center"><a href="dloads.pl">Members ordered by number of downloads</a></p>

<p align="center"><a href="progs.pl">Members ordered by number of programs</a></p>

<table border="3" cellspacing="0" cellpadding="0" width="100\%" rules="none">
<colgroup>
  <col span="1" width="16\%">
  <col span="3" width="28\%">
</colgroup>
  <tr bgcolor="\#00008B">
    <th><font color="\#FFFFFF">User ID#</font></th>
    <th><font color="\#FFFFFF">User Name</font></th>
    <th><font color="\#FFFFFF">E-mail Address</font></th>
    <th><font color="\#FFFFFF">Name</font></th>
  </tr>
HEADING
}

sub displayinfo {
print<<INFO;
  <tr align="center" bgcolor="\#$color">
		<th>$userid</th>
    <td><a href="users.pl?user=$userid">$username</a></td>
    <td><a href="mailto:$email">$email</a></td>
    <td><a href="users.pl?user=$userid">$name</a></td>
  </tr>
INFO
}

sub pageend {
print<<ENDING;
</table>

<p><script language="javascript" src="../../navi.js"></script></p>

<br><br>

<script src="../../foot.js"></script>

<hr />
<br />
<center><small>Problems with this page?<br>
Contact the <a href="../../contactme.html">Webmaster</a>.
</small>
</center>

</font>
</body>
</html>
ENDING
}