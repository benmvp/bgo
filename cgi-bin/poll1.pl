#!/usr/bin/perl

use CGI;

$query = new CGI;

$redirect = "/home.html";

$polls_file = "polls.txt";

if (!$query->param()) {
	print $query->redirect($redirect);
}
else {
	&getinfo;
}

sub getinfo {
	$id = "poll1";

	open(POLLS,$polls_file);
	@polls=<POLLS>;
	close(POLLS);
	$index = 0;

	foreach $poll (@polls){
  	chomp($poll);
  	(@poll) = split(/\|/,$poll);
		if ($index == 0) {
			if ($query->cookie($id)) {
				$value = $query->cookie(-name=>$id);
				if ($value eq $poll[0]) {
					&results(@poll);
				}
				else {
					&disppoll(@poll);
				}
			}
			else {
				&disppoll(@poll);
			}
		}
		$index++;
	}
}

sub disppoll {
	$length = scalar @poll;
	$title = $poll[0];
	print "Content-type:application/x-javascript\n\n";
	print<<TITLE;
	  document.write("<tr><td align=\\\"center\\\" colspan=\\\"2\\\"><b>$title<\/b><\/td><\/tr>")
TITLE
	for ($option = 1; $option < ($length - 1); $option++) {
		($choice, $votes) = split(/\*/,$poll[$option]);
		print<<OPTION;
			document.write("<tr><td><input type=\\\"radio\\\" name=\\\"choice\\\" value=\\\"$choice\\\"><\/td><td>$choice<\/td><\/tr>")
OPTION
	}
	print<<BUTTONS;
			document.write("<tr><td colspan=\\\"2\\\">\\\&nbsp\\\;<\/td></\tr>")
			document.write("<tr align=\\\"center\\\"><td colspan=\\\"2\\\"><input type=\\\"submit\\\" value=\\\"Vote\\\">\\\&nbsp\\\;\\\&nbsp\\\;\\\&nbsp\\\;<input type=\\\"button\\\" name=\\\"Results\\\" value=\\\"Results\\\" onClick=\\\"window.location=\\\'cgi-bin/poll.pl\\\'\\\"><\/td><\/tr>")
document.write("<input type=\\\"hidden\\" name=\\\"pollid\\\" value=\\\"$title\\\">")
BUTTONS
}

sub results {
	$length = scalar @poll;
	$title = $poll[0];
	$total = $poll[$length-1];
	print "Content-type:application/x-javascript\n\n";
	print<<TITLE;
	  document.write("<tr><td align=\\\"center\\\" colspan=\\\"2\\\"><b>$title<\/b><\/td><\/tr><tr><td colspan=\\\"2\\\">\\\&nbsp\\\;<\/td></\tr>")
TITLE
	for ($option = 1; $option < ($length - 1); $option++) {
		($choice, $votes) = split(/\*/,$poll[$option]);
		$percent = 100 * ($votes / $total);
		$percent = sprintf("%.0f",$percent);
		print<<OPTION;
			document.write("<tr><td colspan=\\\"2\\\"><li>$choice <i>($percent\%)<\/i><\/li><\/td><\/tr>")
OPTION
	}
	if ($total == 1) {
		print<<TOTAL;
		document.write("<tr><th colspan=\\\"2\\\" align=\\\"center\\\">Total: $total vote<\/td><\/tr>")
TOTAL
	}
	else {
		print<<TOTAL;
		document.write("<tr><th colspan=\\\"2\\\" align=\\\"center\\\">Total: $total votes<\/td><\/tr>")
TOTAL
	}
	print<<RESULTS;
		document.write("<tr><td colspan=\\\"2\\\">\\\&nbsp\\\;<\/td></\tr>")
		document.write("<tr align=\\\"center\\\"><td colspan=\\\"2\\\"><a href=\\\"cgi-bin/poll.pl\\\">Expanded Results</a><\/td></\tr>")
RESULTS
}