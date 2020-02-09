#!/usr/bin/perl

use CGI;

# Sends Errors to Browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

$links_file = "links.txt";

$sendmail = "/usr/lib/sendmail -t";

$redirect = "index.pl";

if ($query->param()) {
	&setvars;
	if (&validform) {
		if ($query->cookie($id)) {
			&alreadyvoted;
		}
		else {
		&addlink;
		&sendveri;
		&sendmeinfo;
		&setcookie;
		&thanks;
		}
	}
	else {
		$redirect = "index.pl?error=$error\&name=$name\&email=$email\&title=$title\&url=$url\&description=$description\#submit";
		print $query->redirect($redirect);
	}
}
else {
	print $query->redirect($redirect);
}

sub setvars {
	$name = $query->param('name');
	$email = $query->param('email');
	$title = $query->param('title');
	$url = $query->param('url');
	$description = $query->param('description');
	$id = "links";
}

sub validform {
	$success = 1;
	$error = "";
	if (!$name) {
		$error .= "<li>Please enter in your name</li>";
		$success = 0;
	}
	if (!$email) {
		$error .= "<li>Please enter in your email address</li>";
		$success = 0;
	}
	if ($email !~ /^[\w-.]+\@[\w-.]+$/) {
		$error .= "<li>Invalid email address</li>";
		$success = 0;
	}
	if (!$title) {
		$error .= "<li>Please enter in your site's title</li>";
		$success = 0;
	}
	if (!$url) {
		$error .= "<li>Please enter in the URL of your site</li>";
		$success = 0;
	}
	if (!$description) {
		$error .= "<li>Please enter a description of your site</li>";
		$success = 0;
	}
	return $success;
}

sub addlink {
	$newlink = $title . "|" . $url . "|" . $description;
	open (ADDLINK, ">> $links_file");
	flock ADDLINK, 2;
	print ADDLINK $newlink;
	print ADDLINK "\n";
	close ADDLINK;

	open(LINKS,$links_file);
	@links=<LINKS>;
	close(LINKS);

	$index = 0;
	foreach $link (@links){
  	chomp($link);
		@unsortedlinks[$index] = $link;
		$index++;
	}

	@sortedlinks = sort { lc($a) cmp lc($b) } @unsortedlinks;

	open(SORTLINK, "> $links_file");
	flock SORTLINK, 2;
	foreach $link (@sortedlinks) {
		print SORTLINK "$link\n";
	}
	close(SORTLINK);
}

sub sendveri {
	open(MAIL, "|$sendmail");
	print MAIL <<SV;
From: links\@basicguruonline.com (BASIC Guru Online Links)
To: $email
Subject: Your link to $title has been added

Hi $name, your link to $title, submitted at BASIC Guru Online, has been added to the list of links.  If you return to the Links page you should see it among the other links.  If you don't please let me know.

Now that your link has been added, you also must add a link back to BASIC Guru Online.  Here's the information for the BASIC Guru Online link:

Title: BASIC Guru Online
URL: http://www.basicguruonline.com/
Description: An online set of BASIC Tutorials for the TI-83 and TI-83 Plus. It contains extensive tutorials, a searchable index of commands, members pages, a growing program archives, site hosting, site search, interaction, POMs, SOMs, programming challenges, games, links, awards, and much more!

Remember, I'd prefer if you put the entire description, but if it's just too long, you can take off part of it, but MAKE SURE to leave the first sentence in the description.

WARNING!!  Your link will be removed if a link back to BASIC Guru Online has not been added within 24 hours.

Thank you for your link submission.

-Ben Ilegbodu (BASIC Guru Online webmaster)

SV
	close (MAIL);
}

sub sendmeinfo {
	open(MAIL, "|$sendmail");
	print MAIL<<SI;
From: $email ($name)
To: Benahimvp\@aol.com
Subject: A link to $title has been added

Here is all the information about the link to $title:

Name: $name
E-mail: $email
Title: $title
URL: $url
Description: $description

Go here to make sure that the profile is okay:
http://bgo.netfirms.com/cgi-bin/links/index.pl

SI
	close (MAIL);
}

sub setcookie {
	$cookie = $query->cookie(-name=>$id,
													 -value=>'links',
													 -expires=>'+24h',
													 -path=>'/');
	print $query->header(-cookie=>$cookie);
}

sub thanks {
print<<THANKS;

<head>
  <title>Link Submission Sucessfully Processed!</title>
<link href="../../hlb.css" rel="stylesheet">
<basefont size="2">
</head>

<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">

<p><script language="javascript" src="../../navi.js"></script></p>

<font size="5" color="#FF0000"><center>Link Submission Sucessfully Processed!</center></font>
<br>

<table border="0" cellspacing="0" cellpadding="2" width="100%">
  <tr>
	<td class="hlb"><a href="../../home.html">HOME</a> <b>>></b> <a href="index.pl">Links</a> <b>>></b>  <a href="index.pl\#submit">Link Submission</a>  <b>>> <i>Link Submission Sucessfully Processed!</i></b></td>
	</tr>
</table>

<br>
<font size="3">
<p align="justify">$name, your link submission to <font color="#008000">$title</font> has been successfully processed.  You should be receiving and email shortly telling you that your link has been added to the <a href="index.pl">BASIC Guru Online Links</a> page.  Once you receive the email, you'll know that your link has been added and you can go an view it.  If you do not receive and email within <b>24 hours</b>, <a href="../../contactme.html">let me know</a>.  Also, if you find an error in the link that you just submitted, email <a href="mailto:links\@basicguruonline.com?subject=Link Update">links\@basicguruonline.com</a> and give all the new information again (including your name and email address).</p>

<p align="justify">You should also think about joining the <a href="http://odin.prohosting.com/flabber/cgi-bin/banjoin.cgi" target="_blank">TI Programmers Network</a>.  It is kind of like a banner exchange.  Each member puts a banner somewhere on the site and the banner links to other members' sites.  This way everyone's sites are linked to each other.  The net result is more hits for everyone.  If you are interested click on the link above and follow the instructions listed.  If you would like to see what the banner looks like, go to the bottom of the <a href="/home.html">Home Page</a> and see for your self.</p>

<p align="center">Don't forget to add a link back to BASIC Guru Online!</p>

<p align="center"><a href="index.pl">Back to Links page</a></p>
</font>

<p><script language="javascript" src="../../navi.js"></script></p>

<br><br>

<script src="../../foot.js"></script>

<hr>
<br>
<center><small>Problems with this page?<br>
Contact the <a href="../../contactme.html">Webmaster</a>.
</small>
</center>

</font>
</body>
</html>
THANKS
}

sub alreadyvoted {
print $query->header;
print<<VOTED;
<head>
	<title>Link Submission</title>
<link href="../hlb.css" rel="stylesheet">
</head>

<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">
<font face="Times New Roman, Times, Serif">

<p align="center">You have just recently submitted a link to the BASIC Guru Online Links page.  You will have to wait an hour in order for you to submit another link.  If what you want to do is update your current link, email <a href="mailto:links\@basicguruonline.com?subject=Link Update">links\@basicguruonline.com</a> and give all the new information again (including your name and email address).</p>

<p align="center"><a href="index.pl">Back to Links page</a></p>

</font>
</body>
</html>
VOTED
}