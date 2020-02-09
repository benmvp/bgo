#!/usr/bin/perl

use CGI;

# Sends Errors to Browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

$links_file = "links.txt";

$error = $query->param('error');
$name = $query->param('name');
$email = $query->param('email');
$formtitle = $query->param('title');
$formurl = $query->param('url');
$formdes = $query->param('description');

open(LINKS,$links_file);
@links=<LINKS>;
close(LINKS);

&pagestart;

foreach $link (@links){
  chomp($link);
  ($title, $url, $description) = split(/\|/,$link);
	&displaylink($title, $url, $description);
}

&submitform;
&hosting;
&webrings;
&pageend;

sub pagestart {
print $query->header;
print<<HEADING;
<head>
  <title>BASIC Guru Online Links</title>
<style>
<!--   a \{ text-decoration : none \}
  a:hover		\{  text-decoration : underline \} -->
</style>

<link href="../../hlb.css" rel="stylesheet" />

<link href="../../tablefontsize.css" rel="stylesheet">

<script language="javascript" src="../../disable.js"></script>

<basefont size="2" />
<base target="main" />
</head>

<body bgcolor="\#FFFFFF" text="\#000000" link="\#0000FF" vlink="\#0000FF" alink="\#FF0000">
<font face="Times New Roman, Times, Serif">

<p><script language="javascript" src="../../navi.js"></script></p>

<font size="4"><b>BASIC Guru Online Links</b></font>
<hr />

<table border="0" cellspacing="0" cellpadding="2" width="100\%">
  <tr>
	<td class="hlb"><a href="../../home.html">HOME</a> <b>>> <i>BASIC Guru Online Links</b></i></td>
	</tr>
</table>

<p align="justify">Welcome to BASIC Guru Online's links page.  Here are links to other TI calculator-related websites where you can find more programs to download or infromation on all the types of TI Calculators.</p>

<a name="links"></a>
<table border="0" cellspacing="0" cellpadding="4" width="100\%">
<colgroup>
  <col span="1" width="22\%">
  <col span="1" width="4\%">
  <col span="1" width="74\%">
</colgroup>
HEADING
}

sub displaylink {
print<<LINK;
  <tr valign="top">
		<td><a href="$url" target="_blank">$title</a></td>
    <td align="center">--</td>
    <td><font size="2"><div align="justify">$description</div></font></td>
  </tr>
LINK
}

sub submitform {
	print<<FORM;
</table>

<a name="submit"><p align="justify">Do you also have a TI calculator-related website?  Do you want it to receive more publicity?  If you want, you can submit your link below so that it can be added to the links list.  Make sure that you put a link back to BASIC Guru Online somewhere on your site, preferably in your Links Page if you have one.  Also include this description of the site: <a name="description"></a><i>An online set of BASIC Tutorials for the TI-83 and TI-83 Plus. It contains extensive tutorials, a searchable index of commands, members pages, a growing program archives, site hosting, site search, interaction, POMs, SOMs, programming challenges, games, links, awards, and much more!</i>  If this is too much for you to add as a description than just put as much as you can, but you <b>must</b> have the first sentence because that's the main description of the site.  Also, if your site contains tutorials/tips on how to program any calculator in any language, you should join the <a href="http://edit.webring.yahoo.com/cgi-bin/membercgi?ring=titutor&addsite" target="_blank">TI Tutor</a> webring.  It's a webring specifically for sites that have tutorials in them.</p></a>

<p><font color="#FF0000">$error</font></p>

<form name="linkform" method="post" action="sign-up.pl" onSubmit="return disableForm(this)\;">
<table border="0" cellspacing="0" cellpadding="0" width="100\%">
	<tr valign="middle">
		<td class="12">Your Name:</td>
		<td><input type="text" name="name" size="60" value="$name"></td>
	</tr>
	<tr valign="middle">
		<td class="12">Email:</td>
		<td><input type="text" name="email" size="60" value="$email"></td>
	</tr>
	<tr valign="middle">
		<td class="12">Site's Title:</td>
		<td><input type="text" name="title" size="60" value="$formtitle"></td>
	</tr>
	<tr valign="middle">
		<td class="12">Site's URL:</td>
		<td><input type="text" name="url" size="60" value="$formurl"></td>
	</tr>
	<tr valign="middle">
		<td class="12">Site's Description:</td>
		<td><input type="text" name="description" size="60" value="$formdes"></td>
	</tr>
	<tr>
		<td>\&nbsp;</td>
		<td>\&nbsp;</td>
	</tr>
	<tr align="center">
		<td colspan="2"><input type="submit" value="Send Form"></td>
	</tr>
</table>

<p align="justify">If your link is already in the list of links and you want to update it, send an email to <a href="mailto:links\@basicguruonline.com?subject=Link Update">links\@basicguruonline.com</a>, with the new information (including your name and email address).</p>
FORM
}

sub hosting {
	print<<HOSTING;
<a name="hosting"></a>
<dl>
	<dt><a href="../../hosting/index.html">Hosting</a></dt><dd><div align="justify">Check out information on BASIC Guru Online hosting.  BASIC Guru Online will host your site for free and give unlimited email addresses.  Get more visitors to your site.</div></dd>
</dl>
HOSTING
}

sub webrings {
print<<WEBRINGS;
<a name="webrings"></a>

<p align="center"><script language="javascript" src="http://ss.webring.yahoo.com/navbar?f=j\&y=benahimvp\&u=96916472910037019"></script></p>

<p align="center">
<script language=javascript src="http://ss.webring.yahoo.com/navbar?f=j\&y=basicguruonline\&u=97244186910063662"></script>
</p>

<p align="center"><script language="javascript" src="http://ss.webring.yahoo.com/navbar?f=j\&y=basicguruonline\&u=97884763610188330"></script></p>
WEBRINGS
}

sub pageend {
print<<ENDING;
<p><script language="javascript" src="../../navi.js"></script></p>

<br><br>

<script src="../../foot.js"></script>

<hr />
<br />
<center><small>Problems with this page?<br>
Contact the <a href="../../contactme.html">Webmaster</a>.
</small>
</center>

</font>
</body>
</html>
ENDING
}