#!/usr/bin/perl

use CGI;

# Sends Errors to Browser
use CGI::Carp qw(fatalsToBrowser);

$query = new CGI;

$redirect = "../../archives/index.html";

if (!$query->param()) {
	print $query->redirect($redirect);
}
else {
	&setvars;
	&progprofile;
	&memprofile;
	&proglisting;
	&download;
}

sub setvars {
	$file = $query->param('prog');
	$dir = $query->param('directory');
	$prog_file = $dir . "/programs.txt";
	$user_file = "../members/members.txt";
	$prog2_file = "programs.txt";
	$download = "../../archives/" . $dir . "/" . $file . ".zip";
}

sub progprofile {
	open(INFO,"+>>$prog_file");
	flock INFO, 2;
	seek INFO, 0, 0;
	@progs = <INFO>;
	@new_progs = ();
	
	foreach $program (@progs){
		chomp($program);
		($filename, $title, $description, $author, $userid, $directory, $category, $filesize, $documentation, $docfile, $screenshots, $votes, $total, $dloads) = split(/\|/,$program);
		if (($filename eq $file) && ($directory eq $dir)) {
			$dloads++;
			$user = $userid;
			$program = "$filename|$title|$description|$author|$userid|$directory|$category|$filesize|$documentation|$docfile|$screenshots|$votes|$total|$dloads";
		}
		$program .= "\n";
		push @new_progs, $program;
	}
	seek INFO, 0, 0;
	truncate INFO, 0;
	print INFO @new_progs;
	close(INFO);
}

sub memprofile {
	open(MEM,"+>>$user_file");
	flock MEM, 2;
	seek MEM, 0, 0;
	@users = <MEM>;
	@new_users = ();
	
	foreach $member (@users){
chomp($member);
($userid, $name, $username, $email, $age, $city, $aim, $yahooid, $icq, $webname, $webaddy, $webdes, $calcown, $calcprog, $calclang, $complang, $otherinfo, $date, $progs, $dloads) = split(/\|/,$member);
if ($userid eq $user){
			$dloads++;
			$member = "$userid|$name|$username|$email|$age|$city|$aim|$yahooid|$icq|$webname|$webaddy|$webdes|$calcown|$calcprog|$calclang|$complang|$otherinfo|$date|$progs|$dloads";
		}
		$member .= "\n";
		push @new_users, $member;
	}
	seek MEM, 0, 0;
	truncate MEM, 0;
	print MEM @new_users;
	close(MEM);
}

sub proglisting {
	open(PROG,"+>>$prog2_file");
	flock PROG, 2;
	seek PROG, 0, 0;
	@programs = <PROG>;
	@new_programs = ();
	
	foreach $prog (@programs){
		chomp($prog);
		($filenamea, $titlea, $directorya, $downloadsa) = split(/\|/,$prog);
		if (($filenamea eq $file) && ($directorya eq $dir)) {
			$downloads++;
			$prog = "$filenamea|$titlea|$directorya|$downloadsa";
		}
		$prog .= "\n";
		push @new_programs, $prog;
	}
	seek PROG, 0, 0;
	truncate PROG, 0;
	print PROG @new_programs;
	close(PROG);
}

sub download {
	print $query->redirect($download);
}