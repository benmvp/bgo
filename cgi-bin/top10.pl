#!/usr/bin/perl

use CGI;

$query = new CGI;

$redirect = "/home.html";

$prog_file = "archives/programs.txt";

if (!$query->param()) {
	print $query->redirect($redirect);
}
else {
	&getinfo;
	&sortdloads;
	&dispdloads;
}

sub getinfo {
	open(PROGS,$prog_file);
	@programs=<PROGS>;
	close(PROGS);

	$index = 0;
	@list = ();
	foreach $program (@programs){
    chomp($program);
    ($file, $title, $dir, $dloads) = split(/\|/,$program);
		@list[$index] = $dloads . "|" . $file . "|" . $title . "|" . $dir;
			$index++;
	}
}

sub sortdloads {
	$length = scalar @list;
	for ($p = 1; $p < ($length-1); $p++) {
		for ($q = 0; $q < ($length-$p); $q++) {
			($dloads, $file, $title, $dir) = split(/\|/,@list[$q]);
			($dloads_a, $file_a, $title_a, $dir_a) = split(/\|/,@list[$q+1]);
			if ($dloads < $dloads_a) {
				$temp = @list[$q];
				@list[$q] = @list[$q+1];
				@list[$q+1] = $temp;
			}
		}
	}
}

sub dispdloads {
	print "Content-type:application/x-javascript\n\n";
	for ($num = 0; $num < 10; $num++) {
		($dloads, $file, $title, $dir) = split(/\|/,@list[$num]);
		print<<TOP10;
			document.write("<li><a href=\\\"/cgi-bin/archives/$dir/progs.pl?prog=$file\\\">$title<\/a> <b> -- <i>$dloads<\/i><\/b><\/li>")
TOP10
	}
}