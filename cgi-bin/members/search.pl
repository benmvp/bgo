#!/perl/bin/perl

use CGI;

# Send errors to browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

$msdn_file = "msdn.txt";

$login = "login.pl";

if (!($query->cookie('username')) || !($query->cookie('password'))) {
	print $query->redirect($login);
}
else {
if (!$query->param()) { 
  &pagestart;
  &pageend;
}
else {
	&setvars;
	if ($query->param()) {
	  &pagestart;
  	&search;
	  &pageend;
	}
	else {
		&pagestart;
		&pageend;
	}
}
}

sub setvars {
	$ida = $query->param('id');
	$msptnuma = $query->param('msptnum');
	$contentsa = $query->param('contents');
	$filesizea = $query->param('filesize');
	$discnuma = $query->param('discnum');
	$dloadsa = $query->param('dloads');
	$datemadea = $query->param('datemade');
	$ratinga = $query->param('rating');
	$sortby = $query->param('sortby');
	if (!$sortby) {
		$sortby = "id";
	}
}

sub pagestart {
  print $query->header;
  print<<HEADER;
<html>
<head>
  <title>MSDN Search</title>
  <link rel="stylesheet" type="text/css" href="../scrollbars.css" />
  <link rel="stylesheet" type="text/css" href="../headers.css" />
	<script language="javascript" src="../disable.js"></script>
</head>

<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000" onLoad="window.status='MicroSoft Developer\\\'s Network'">
<font face="Times New Roman, Times, Serif">

<table width="100%">
	<tr valign="bottom">
		<th align="left" rowspan="2"><img src="../newtop.gif" width="104" height="54" border="0" alt="CMC" /><br />
<img src="../bottom.gif" width="104" height="52" border="0" alt="CMC" /></th>
		<th colspan="3" align="center"><img src="../msdn.gif" width="517" height="55" border="0" alt="MSDN" /></th>
		<th align="right" rowspan="2"><img src="../newtop.gif" width="104" height="54" border="0" alt="CMC" /><br />
<img src="../bottom.gif" width="104" height="52" border="0" alt="CMC" /></th>
	</tr>
	<tr>
		<th align="center"><img src="../line.gif" width="730" height="8" border="0" align="middle" /></th>
	</tr>
</table>

<p>
<font size="5">MSDN Search</font><br />
<hr />
</p>

<p align="center"><font size="4"><a href="../home.html">HOME</a> | <a href="list.pl">List of Products</a> | Search</font></p>

<script src="logged.pl"></script>

<p>Search for a particular program</p>

<form action="search.pl" method="post" onSubmit="return disableForm(this)\;">
<table border="3" cellspacing="0" cellpadding="6" width="100\%" bordercolor="\#00008B">
  <tr align="center" bgcolor="\#00008B" valign="middle">
		<th><font color="\#FFFFFF">ID</font></th>
		<th><font color="\#FFFFFF">MS<br>PartNum</font></th>
		<th><font color="\#FFFFFF">Contents</font></th>
		<th><font color="\#FFFFFF">Disc<br>Num</font></th>
		<th><font color="\#FFFFFF">Date<br>Made</font></th>
		<th><font color="\#FFFFFF">File<br>Size</font></th>
		<th><font color="\#FFFFFF">Downloads</font></th>
		<th><font color="\#FFFFFF">Rating</font></th>
	</tr>
	<tr align="center" valign="middle" bgcolor="\#87CEEB">
		<td><input type="text" name="id" value="$ida" maxlength="3" size="3" /></td>
		<td><input type="text" name="msptnum" value="$msptnuma" maxlength="9" size="9" /></td>
		<td><input type="text" name="contents" value="$contentsa" size="30" /></td>
		<td><input type="text" name="discnum" value="$discnuma" maxlength="7" size="7" /></td>
		<td><input type="text" name="datemade" value="$datemadea" maxlength="9" size="9" /></td>
		<td><input type="text" name="filesize" value="$filesizea" maxlength="5" size="5" /> MB</td>
		<td><input type="text" name="dloads" value="$dloadsa" maxlength="6" size="6" /></td>
		<td><input type="text" name="rating" value="$ratinga" size="3" /></td>
	</tr>
</table>
<p align="center"><input type="submit" value="Search" /></p>
</form>
HEADER
}

sub pageend {
print<<ENDING;
<p align="center"><a href="admin/sign-in.pl">Administrator Log-In</a></p>

<br><br>
<script src="../foot.js"></script>

</font>
</body>
</html>
ENDING
}

