#!/usr/bin/perl

use CGI;

# Sends Errors to Browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

$sendmail = "/usr/lib/sendmail -t";

$redirect = "/comments.html";

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
	$email = $query->param('email');
	$about = $query->param('about');
	$comments = $query->param('comments');
}

sub sendveri {
	open(MAIL, "|$sendmail");
	print MAIL <<SV;
From: Benahimvp\@aol.com (BASIC Guru Online Help)
To: $email
Subject: Your Comment/Question/Suggestion has been received

You are receiving this email to let you know that your comment, question, or suggestion that you submitted at BASIC Guru Online has been received and will be attended to in an expedient fashion.  Once the matter has been taken care of, whether it be to answer your question or handle your comment/suggestion, you will receive another email.  If you asked a question, your question will be answered or some means to answer the question will be given.

Please note that if you submitted a question that has already been answerd in the FAQ, you will be simply told to go to the FAQ to find your answer.  So, to be on the safe side, you should probably check out the FAQ, if you haven't already, to see if your question indeed has been answered there.

You should also try the BASIC Guru Online General Message Board.  Many questions are posted there and you might find the answer to your question right there.  You can even search the board to find posts that deal with just your topic.  In addition, if you want, you can also post your question there and maybe one of the other members or visitors will have an answer for you.  It just so happens that you may receive a reply quicker on the message board then from here.  If you do decide to post a question, make sure to include your email address and check the option to receive an email notice when somebody replies to your post.  You can find a link to the message board on the Vistor Interaction page or the Help Center page.

-Ben Ilegbodu (BASIC Guru Online webmaster)

SV
	close (MAIL);
}

sub sendmeinfo {
	open(MAIL, "|$sendmail");
	print MAIL<<SI;
From: $email ($name)
To: Benahimvp\@aol.com
Subject: Comment/Question/Suggestion from $name (BGO)

$name has submitted a comment/question/suggestion to you and here's all the information:

Name: $name
E-mail: $email
Pertain's To: $about
Comment/Question/Suggestion: $comments

SI
	close (MAIL);
}

sub thanks {
print $query->header;
print<<THANKS;

<head>
  <title>Comment/Question/Suggestion Submitted!</title>
<link href="../../hlb.css" rel="stylesheet">
<basefont size="2">
</head>

<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">

<p><script language="javascript" src="../../navi.js"></script></p>

<font size="5" color="#FF0000"><center>Comment/Question/Suggestion Submitted!</center></font>
<br>

<table border="0" cellspacing="0" cellpadding="2" width="100%">
  <tr>
	<td class="hlb"><a href="../../home.html">HOME</a> <b>>></b> <a href="/contactme.html">Help</a> <b>>></b>  <a href="/comments.html">Comments/Questions/Suggestions</a>  <b>>> <i>Comment/Question/Suggestion Submitted!</i></b></td>
	</tr>
</table>

<br>
<font size="3">
<p align="justify">Your comment, question, or suggestion has been successfully submitted.  You should soon be receiving an email acknowledging that your comment/question/suggestion has been received.  If you do not receive this email, this means that your comment/question/suggestion was not received and should probably try resending it.  If the problem persists, go back to the <a href="/contactme.html">Help Center page</a>, and scroll all the way to the bottom.  Send an email to the webmaster.  Thanks for you submission!</p>
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