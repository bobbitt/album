#!/usr/bin/perl --
# $Id: album_test.pl,v 1.8 2004/09/13 15:25:39 bobbitt Exp $

use Cwd;

$perl="perl";
$album_file="album.pl";
$album_config_file="album.cfg";
$cwd=cwd;

$album="$cwd/$album_file";
$album_config="$cwd/$album_config_file";


use constant FAIL => 1;
use constant PASS => 2;

# Print HTML Page Header
print <<HTML;
Content-Type: text/html


<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">
<html>
<head>
<title>
$album_file Diagnostics
</title>
</head>
HTML

	display("<h1>$album_file Diagnostics</h1>");

	# File exists
	display("Checking to see if \"$album\" exists...");

	if (-e $album)
	{
		display("PASS",PASS);
	}
	else
	{
		display("FAIL",FAIL);
	}
	display("<p />");

	# File is executable
	display("Checking to see if \"$album\" is executable... (*NIX systems only)");

	if (-X $album)
	{
		display("PASS",PASS);
	}
	else
	{
		display("FAIL",FAIL);
	}
	display("<p />");


	# Config exists
	display("Checking to see if \"$album_config\" exists...");

	if (-e $album_config)
	{
		display("PASS",PASS);
	}
	else
	{
		display("FAIL",FAIL);
	}
	display("<p />");

	# Config is writable
	display("Checking to see if \"$album_config\" is writable...");

	if (-W $album_config)
	{
		display("PASS",PASS);
	}
	else
	{
		display("FAIL",FAIL);
	}
	display("<p />");

	# ImageMagick?
	$system_call="which convert";

	display("Checking to see if ImageMagick is installed: $system_call...");

	$output=`$system_call 2>&1`;
	if ($output=~s/\/convert//)
	{
		display("PASS: Set <b>\imagemagick=$output\</b> in album.cfg to use ImageMagick.",PASS);
	}
	else
	{
		display("FAIL $output",FAIL);
	}
	display("<p />");

	$output=$system_call="";

	# Check for DBI
	checkPackage("DBI","available_drivers","Used for database access to MySQL, etc. Not required if you don't use a database.",1);

	# Check for Digest::MD5
	checkPackage("Digest","MD5","Used to hash passwords for some forums, such as UBB. Not required if you're not using hashed passwords.");

	# Check for Digest::HMAC_MD5
	checkPackage("Digest","HMAC_MD5","Used to hash passwords for some forums, such as recent SMF or YaBB SE. Not required unless your forum software uses HMAC MD5.");

	# Check for CGI::Cookie
	checkPackage("CGI","Cookie","Used for browser cookie handling, to allow automatic login.");

	# Check for File::Copy
	checkPackage("File","Copy","Used to set album thumbnails.");

	# Check for URI::Escape
	checkPackage("URI","Escape","Use to \"webify\" all URLs, allowing for characters like & in file/directory names.");

	# Check for GD::Image
	checkPackage("GD","Image","Can be used to create autmatic thumbnails. (See perl_gd in album.cfg)");

	# Check for album.pl output
	$system_call="$perl $album";

	display("Checking for $album_file output: $system_call... (*NIX systems only)");

	$output=`$system_call 2>&1`;

	if ($output)
	{
		# Catch Perl package include problems
		if ($output=~/Can't locate/i)
		{
			display("<font color=\"red\">Some of the Perl packages that have been identified as missing are critical. Please <a href=\"http://perl.bobbitt.ca/forums/index.php/topic,820.0\">see this thread on the album.pl support forums</a> for more information.</font>");
		}
		display("<table border=\"3px\" bordercolor=\"#003366\"><tr><td>$output</td></tr></table>",);
	}
	else
	{
		display("No output detected.",FAIL);
	}
	display("<p />");

exit(0);

sub checkPackage
{
my $pkg=shift;
my $method=shift;
my $desc=shift;
my $mode=shift;

	display("Checking to see if the ".$pkg."::".$method." package is installed...");

	if ($mode)
	{
		eval("use ".$pkg.";\n".$pkg."::".$method."()");
	}
	else
	{
		eval("use ".$pkg."::".$method."()");
	}


	if ($@=~/^Can't locate/)
	{
		display($pkg."::".$method." Not installed.<br />".$pkg."::".$method." usage notes: $desc",FAIL);
	}
	else
	{
		display($pkg."::".$method." appears to be installed.",PASS);
	}
	display("<p />");
}

sub display
{
my $message=shift;
my $result=shift;

	if ($result eq FAIL)
	{
		print "<font color=\"red\">";
	}
	if ($result eq PASS)
	{
		print "<font color=\"green\">";
	}

	print "$message<br>";

	if ($result eq FAIL || $result eq PASS)
	{
		print "</font>";
	}
}