#!/usr/bin/perl

use CGI;

# Sends Errors to Browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

# File location of the member info
$prog_file = "programs.txt";

&pagestart;

open(PROGS,$prog_file);
@progs=<PROGS>;
close(PROGS);

$i = 0;
foreach $program (@progs){
	chomp($program);
	($filename, $title, $description, $author, $userid, $directory, $category, $filesize, $documentation, $docfile, $screenshots, $votes, $total, $dloads) = split(/\|/,$program);
	&displayinfo($filename, $title, $description, $directory, $votes, $total);
	$i++;
}

&pageend;

sub pagestart {
	print $query->header;
	print<<HEADING;
<head>
  <title>TI-83 Plus BASIC Math</title>
<link href="/tablefontsize.css" rel="stylesheet">
<link href="/hlb.css" rel="stylesheet">
<basefont size="2">
</head>

<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">
<font face="Times New Roman, Times, Serif">

<p><script language="javascript" src="/navi.js"></script></p>

<b><font size="4">TI-83 Plus BASIC Math</font></b>
<hr>

<table border="0" cellspacing="0" cellpadding="2" width="100\%">
  <tr>
	<td class="hlb"><a href="/home.html">HOME</a> <b>>></b> <a href="/archives/index.html">Program Archives</a> <b>>></b> <a href="/archives/ti-83plus/index.html">TI-83 Plus</a> <b>>></b> <a href="/archives/ti-83plus/basic/index.html">BASIC</a> <b>>> <i>TI-83 Plus BASIC Math</i></b></td>
	</tr>
</table>
HEADING

open(PROGS,$prog_file);
@prog=<PROGS>;
close(PROGS);

$index = 0;
@list = ();
foreach $program (@prog){
	chomp($program);
  (@programs) = split(/\|/,$program);
	@list[$index] = $programs[13] . "|" . $programs[0] . "|" . $programs[1] . "|" . $programs[11] . "|" . $programs[12];
		$index++;
}

# Sorts Data
$length = scalar @list;
for ($p = 1; $p < ($length); $p++) {
	for ($q = 0; $q < ($length-$p); $q++) {
		($dloads, $file, $name, $vote, $tot) = split(/\|/,@list[$q]);
		($dloads_a, $file_a, $name_a, $vote_a, $tot_a) = split(/\|/,@list[$q+1]);
		if ($dloads < $dloads_a) {
			$temp = @list[$q];
			@list[$q] = @list[$q+1];
			@list[$q+1] = $temp;
		}
	}
}

($dloads, $file, $name, $vote, $tot) = split(/\|/,@list[0]);

print<<TOPPROG;
<p align="center">
<font size="3"><b>Top Program:</b></font><br /><br />
<a href="progs.pl?prog=$file">$name</a><br />
<b>$dloads downloads</b><br />
<script src="../../../dispratings.pl?votes=$vote\&total=$tot"></script>
</p>
<hr />
TOPPROG

print<<HEADING2
<p align="justify"><img src="/archives/discmanu.gif" width="30" height="30" border="0" align="middle"> -- Downloads program directly (.zip file)</p>

<p><table border="0" cellspacing="0" cellpadding="3" width="100\%">
<colgroup>
  <col span="1" width="25\%" />
  <col span="1" width="75\%" />
</colgroup>
HEADING2
}

sub displayinfo {
	print<<INFO;
  <tr valign="top">
    <td><img name="name$i" src="/archives/discmanu.gif" style="cursor:hand" width="30" height="30" border="0" onMouseOver="javascript:document.images.name$i.src='/archives/discman.gif'" onMouseOut="javascript:document.images.name$i.src='/archives/discmanu.gif'" onClick="window.location='../../../counter.pl?prog=$filename\&directory=$directory'" align="middle" /><a href="progs.pl?prog=$filename">$title</a></td>
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