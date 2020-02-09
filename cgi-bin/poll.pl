#!/usr/bin/perl

use CGI;

# Sends Errors to Browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

# File locations of the poll info
$polls_file = "polls.txt";

open(POLLS,$polls_file);
@polls=<POLLS>;
close(POLLS);

&pagestart;

$index = 0;
foreach $poll (@polls){
  chomp($poll);
  (@poll) = split(/\|/,$poll);
	if ($index < 4) {
		&displaypoll(@poll);
	}
	$index++;
}

&pageend;

sub pagestart {
print $query->header;
print<<HEAD;
<head>
  <title>BASIC Guru Online Poll Results</title>

<link href="../hlb.css" rel="stylesheet" />

<link href="../tablefontsize.css" rel="stylesheet">

<basefont size="2" />
<base target="main" />
</head>

<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">
<font face="Times New Roman, Times, Serif">

<p><script language="javascript" src="../navi.js"></script></p>

<font size="4"><b>BASIC Guru Online Poll Results</b></font>
<hr />

<table border="0" cellspacing="0" cellpadding="2" width="100\%">
  <tr>
	<td class="hlb"><a href="../home.html">HOME</a> <b>>> <i>BASIC Guru Online Poll Results</b></i></td>
	</tr>
</table>

<p></p>
HEAD
}

sub pageend {
print<<ENDING;
<p align="center"><font size="3"><a href="oldpolls.pl">More Previous Weekly Poll Results</a></font></p>

<p><script language="javascript" src="../navi.js"></script></p>

<br><br>

<script src="../foot.js"></script>

<hr />
<br />
<center><small>Problems with this page?<br>
Contact the <a href="../contactme.html">Webmaster</a>.
</small>
</center>

</font>
</body>
</html>
ENDING
}

sub displaypoll {
	if ($index == 3) {
		print<<PREV;
<p align="center"><u><font size="3">Previous Weekly Poll Results:</font></u></p>
PREV
	}
	print<<BEGINPOLL;
<table border="4" cellspacing="0" cellpadding="2" width="100\%" rules="none">
<colgroup>
	<col span="1" width="25\%" />
	<col span="1" width="15\%" />
	<col span="1" width="60\%" />
</colgroup>
  <tr align="center" bgcolor="\#00008B">
    <th colspan="3"><font color="\#FFFFFF" size="3">$poll[0]</font></th>
  </tr>
  <tr bgcolor="\#87CEEB">
    <th><font size="3">Choice</font></th>
    <th><font size="3">Votes</font></th>
    <th><font size="3">Percent</font></th>
  </tr>
BEGINPOLL

	$length = scalar @poll;
	$total = $poll[$length-1];
	for ($option = 1; $option < ($length - 1); $option++) 	{
		($choice, $votes) = split(/\*/,$poll[$option]);
		if (($option % 2) == 0) {
			$color = "87CEEB";
		}
		else {
			$color = "FFFFFF";
		}
		$percent = 100 * ($votes / $total);
		if ($percent != 100) {
			$percent = sprintf("%.2f",$percent);
		}
		print "<tr bgcolor=\"\#$color\" align=\"center\">\n";
		print "<td>$choice</td>\n";
		print "<td><b>$votes</b></td>\n";
		print "<td align=\"left\"><b>";
		for ($bar = 0; $bar <= $percent; $bar+=.3) {
			print "<img src=\"/bar.bmp\" width=\"1\" height=\"4\" border=\"0\" align=\"middle\">";
		}
		print " $percent\%</b></td>\n</tr>";
	}
	if ($color eq "87CEEB") {
		$newcolor = "FFFFFF";
	}
	else {
		$newcolor = "87CEEB";
	}
	print<<POLLEND;
  <tr bgcolor="\#$newcolor">
    <th>Total</td>
    <th>$total</th>
		<th></th>
  </tr>
</table>

<p></p>
POLLEND
}