sub search {
  open(MSDN,$msdn_file);
  flock MSDN, 2;
  @msdn = <MSDN>;
  close(MSDN);

	$l = 0;
	foreach $p (@msdn) {
		($id, $msptnum, $contents, $lang, $discnum, $issuedate, $datemade, $cdkey, $filesize, $dloads, $votes, $total)=split(/\|/,$p);
		@table[$l] = $id . "|" . $msptnum . "|" . $contents . "|" . $discnum . "|" . $datemade . "|" . $filesize . "|" . $dloads . "|" . $votes . "|" . $total;
		$l++;
	}

$match = "no";

$index = 0;
if ($ida) {
	$matcha = "no";
  foreach $program (@table) {
    ($id, $msptnum, $contents, $discnum, $datemade, $filesize, $dloads, $votes, $total)=split(/\|/,$program);
    if ($id == $ida) {
		@table[$index] = $id . "|" . $msptnum . "|" . $contents . "|" . $discnum . "|" . $datemade . "|" . $filesize . "|" . $dloads . "|" . $votes . "|" . $total;
	  $matcha = "yes";
	  $index++;
    }
	}
	@newtable = @table;
	@table = ();
	for ($i = 0; $i < $index; $i++) {
		@table[$i] = @newtable[$i];
	}
}

$match = $matcha;

$index = 0;
if ($msptnuma) {
	$matcha = 0;
  foreach $program (@table) {
    ($id, $msptnum, $contents, $discnum, $datemade, $filesize, $dloads, $votes, $total)=split(/\|/,$program);
    if ($msptnum =~ /$msptnuma/i) {
      @table[$index] = $id . "|" . $msptnum . "|" . $contents . "|" . $discnum . "|" . $datemade . "|" . $filesize . "|" . $dloads . "|" . $votes . "|" . $total;
	  	$matcha = "yes";
	  	$index++;
    }
	}
	@newtable = @table;
	@table = ();
	for ($i = 0; $i < $index; $i++) {
		@table[$i] = @newtable[$i];
	}
}

$match = $matcha;

$index = 0;
if ($contentsa) {
	$matcha = 0;
  foreach $program (@table) {
    ($id, $msptnum, $contents, $discnum, $datemade, $filesize, $dloads, $votes, $total)=split(/\|/,$program);
    if ($contents =~ /$contentsa/i) {
      @table[$index] = $id . "|" . $msptnum . "|" . $contents . "|" . $discnum . "|" . $datemade . "|" . $filesize . "|" . $dloads . "|" . $votes . "|" . $total;
	  	$matcha = "yes";
	  	$index++;
    }
  }
	@newtable = @table;
	@table = ();
	for ($i = 0; $i < $index; $i++) {
		@table[$i] = @newtable[$i];
	}
}

$match = $matcha;

$index = 0;
if ($discnuma) {
	$matcha = 0;
  foreach $program (@table) {
    ($id, $msptnum, $contents, $discnum, $datemade, $filesize, $dloads, $votes, $total)=split(/\|/,$program);
    if ($discnum eq $discnuma) {
      @table[$index] = $id . "|" . $msptnum . "|" . $contents . "|" . $discnum . "|" . $datemade . "|" . $filesize . "|" . $dloads . "|" . $votes . "|" . $total;
		  $matcha = "yes";
		  $index++;
    }
	}
	@newtable = @table;
	@table = ();
	for ($i = 0; $i < $index; $i++) {
		@table[$i] = @newtable[$i];
	}
}

$match = $matcha;

$index = 0;
if ($datemadea) {
	$matcha = 0;
  foreach $program (@table) {
    ($id, $msptnum, $contents, $discnum, $datemade, $filesize, $dloads, $votes, $total)=split(/\|/,$program);
    if ($datemade eq $datemadea) {
      @table[$index] = $id . "|" . $msptnum . "|" . $contents . "|" . $discnum . "|" . $datemade . "|" . $filesize . "|" . $dloads . "|" . $votes . "|" . $total;
	  	$matcha = "yes";
		  $index++;
    }
	}
	@newtable = @table;
	@table = ();
	for ($i = 0; $i < $index; $i++) {
		@table[$i] = @newtable[$i];
	}
}

$match = $matcha;

$index = 0;
if ($filesizea) {
	$matcha = 0;
  foreach $program (@table) {
    ($id, $msptnum, $contents, $discnum, $datemade, $filesize, $dloads, $votes, $total)=split(/\|/,$program);
    if ($filesize >= $filesizea) {
      @table[$index] = $id . "|" . $msptnum . "|" . $contents . "|" . $discnum . "|" . $datemade . "|" . $filesize . "|" . $dloads . "|" . $votes . "|" . $total;
		  $matcha = "yes";
		  $index++;
    }
	}
	@newtable = @table;
	@table = ();
	for ($i = 0; $i < $index; $i++) {
		@table[$i] = @newtable[$i];
	}
}

$match = $matcha;

$index = 0;
if ($dloadsa) {
	$matcha = 0;
  foreach $program (@table) {
    ($id, $msptnum, $contents, $discnum, $datemade, $filesize, $dloads, $votes, $total)=split(/\|/,$program);
    if ($dloads >= $dloadsa) {
      @table[$index] = $id . "|" . $msptnum . "|" . $contents . "|" . $discnum . "|" . $datemade . "|" . $filesize . "|" . $dloads . "|" . $votes . "|" . $total;
		  $matcha = "yes";
		  $index++;
    }
	}
	@newtable = @table;
	@table = ();
	for ($i = 0; $i < $index; $i++) {
		@table[$i] = @newtable[$i];
	}
}

$match = $matcha;

$index = 0;
if ($ratinga) {
	$matcha = 0;
  foreach $program (@table) {
     ($id, $msptnum, $contents, $discnum, $datemade, $filesize, $dloads, $votes, $total)=split(/\|/,$program);
		$rating = $total / $votes;
    if ($rating >= $ratinga) {
      @table[$index] = $id . "|" . $msptnum . "|" . $contents . "|" . $discnum . "|" . $datemade . "|" . $filesize . "|" . $dloads . "|" . $votes . "|" . $total;
		  $matcha = "yes";
		  $index++;
    }
	}
	@newtable = @table;
	@table = ();
	for ($i = 0; $i < $index; $i++) {
		@table[$i] = @newtable[$i];
	}
}

$match = $matcha;

if ($match eq 'yes') {
  print<<TABLEBEGIN;
<p>
<table border="3" cellspacing="0" cellpadding="6" width="100\%" bordercolor="\#00008B">
  <tr align="center" bgcolor="\#00008B" valign="middle">
		<th><font color="\#FFFFFF">ID</font></th>
		<th><font color="\#FFFFFF">MS<br>PartNum</font></th>
		<th><font color="\#FFFFFF">Contents</font></th>
		<th><font color="\#FFFFFF">Disc<br>Num</font></th>
		<th><font color="\#FFFFFF">Date<br>Made</font></th>
		<th><font color="\#FFFFFF">File<br>Size</font></th>
		<th><font color="\#FFFFFF">Downloads</font></th>
		<th><font color="\#FFFFFF">Rating</font></th>
	</tr>
TABLEBEGIN

	$i = 0;
	foreach $prog (@table) {
    ($id, $msptnum, $contents, $discnum, $datemade, $filesize, $dloads, $votes, $total)=split(/\|/,$prog);
		if (($i % 2) == 0) {
			$color = "87CEEB";
			$star = "2";
		}
		else {
			$color = "FFFFFF";
			$star = "";
		}
  	&printinfo;
		$i++;
	}
	print<<TABLEEND;
</table></p>
TABLEEND
}
else {
	print<<NOMATCH;
<p align="center"><i>No search results were found.  Try the <a href="list.pl">Complete Listing</a></i></p>
NOMATCH
}
}

sub printinfo {
print<<TABLE;
  <tr align="center" bgcolor="\#$color">
    <td><font size="2">$id</font></td>
    <td><font size="2">$msptnum</font></td>
    <td><font size="2"><img name="name$i" src="../discmanu.gif" style="cursor:hand" width="30" height="30" border="0" onMouseOver="javascript:document.images.name$i.src='../discman.gif'" onMouseOut="javascript:document.images.name$i.src='../discmanu.gif'" onClick="window.location='counter.pl?prog=$msptnum'" /><a href="info.pl?prog=$msptnum">$contents</a></font></td>
    <td><font size="2">$discnum</font></td>
    <td><font size="2">$datemade</font></td>
    <td><font size="2">$filesize</font></td>
    <td><font size="2">$dloads</font></td>
    <td><font size="2"><script src="dispratings.pl?votes=$votes\&total=$total\&star=$star"></script></font></td>
  </tr>
TABLE
}