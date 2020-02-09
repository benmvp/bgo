#!/usr/bin/perl

use CGI;

# Sends Errors to Browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

$prog_file = "programs.txt";

# Gets Data
open(PROGS,$prog_file);
@programs=<PROGS>;
close(PROGS);

# Reorders data and puts each program into list element
$index = 0;
@ulist = ();
foreach $program (@programs){
	chomp($program);
  ($file, $title, $dir, $dloads) = split(/\|/,$program);
	@ulist[$index] = $title . "|" . $file . "|" . $dloads . "|" . $dir;
		$index++;
}

@list = sort { lc($a) cmp lc($b) } @ulist;
$length = scalar @list;

# Displays Data
print $query->header;
print<<HEADING;
<head>
  <title>List of Programs Sorted Alphabetically</title>
<link href="../../tablefontsize.css" rel="stylesheet">
<link href="../../hlb.css" rel="stylesheet">
<basefont size="2">
</head>

<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">
<font face="Times New Roman, Times, Serif">

<p><script language="javascript" src="../../navi.js"></script></p>

<b><font size="4">List of Programs Sorted Alphabetically</font></b>
<hr>

<table border="0" cellspacing="0" cellpadding="2" width="100\%">
  <tr>
	<td class="hlb"><a href="../../home.html">HOME</a> <b>>></b> <a href="../../archives/index.html">Program Archives</a> <b>>> <i>List of Programs Sorted Alphabetically</i></b></td>
	</tr>
</table>

<p align="center"><a href="dloads.pl">Programs ordered by downloads</a></p>

<p align="justify"><img src="/archives/discmanu.gif" width="30" height="30" border="0" align="middle"> -- Downloads program directly (.zip file)</p>

<table border="3" cellspacing="0" cellpadding="0" width="100\%" rules="none">
<colgroup>
  <col span="1" width="75\%">
  <col span="1" width="25\%">
</colgroup>
  <tr bgcolor="\#00008B" align="center">
    <th><font color="\#FFFFFF">Program</font></th>
    <th><font color="\#FFFFFF">Downloads</font></th>
  </tr>
HEADING

$total = 0;
for ($num = 0; $num < $length; $num++) {
	($title, $file, $dloads, $dir) = split(/\|/,@list[$num]);
	if (($num % 2) == 0) {
		$color = "ADD8E6";
	}
	else {
		$color = "FFFFFF";
	}
	print<<LIST;
	<tr align="center" bgcolor="\#$color">
		<td><img name="name$num" src="/archives/discmanu.gif" style="cursor:hand" width="30" height="30" border="0" onMouseOver="javascript:document.images.name$num.src='/archives/discman.gif'" onMouseOut="javascript:document.images.name$num.src='/archives/discmanu.gif'" onClick="window.location='counter.pl?prog=$file\&directory=$dir'" align="middle" /><a href="$dir/progs.pl?prog=$file">$title</a></td>
		<th>$dloads</th>
	</tr>
LIST
	$total += $dloads;
}

if ($color eq "FFFFFF") {
	$color = "ADD8E6";
}
else {
	$color = "FFFFFF";
}

print<<FINISH;
	<tr align="center" bgcolor="\#$color">
		<th><font color="\#FF0000">TOTAL:</font></th>
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
