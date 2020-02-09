#!/usr/bin/perl

use CGI;

$query = new CGI;

$redirect = "/home.html";

$hits_file = "hits.txt";

if (!$query->param()) {
	print $query->redirect($redirect);
}
else {
	&disphits;
}

sub disphits {
	open(HITS,"+>> $hits_file");
	flock HITS, 2;
	seek HITS, 0, 0;
	@hits = <HITS>;
	$hits = $hits[0];
	chomp($hits);
	$hits++;
	seek HITS, 0, 0;
	truncate HITS, 0;
	print HITS "$hits\n";
	close(HITS);

	print<<HITS;
Content-type:application/x-javascript\n\n
document.write("$hits")
HITS
}