#!/usr/bin/perl

use CGI;

$query = new CGI;

$redirect = "/home.html";

$hits_file = "hitsweekly.txt";

$sendmail = "/usr/lib/sendmail -t";

if (!$query->param()) {
	print $query->redirect($redirect);
}
else {
	&disphits;
}

sub disphits {
	($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);

	open(HITS,"+>> $hits_file");
	flock HITS, 2;
	seek HITS, 0, 0;
	$hit = <HITS>;
	chomp($hit);
	($hitsweekly, $weekday, $monthday) = split(/\|/,$hit);
	if ($mday == $monthday) {
		$hitsweekly++;
		$hit = "$hitsweekly|$weekday|$mday";
	}
	else {
  	$weekday++;
  	if ($weekday == 8) {
  		&sendhits;
  		$hitsweekly = 1;
  		$weekday = 1;
  	}
		$hit = "$hitsweekly|$weekday|$mday";
	}
	$hit .= "\n";
	seek HITS, 0, 0;
	truncate HITS, 0;
	print HITS $hit;
	close(HITS);

  if ($hitsweekly == 1) {
		print<<HITSWEEKLY;
Content-type:application/x-javascript\n\n
document.write("$hitsweekly<\/font> hit")
HITSWEEKLY
	}
	else {
		print<<HITSWEEKLY;
Content-type:application/x-javascript\n\n
document.write("$hitsweekly<\/font> hits")
HITSWEEKLY
	}
}

sub sendhits {
	open(MAIL, "|$sendmail");
	print MAIL <<SV;
From: hits\@basicguruonline.com
To: Benahimvp\@aol.com
Subject: BASIC Guru Online Weekly Hits Report

There were $hitsweekly hits this past week at BASIC Guru Online.  The total hit count should reflect this number.

SV
	close (MAIL);
}