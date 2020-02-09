#!/usr/bin/perl

use CGI;

# Sends Errors to Browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

# File location of the member info
$prog_file = "programs.txt";

open(PROGS,$prog_file);
@progs=<PROGS>;
close(PROGS);

&pagestart;

foreach $program (@progs){
	chomp($program);
	($filename, $title, $description, $author, $userid, $directory, $category, $filesize, $documentation, $docfile, $screenshots, $votes, $total, $dloads) = split(/\|/,$program);
	&displayinfo($filename, $title, $description, $votes, $total);
}

&pageend;

sub pagestart {
	print $query->header;
	print<<HEADING;
<head>
  <title>TI-83 Assembly Math</title>
<link href="/tablefontsize.css" rel="stylesheet">
<link href="/hlb.css" rel="stylesheet">
<basefont size="2">
</head>

<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">
<font face="Times New Roman, Times, Serif">

<p><script language="javascript" src="/navi.js"></script></p>

<b><font size="4">TI-83 Assembly Math</font></b>
<hr>

<table border="0" cellspacing="0" cellpadding="2" width="100\%">
  <tr>
	<td class="hlb"><a href="/home.html">HOME</a> <b>>></b> <a href="/archives/index.html">Program Archives</a> <b>>></b> <a href="/archives/ti-83/index.html">TI-83</a> <b>>></b> <a href="/archives/ti-83/assembly/index.html">Assembly</a> <b>>> <i>TI-83 Assembly Math</i></b></td>
	</tr>
</table>

<p><table border="0" cellspacing="0" cellpadding="3" width="100\%">
<colgroup>
  <col span="1" width="25\%" />
  <col span="1" width="75\%" />
</colgroup>
HEADING
}

sub displayinfo {
	print<<INFO;
  <tr valign="top">
    <td><a href="progs.pl?prog=$filename">$title</a></td>
		<td><div align="justify">$description<br />
<script src="../../../dispratings.pl?votes=$votes\&total=$total"></script></div></td>
INFO
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