#!/usr/bin/perl

use CGI;

# Sends Errors to Browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

$redirect = "../../archives/index.html";

if (!$query->param()) {
	print $query->redirect($redirect);
}
else {
	&setvars;
	if ($query->cookie($id)) {
		&alreadyrated;
	}
	else {
		&addvote;
		&setcookie;
		&displayrated;
	}
}

sub setvars {
	$rating = $query->param('rating');
	$fn = $query->param('filename');
	$dir = $query->param('directory');
	$name = $query->param('title');
	$id = $dir . "/" . $fn . "-rate";
	$nextpage = $dir . "/progs.pl?prog=" . $fn;
	$prog_file = $dir . "/programs.txt";
}

sub addvote {
	open(INFO,"+>>$prog_file");
	flock INFO, 2;
	seek INFO, 0, 0;
	@progs = <INFO>;
	@new_progs = ();
	
	foreach $program (@progs){
		chomp($program);
		($filename, $title, $description, $author, $userid, $directory, $category, $filesize, $documentation, $docfile, $screenshots, $votes, $total, $dloads) = split(/\|/,$program);
		if ($filename eq $fn) {
			$votes++;
			$total = $rating + $total;
			$program = $filename . "|" . $title . "|" . $description . "|" . $author . "|" . $userid . "|" . $directory . "|" . $category . "|" . $filesize . "|" . $documentation . "|" . $docfile . "|" . $screenshots . "|" . $votes . "|" . $total . "|" . $dloads;
		}
		$program .= "\n";
		push @new_progs, $program;
	}
	seek INFO, 0, 0;
	truncate INFO, 0;
	print INFO @new_progs;
	close(INFO);
}

sub setcookie {
	($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
	$exp = 31 - $mday;
	$cookie = $query->cookie(-name=>$id,
													 -value=>'rate',
													 -expires=>'+' . $exp . 'd',
													 -path=>'/');
	print $query->header(-cookie=>$cookie);
}

sub displayrated {
	print<<RATE;
<html>
<head>
	<title>Program Rating for $name</title>
<link href="../../hlb.css" rel="stylesheet">
</head>

<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">
<font face="Times New Roman, Times, Serif">

<p align="center">Your rating for $name has been successfully submitted.  The rating of $name should change based upon the rating you submitted.  Thank you for rating this program.</p>

<p align="center"><a href="$nextpage">Back to $name profile page</a></p>

</font>
</body>
</html>
RATE
}

sub alreadyrated {
print $query->header;
	print<<ALREADY;
<html>
<head>
	<title>Program Rating for $name</title>
<link href="../../hlb.css" rel="stylesheet">
</head>

<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">
<font face="Times New Roman, Times, Serif">

<p align="center">You have already rated $name.</p>

<p align="center"><a href="$nextpage">Back to $name profile page</a></p>

</font>
</body>
</html>
ALREADY
}