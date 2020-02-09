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
	@list[$index] = $members[18] . "|" . $members[0] . "|" . $members[1];
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

# Displays Data
print $query->header;
print<<HEADING;
<head>
  <title>List of Members Sorted by Programs</title>
<link href="../../tablefontsize.css" rel="stylesheet">
<link href="../../hlb.css" rel="stylesheet">
<basefont size="2">
</head>

<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">
<font face="Times New Roman, Times, Serif">

<p><script language="javascript" src="../../navi.js"></script></p>

<b><font size="4">List of Members Sorted by Programs</font></b>
<hr>

<table border="0" cellspacing="0" cellpadding="2" width="100\%">
  <tr>
	<td class="hlb"><a href="../../home.html">HOME</a> <b>>></b> <a href="../../members/index.html">Members</a> <b>>> <i>List of Members Sorted by Programs</i></b></td>
	</tr>
</table>

<p align="justify">Are you a member and want another way to see how you compare with the rest of the members at BASIC Guru Online?  Well check out the list of members sorted by the number of programs they have.</p>

<p align="center"><a href="list.pl">Members ordered by User ID\#</a></p>

<p align="center"><a href="dloads.pl">Members ordered by Downloads</a></p>

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
    <th><font color="\#FFFFFF">Programs</font></th>
  </tr>
HEADING

$total = 0;
for ($num = 0; $num < $length; $num++) {
	($progs, $userid, $name) = split(/\|/,@list[$num]);
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
			<th>$progs</th>
		</tr>
LIST
		$total += $progs;
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
