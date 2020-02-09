#!/usr/bin/perl

use CGI;

$query = new CGI;

$votes = $query->param('votes');
$total = $query->param('total');
$rating = $total / $votes;

print "Content-type:application/x-javascript\n\n";
	if ($rating <= .75) {
print<<HALF;
document.write("<img src=\\\"/archives/starhalf.gif\\\" width=\\\"24\\\" height=\\\"24\\\" border=\\\"0\\\" align=\\\"middle\\\" />")
HALF
	}
	if (($rating > .75) && ($rating <= 1.25)) {
print<<ONE;
document.write("<img src=\\\"/archives/starfull.gif\\\" width=\\\"24\\\" height=\\\"24\\\" border=\\\"0\\\" align=\\\"middle\\\" />")
ONE
	}
	if (($rating > 1.25) && ($rating <= 1.75)) {
print<<ONEHALF;
document.write("<img src=\\\"/archives/starfull.gif\\\" width=\\\"24\\\" height=\\\"24\\\" border=\\\"0\\\" align=\\\"middle\\\" /><img src=\\\"/archives/starhalf.gif\\\" width=\\\"24\\\" height=\\\"24\\\" border=\\\"0\\\" align=\\\"middle\\\" />")
ONEHALF
	}
	if (($rating > 1.75) && ($rating <= 2.25)) {
print<<TWO;
document.write("<img src=\\\"/archives/starfull.gif\\\" width=\\\"24\\\" height=\\\"24\\\" border=\\\"0\\\" align=\\\"middle\\\" /><img src=\\\"/archives/starfull.gif\\\" width=\\\"24\\\" height=\\\"24\\\" border=\\\"0\\\" align=\\\"middle\\\" />")
TWO
	}
	if (($rating > 2.25) && ($rating <= 2.75)) {
print<<TWOHALF;
document.write("<img src=\\\"/archives/starfull.gif\\\" width=\\\"24\\\" height=\\\"24\\\" border=\\\"0\\\" align=\\\"middle\\\" /><img src=\\\"/archives/starfull.gif\\\" width=\\\"24\\\" height=\\\"24\\\" border=\\\"0\\\" align=\\\"middle\\\" /><img src=\\\"/archives/starhalf.gif\\\" width=\\\"24\\\" height=\\\"24\\\" border=\\\"0\\\" align=\\\"middle\\\" />")
TWOHALF
	}
	if (($rating > 2.75) && ($rating <= 3.25)) {
print<<THREE;
document.write("<img src=\\\"/archives/starfull.gif\\\" width=\\\"24\\\" height=\\\"24\\\" border=\\\"0\\\" align=\\\"middle\\\" /><img src=\\\"/archives/starfull.gif\\\" width=\\\"24\\\" height=\\\"24\\\" border=\\\"0\\\" align=\\\"middle\\\" /><img src=\\\"/archives/starfull.gif\\\" width=\\\"24\\\" height=\\\"24\\\" border=\\\"0\\\" align=\\\"middle\\\" />")
THREE
	}
	if (($rating > 3.25) && ($rating <= 3.75)) {
print<<THREEHALF;
document.write("<img src=\\\"/archives/starfull.gif\\\" width=\\\"24\\\" height=\\\"24\\\" border=\\\"0\\\" align=\\\"middle\\\" /><img src=\\\"/archives/starfull.gif\\\" width=\\\"24\\\" height=\\\"24\\\" border=\\\"0\\\" align=\\\"middle\\\" /><img src=\\\"/archives/starfull.gif\\\" width=\\\"24\\\" height=\\\"24\\\" border=\\\"0\\\" align=\\\"middle\\\" /><img src=\\\"/archives/starhalf.gif\\\" width=\\\"24\\\" height=\\\"24\\\" border=\\\"0\\\" align=\\\"middle\\\" />")
THREEHALF
	}
	if (($rating > 3.75) && ($rating <= 4.25)) {
print<<FOUR;
document.write("<img src=\\\"/archives/starfull.gif\\\" width=\\\"24\\\" height=\\\"24\\\" border=\\\"0\\\" align=\\\"middle\\\" /><img src=\\\"/archives/starfull.gif\\\" width=\\\"24\\\" height=\\\"24\\\" border=\\\"0\\\" align=\\\"middle\\\" /><img src=\\\"/archives/starfull.gif\\\" width=\\\"24\\\" height=\\\"24\\\" border=\\\"0\\\" align=\\\"middle\\\" /><img src=\\\"/archives/starfull.gif\\\" width=\\\"24\\\" height=\\\"24\\\" border=\\\"0\\\" align=\\\"middle\\\" />")
FOUR
	}
	if (($rating > 4.25) && ($rating <= 4.75)) {
print<<FOURHALF;
document.write("<img src=\\\"/archives/starfull.gif\\\" width=\\\"24\\\" height=\\\"24\\\" border=\\\"0\\\" align=\\\"middle\\\" /><img src=\\\"/archives/starfull.gif\\\" width=\\\"24\\\" height=\\\"24\\\" border=\\\"0\\\" align=\\\"middle\\\" /><img src=\\\"/archives/starfull.gif\\\" width=\\\"24\\\" height=\\\"24\\\" border=\\\"0\\\" align=\\\"middle\\\" /><img src=\\\"/archives/starfull.gif\\\" width=\\\"24\\\" height=\\\"24\\\" border=\\\"0\\\" align=\\\"middle\\\" /><img src=\\\"/archives/starhalf.gif\\\" width=\\\"24\\\" height=\\\"24\\\" border=\\\"0\\\" align=\\\"middle\\\" />")
FOURHALF
	}
	if ($rating > 4.75) {
print<<FIVE;
document.write("<img src=\\\"/archives/starfull.gif\\\" width=\\\"24\\\" height=\\\"24\\\" border=\\\"0\\\" align=\\\"middle\\\" /><img src=\\\"/archives/starfull.gif\\\" width=\\\"24\\\" height=\\\"24\\\" border=\\\"0\\\" align=\\\"middle\\\" /><img src=\\\"/archives/starfull.gif\\\" width=\\\"24\\\" height=\\\"24\\\" border=\\\"0\\\" align=\\\"middle\\\" /><img src=\\\"/archives/starfull.gif\\\" width=\\\"24\\\" height=\\\"24\\\" border=\\\"0\\\" align=\\\"middle\\\" /><img src=\\\"/archives/starfull.gif\\\" width=\\\"24\\\" height=\\\"24\\\" border=\\\"0\\\" align=\\\"middle\\\" />")
FIVE
	}


