#!/usr/bin/perl

use CGI;

# Sends Errors to Browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

$sendmail = "/usr/lib/sendmail -t";

$redirect = "submit.pl";

if ($query->param()) {
	&setvars;
	&sendveri;
	&sendmeinfo;
	&thanks;
}
else {
	print $query->redirect($redirect);
}

sub setvars {
	$name = $query->param('name');
	$username = $query->param('username');
	$userid = $query->param('userid');
	$email = $query->param('email');
	$title = $query->param('title');
	$platform = $query->param('platform');
	$language = $query->param('language');
	$type = $query->param('type');
	$description = $query->param('description');
	$status = $query->param('status');
	$ss = $query->param('ss');
}

sub sendveri {
	open(MAIL, "|$sendmail");
	print MAIL <<SV;
From: puds\@basicguruonline.com (BASIC Guru Online PUDs)
To: $email
Subject: Submitted PUD -- $title

Hi, $name, you are receiving this email message to notify you that the information for your PUD, $title, has been received.  You actually have not completed the PUD submission process, however.  First, make a last check on the information that you just submitted:

Title: $title
Platform: $platform
Language: $language
Type: $type
Description: $description
Status: $status

If this information is all correct and you don't want to submit a screenshot or a .zip file (for Beta Testing only), you are finished with the PUD submission process.  However, if you want to submit a screenshot or a .zip file for Beta Testing, then you need to go on to the next step.  Reply to this email message leaving the subject line EXACTLY how it is and send it with the ONE screenshot or the .zip file.  The screenshot MUST be either a .gif, .jpg, or .jpeg file.  If you fail to follow this last step, your PUD profile will not have the screenshot or the .zip file for Beta Testing.

If any of the information happens to be wrong, reply to this email sending the correct information and your Name, User Name, and User ID\#.  Also include a screenshot or .zip file if necessary.

Please take note of the deadlines that you must meet with your PUD:
- If your PUD is not updated within 30 days, you will receive an email telling you that you have 20 days to update it or it will be deleted
- If you do not update your PUD within that 20-day time frame, it will be removed from the PUDs page

BASIC Guru Online is doing this in an effort to keep the members working on the PUD and getting them posted in the Program Archives.  Sometimes that extra push is needed in order to complete the task.  Thank you for your cooperation.

Thanks for being a part of BASIC Guru Online!

-Ben Ilegbodu (BASIC Guru Online webmaster)

SV
	close (MAIL);
}

sub sendmeinfo {
	open(MAIL, "|$sendmail");
	print MAIL<<SI;
From: $email ($name)
To: Benahimvp\@aol.com
Subject: PUD Submission for $title

Here is all the information from $name for his/her submitted PUD $title

User ID\#: $userid
Name: $name
User Name: $username
E-mail: $email
Title: $title
Platform: $platform
Language: $language
Type: $type
Description: $description
Status: $status
Screenshot? $ss

If they are including a screenshot or the status is Beta Testing, you should have received another email with the screenshot or the .zip file.

SI
	close (MAIL);
}

sub thanks {
print $query->header;
print<<THANKS;

<head>
  <title>PUD Information Sucessfully Submitted!</title>
<link href="/hlb.css" rel="stylesheet">
<basefont size="2">
</head>

<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">

<p><script language="javascript" src="/navi.js"></script></p>

<font size="5" color="#FF0000"><center>PUD Information Sucessfully Submitted!</center></font>
<br>

<table border="0" cellspacing="0" cellpadding="2" width="100%">
  <tr>
	<td class="hlb"><a href="/home.html">HOME</a> <b>>></b> <a href="/archives/index.html">Program Archives</a> <b>>></b> <a href="/archives/puds/index.html">PUDs</a> <b>>></b>  <a href="submit.pl">PUD Submission</a>  <b>>> <i>PUD Information Sucessfully Submitted!</i></b></td>
	</tr>
</table>

<br>
<font size="3">
<p align="justify">$name, the information for $title has been successfully submitted.  If you have a screenshot or a .zip file (Beta Testing) to submit the instructions on how to do so are including in the email that you should be receiving soon.  If you don't receive the email within <b>24 hours</b>, <a href="/contactme.html">let me know</a>.</p>

<p align="center">Thanks for being a part of BASIC Guru Online!</p>
</font>

<p><script language="javascript" src="/navi.js"></script></p>

<br><br>

<script src="/foot.js"></script>

<hr>
<br>
<center><small>Problems with this page?<br>
Contact the <a href="/contactme.html">Webmaster</a>.
</small>
</center>

</font>
</body>
</html>
THANKS
}