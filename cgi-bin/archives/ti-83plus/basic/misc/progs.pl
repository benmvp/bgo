#!/usr/bin/perl

use CGI;

# Sends Errors to Browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

# File location of the program info
$prog_file = "programs.txt";

$proga_file = "../../../programs.txt";

$redirect = "index.pl";

if (!$query->param()) {
	print $query->redirect($redirect);
}
else {
	&getinfo;
}

sub getinfo {
	$prog = $query->param('prog');

	open(PROGS,$prog_file);
	@progs=<PROGS>;
	close(PROGS);

$match = 0;
	foreach $program (@progs){
  	  chomp($program);
    	($filename, $title, $description, $author, $userid, $directory, $category, $filesize, $documentation, $docfile, $screenshots, $votes, $total, $dloads) = split(/\|/,$program);
	    if ($prog eq $filename){
					$match = 1;
    	    &print_page($filename, $title, $description, $author, $userid, $directory, $category, $filesize, $documentation, $docfile, $screenshots, $dloads, $total, $votes);
    	}
	}
}

if ($match == 0) {
	print $query->redirect($redirect);
}

sub print_page {
	print $query->header;
	print<<HEADING;
<head>
  <title>$title</title>
<link href="/hlb.css" rel="stylesheet">

<script language="javascript" src="/disable.js"></script>

<basefont size="2">
</head>

<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">

<p><script language="javascript" src="/navi.js"></script></p>

<table border="0" cellspacing="0" cellpadding="2" width="100\%">
  <tr>
		<td class="hlb"><a href="/home.html">HOME</a> <b>>></b> <a href="/archives/index.html">Program Archives</a> <b>>></b> <a href="/archives/ti-83plus/index.html">TI-83 Plus</a> <b>>></b> <a href="/archives/ti-83plus/basic/index.html">BASIC</a> <b>>></b> <a href="index.pl">Miscellaneous</a> <b>>> <i>$title</i></b></td>
	</tr>
</table>
<br />

<font face="Times New Roman, Times, Serif">

<center><font face="Comic Sans MS, Times New Roman, Times, Serif" font color="\#0000FF" size="4">$title</font>
</center>
<br />

<p align="justify"><b>File Name: </b><a href="../../../counter.pl?prog=$filename\&directory=$directory">$filename.zip</a></p>

<p align="justify"><b>Description: </b>$description</p>

<p align="justify"><b>Author: </b><a href="../../../../members/users.pl?user=$userid">$author</a></p>

<p align="justify"><b>File Type:</b> <a href="index.pl">$category</a></p>

<p align="justify"><b>File Size: </b>$filesize bytes</p>
HEADING

open(PROGS,$proga_file);
@programs=<PROGS>;
close(PROGS);

# Reorders data and puts each program into list element
$index = 0;
@list = ();
foreach $program (@programs){
	chomp($program);
  ($file, $name, $dir, $downloads) = split(/\|/,$program);
	@list[$index] = $downloads . "|" . $file . "|" . $name . "|" . $dir;
		$index++;
}

# Sorts Data
$length = scalar @list;
for ($p = 1; $p < ($length-1); $p++) {
	for ($q = 0; $q < ($length-$p); $q++) {
		($downloads, $file, $name, $dir) = split(/\|/,@list[$q]);
		($downloads_a, $file_a, $name_a, $dir_a) = split(/\|/,@list[$q+1]);
		if ($downloads < $downloads_a) {
			$temp = @list[$q];
			@list[$q] = @list[$q+1];
			@list[$q+1] = $temp;
		}
	}
}

for ($i = 0; $i < $length; $i++) {
	($downloads_b, $file_b, $name_b, $dir_b) = split(/\|/,@list[$i]);
	if (($filename eq $file_b) && ($directory eq $dir_b)) {
		$rank = $i + 1;
	}
}

open(PROGS,$prog_file);
@progs=<PROGS>;
close(PROGS);

$index = 0;
@list = ();
foreach $program (@progs){
	chomp($program);
  (@programs) = split(/\|/,$program);
	@list[$index] = $programs[13] . "|" . $programs[0]. "|" . $programs[5];
		$index++;
}

# Sorts Data
$length = scalar @list;
for ($p = 1; $p < ($length); $p++) {
	for ($q = 0; $q < ($length-$p); $q++) {
		($downloads, $file, $dir) = split(/\|/,@list[$q]);
		($downloads_a, $file_a, $dir_a) = split(/\|/,@list[$q+1]);
		if ($downloads < $downloads_a) {
			$temp = @list[$q];
			@list[$q] = @list[$q+1];
			@list[$q+1] = $temp;
		}
	}
}

for ($i = 0; $i < $length; $i++) {
	($downloads_b, $file_b, $dir_b) = split(/\|/,@list[$i]);
	if (($filename eq $file_b) && ($directory eq $dir_b)) {
		$ranka = $i + 1;
	}
}

if ($length == 1) {
	$ranka = 1;
}

	print "<font size=\"3\"><p align=\"center\">\n";
	print $title . " is ranked <font  color=\"\#FF0000\">\#" . $rank . "</font> out of <a href=\"/cgi-bin/archives/dloads.pl\">all programs</a> and <font  color=\"\#FF0000\">\#" . $ranka . "</font> in " . $category . " with <font  color=\"\#FF0000\">" . $dloads . "</font>";
	if ($dloads == 1) {
		print " download.<br>\n";
	}
	else {
		print " downloads.<br>\n";
	}
	print "</p></font>\n";

	if ($documentation eq "Yes") {
		print<<DOC;
			<p align="justify"><b>Documentation: </b><a href="/archives/$directory/$docfile">Yes</a></p>
DOC
	}
	else {
		print<<NODOC;
			<p align="justify"><b>Documentation: </b>No</p>
NODOC
	}

	if ($screenshots ne "null") {
		foreach $shot ($screenshots){
			(@ss)=split(/\*/,$shot);
		}
		print<<SS;
<table border="0" cellspacing="0" cellpadding="2" width="100\%">
  <tr align="center" bgcolor="\#00008B">
    <td><font face="Arial, Helvetica, Sans Serif" size="3" color="\#FFFFFF">SCREEN SHOTS</font></td>
  </tr>
</table>
<br />

<table border="0" cellspacing="0" cellpadding="0" width="100\%">
  <tr align="center">
SS
		foreach $pic (@ss) {
			print<<ROW;
<td><img src="/archives/$directory/$pic" alt="$title"></td>
ROW
		}
		print "</tr>\n</table>\n";
	}
	
	print<<NOM;
<a name="nomination"></a>
<p><table border="0" cellspacing="0" cellpadding="2" width="100\%">
  <tr align="center" bgcolor="\#00008B">
    <td><font face="Arial, Helvetica, Sans Serif" size="3" color="\#FFFFFF">PROGRAM OF THE MONTH NOMINATION</font></td>
  </tr>
</table></p>

<p align="justify">Do you think that this program is really good?  Think it deserves to win some sort of award?  If so, you can nominate it to be in the next Program of the Month (POM) poll.  All you have to do is click the "NOMINATE ME" button below and it'll have a good chance of being a nominee in the next POM.  <b>Please vote only one time</b>.</p>

<p align="center">
<form method="post" action="../../../nom.pl" onSubmit="return disableForm(this)\;">
  <tr align="center">
    <td colspan="2"><input type="submit" value="NOMINATE ME" /></td>
  </tr>
<input type="hidden" name="title" value="$title" />
<input type="hidden" name="category" value="$category" />
<input type="hidden" name="filename" value="$filename" />
<input type="hidden" name="directory" value="$directory" />
</form>
</p>
NOM

print<<RATING;
<a name="rating"></a>
<p><table border="0" cellspacing="0" cellpadding="2" width="100\%">
  <tr align="center" bgcolor="\#00008B">
    <td><font face="Arial, Helvetica, Sans Serif" size="3" color="#FFFFFF">PROGRAM RATING</font></td>
  </tr>
</table></p>

<p align="center"><b>Current Rating:</b><br />
<script src="../../../dispratings.pl?votes=$votes\&total=$total"></script></p>

<p align="justify">Agree with this rating?  Disagree with it?  In any case, rate this program from 1 star to 5 stars.  If you think this program is really, really good, you can not only give it a rating of 5 stars, but also leave your thoughts about it.  On the other hand, if you think this program is "not-so-hot," you can give it a low rating.  As in the case with most ratings, the rating of this program is based on the average rating that you, the users, give.  This rating is not based on what one person thinks about the program.  With that in mind, you should be able to have a good idea how good this program <i>really</i> is.  Now, if you think this program really deserves a better (or worse) rating, just send yours and it will be counted for.  <b>Multiple submitted ratings will not be counted!!</b></p>

<p>
<table align="center" border="4" cellspacing="0" cellpadding="2" width="185" rules="none">
<colgroup>
	<col span="1" width="5" />
	<col span="1" width="180" />
</colgroup>
<form method="post" action="../../../rate.pl" onSubmit="return disableForm(this)\;">
  <tr bgcolor="\#FF0000">
    <td align="center" colspan="2"><font color="\#FFFFFF">Rate this program:</font></td>
  </tr>
  <tr>
    <td><input type="radio" name="rating" value="2" /></td>
    <td><img src="/archives/starfull.gif" width="24" height="24" border="0" align="middle" /><img src="/archives/starfull.gif" width="24" height="24" border="0" align="middle" /></td>
  </tr>
  <tr>
    <td><input type="radio" name="rating" value="3" /></td>
    <td><img src="/archives/starfull.gif" width="24" height="24" border="0" align="middle" /><img src="/archives/starfull.gif" width="24" height="24" border="0" align="middle" /><img src="/archives/starfull.gif" width="24" height="24" border="0" align="middle" /></td>
  </tr>
  <tr>
    <td><input type="radio" name="rating" value="4" /></td>
    <td><img src="/archives/starfull.gif" width="24" height="24" border="0" align="middle" /><img src="/archives/starfull.gif" width="24" height="24" border="0" align="middle" /><img src="/archives/starfull.gif" width="24" height="24" border="0" align="middle" /><img src="/archives/starfull.gif" width="24" height="24" border="0" align="middle" /></td>
  </tr>
  <tr>
    <td><input type="radio" name="rating" value="5" /></td>
    <td><img src="/archives/starfull.gif" width="24" height="24" border="0" align="middle" /><img src="/archives/starfull.gif" width="24" height="24" border="0" align="middle" /><img src="/archives/starfull.gif" width="24" height="24" border="0" align="middle" /><img src="/archives/starfull.gif" width="24" height="24" border="0" align="middle" /><img src="/archives/starfull.gif" width="24" height="24" border="0" align="middle" /></td>
  </tr>
  <tr align="center">
    <td colspan="2"><input type="submit" value="Vote" /></td>
  </tr>
<input type="hidden" name="title" value="$title" />
<input type="hidden" name="filename" value="$filename" />
<input type="hidden" name="directory" value="$directory" />
</form>
</table>
</p>

RATING

print<<TEXT3;
<p><script language="javascript" src="/navi.js"></script></p>

<br><br>

<script src="/foot.js"></script>

<hr />
<br />
<center><small>Problems with this page?<br />
Contact the <a href="/contactme.html">Webmaster</a>.
</small>
</center>

</font>
</body>
</html>
TEXT3
}