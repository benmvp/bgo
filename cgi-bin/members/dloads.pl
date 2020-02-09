#!/usr/bin/perl

use CGI;

# Sends Errors to Browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

$user_file = "members.txt";

open(USERS,$user_file);
@users=<USERS>;
close(USERS);

$index = 0;
@list = ();
foreach $member (@users){
   chomp($member);
   (@members) = split(/\|/,$member);
	@list[$index] = $members[19] . "|" . $members[0] . "|" . $members[1] . "|" . $members[18];
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

# Displays Data
print $query->header;
print<<HEADING;
<head>
  <title>List of Members Sorted by Downloads</title>
<link href="../../tablefontsize.css" rel="stylesheet">
<link href="../../hlb.css" rel="stylesheet">
<basefont size="2">
</head>

<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">
<font face="Times New Roman, Times, Serif">

<p><script language="javascript" src="../../navi.js"></script></p>

<b><font size="4">List of Members Sorted by Downloads</font></b>
<hr>

<table border="0" cellspacing="0" cellpadding="2" width="100\%">
  <tr>
	<td class="hlb"><a href="../../home.html">HOME</a> <b>>></b> <a href="../../members/index.html">Members</a> <b>>> <i>List of Members Sorted by Downloads</i></b></td>
	</tr>
</table>

<p align="justify">Are you a member and want to see how you stack up to the other members with programs?  Well, below is a list of all the members with programs, ordered by the number of times their programs have been downloaded.</p>

<p align="center"><a href="list.pl">Members ordered by User ID\#</a></p>

<p align="center"><a href="progs.pl">Members ordered by number of programs</a></p>

<p align="center"><a href="../archives/dloads.pl">Programs ordered by number of downloads</a></p>

<table border="3" cellspacing="0" cellpadding="0" width="100\%" rules="none">
<colgroup>
	<col span="1" width="10\%">
  <col span="1" width="70\%">
  <col span="1" width="20\%">
</colgroup>
  <tr bgcolor="\#00008B" align="center">
    <th><font color="\#FFFFFF">Rank</font></th>
    <th><font color="\#FFFFFF">Member</font></th>
    <th><font color="\#FFFFFF">Downloads</font></th>
  </tr>
HEADING

$total = 0;
for ($num = 0; $num < $length; $num++) {
	($dloads, $userid, $name, $progs) = split(/\|/,@list[$num]);
	if ($progs > 0) {
		if (($num % 2) == 0) {
			$color = "ADD8E6";
		}
		else {
			$color = "FFFFFF";
		}
		$rank = $num + 1;
		print<<LIST;
		<tr align="center" bgcolor="\#$color">
			<th>$rank</th>
			<td><a href="users.pl?user=$userid">$name</a></td>
			<th>$dloads</th>
		</tr>
LIST
		$total += $dloads;
	}
}

if ($color eq "FFFFFF") {
	$color = "ADD8E6";
}
else {
	$color = "FFFFFF";
}

print<<FINISH;
	<tr align="center" bgcolor="\#$color">
		<th colspan="2"><font color="\#FF0000">TOTAL:</font></th>
		<th><font color="\#FF0000">$total</font></th>
	</tr>
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
FINISH
