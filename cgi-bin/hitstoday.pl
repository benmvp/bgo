#!/usr/bin/perl

use CGI;

$query = new CGI;

$redirect = "/home.html";

$hits_file = "hitstoday.txt";

$sendmail = "/usr/lib/sendmail -t";

if (!$query->param()) {
	print $query->redirect($redirect);
}
else {
	&disphits;
}

sub disphits {
	($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);

	if ($mon == 0) {
		$month = "January";
	}
	elsif ($mon == 1) {
		$month = "February";
	}
	elsif ($mon == 2) {
		$month = "March";
	}
	elsif ($mon == 3) {
		$month = "April";
	}
	elsif ($mon == 4) {
		$month = "May";
	}
	elsif ($mon == 5) {
		$month = "June";
	}
	elsif ($mon == 6) {
		$month = "July";
	}
	elsif ($mon == 7) {
		$month = "August";
	}
	elsif ($mon == 8) {
		$month = "September";
	}
	elsif ($mon == 9) {
		$month = "October";
	}
	elsif ($mon == 10) {
		$month = "November";
	}
	else {
		$month = "December";
	}
	
	$curyear = $year + 1900;
	
	open(HITS,"+>> $hits_file");
	flock HITS, 2;
	seek HITS, 0, 0;
	@hit = <HITS>;
	$hit = $hit[0];
	chomp($hit);
	($hitstoday, $day) = split(/\|/,$hit);
	if ($mday == $day) {
		$hitstoday++;
		$hit = "$hitstoday|$mday";
	}
	else {
		&sendhits;
		$hitstoday = 1;
		$hit = "$hitstoday|$mday";
	}
	$hit .= "\n";
	seek HITS, 0, 0;
	truncate HITS, 0;
	print HITS $hit;
	close(HITS);

  if ($hitstoday == 1) {
		print<<HITSTODAY;
Content-type:application/x-javascript\n\n
document.write("$hitstoday<\/font> hit")
HITSTODAY
	}
	else {
		print<<HITSTODAY;
Content-type:application/x-javascript\n\n
document.write("$hitstoday<\/font> hits")
HITSTODAY
	}
	print<<DATE;
	document.write(" on $month $mday, $curyear")
DATE
}

sub sendhits {
	$date = $mday - 1;
	open(MAIL, "|$sendmail");
	print MAIL <<SV;
From: hits\@basicguruonline.com
To: Benahimvp\@aol.com
Subject: BASIC Guru Online Daily Hits Report

There were $hitstoday hits made today, $month $date, $curyear.  Make sure that the total hits reflect this increase.

SV
	close (MAIL);
}