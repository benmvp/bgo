#!/usr/bin/perl

use CGI;

# Sends Errors to Browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

$redirect = "../home.html";

if (!$query->param()) {
	print $query->redirect($redirect);
}
else {
	&setvars;
	if ($query->cookie($id)) {
		$value = $query->cookie(-name=>'$id');
		if ($value eq $pollid) {
			&alreadyvoted;
		}
		else {
			&pollfile;
			&setcookie;
			&success;
		}
	}
	else {
	&pollfile;
	&setcookie;
	&success;
	}
}

sub setvars {
	@choice = $query->param('choice');
	$survey = $query->param('poll');
	$polls_file = "polls.txt";
	$id = "poll" . $survey;
	$pollid = $query->param('pollid');
}

sub pollfile {
	open(INFO,"+>> $polls_file");
	flock INFO, 2;
	seek INFO, 0, 0;
	@polls = <INFO>;
	@new_polls = ();
	
	$index = 1;
	foreach $pollc (@polls) {
		chomp($pollc);
		(@poll) = split(/\|/,$pollc);
		$length = scalar @poll;
		if ($index == $survey) {
			$pollc = "$poll[0]|";
			for ($i = 1; $i < ($length - 1); $i++) {
				($op, $votes) = split(/\*/,$poll[$i]);
				foreach $ch (@choice) {
					if ($ch eq $op) {
						$votes++;
						@poll[$i] = "$op*$votes";
						@poll[$length-1]++;
					}
				}
				$pollc .= "$poll[$i]|";
			}
			$total = $poll[$length-1];
			$pollc .= $total;
		}
		$pollc .= "\n";
		push @new_polls, $pollc;
		$index++;
	}
	seek INFO, 0, 0;
	truncate INFO, 0;
	print INFO @new_polls;
	close(INFO);
}

sub setcookie {
	$cookie = $query->cookie(-name=>$id,
													 -value=>$pollid,
													 -expires=>'+2M',
													 -path=>'/');
	print $query->header(-cookie=>$cookie);
}

sub success {
print<<PAGE;
	<head>
<script language="javascript">
<!--
	window.location="/home.html\#$value";
//-->
</script>
	</head>
	<body>
	</body>
PAGE
}

sub alreadyvoted {
print $query->header;
print<<VOTED;
<head>
	<title>Vote for Poll \#$survey</title>
<link href="../hlb.css" rel="stylesheet">
</head>

<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">
<font face="Times New Roman, Times, Serif">

<p align="center">You have already voted in Poll \#$survey.</p>

<p align="center"><a href="/home.html">Back to homepage</a></p>

</font>
</body>
</html>
VOTED
}