<?php


/*
	$Id: album_strings_en.php,v 1.16 2005/07/22 19:55:05 bobbitt Exp $

	album.php
	Written by Mike Bobbitt and DJ Houghton
	http://dev.bobbitt.ca/forums

	album_strings_en.php
	English Language Strings
*/

// Bail if this is not being called via album.php
if (!defined('album-php'))
	die('This file cannot be run directly.');

// Pick out CVS version and date for this file
$strings_cvsver = '$Revision: 1.16 $';
$strings_cvsdate = '$Date: 2005/07/22 19:55:05 $';
$strings_cvsver = preg_replace("/.*Revision:\W(\d+\.\d+).*\$/", "$1", $strings_cvsver);
$strings_cvsdate = preg_replace("/.*Date:\s(.*)\s+\S/", "$1", $strings_cvsdate);

// General
$txt['general.name'] = "album.php";
$txt['general.photo'] = "photo";
$txt['general.album'] = "album";
$txt['general.close'] = "Close this window";
$txt['general.File'] = "File";
$txt['general.VersionInfo'] = "Version Information";
$txt['general.YourVersion'] = "Your Version";
$txt['general.YourDate'] = "Your Date";
$txt['general.CurrentVersion'] = "Current Version";
$txt['general.CurrentDate'] = "Current Date";
$txt['general.Return'] = "Return to album";

// Errors
$txt['error.title'] = "ERROR!";
$txt['error.fatal'] = "Fatal error";
$txt['error.unknown'] = "Unknown error code";
$txt['error.report'] = "<p>Please report this information to <a href=\"mailto:Mike@Bobbitt.ca\">Mike@Bobbitt.ca</a>";
$txt['error.open'] = "Could not open";
$txt['error.dircreate'] = "Could not create directory";
$txt['error.album1'] = "album at";
$txt['error.config1'] = "config file at";
$txt['error.not_writable'] = "Could not write to";
$txt['error.not_readable'] = "Could not read from";
$txt['error.sanity'] = "Failed basic sanity test";
$txt['error.sanitypath'] = "Sorry, you can't use a relative path here: ";
$txt['error.sanitychars'] = "Sorry, you can't use special characters here: ";
$txt['error.upload'] = "Upload failed";
$txt['error.nozip'] = "The file you uploaded was a zip file, however the <a href=\"http://zziplib.sourceforge.net/\">ZZIPlib library</a> is not installed. (See Extension=php_zip.dll in php.ini)";
$txt['error.not_image'] = "The following file is not a valid image type: ";

// Upload
$txt['upload.upload'] = "Upload";
$txt['upload.destination'] = "Upload into: ";
$txt['upload.fileupload'] = "File to Upload: ";
$txt['upload.additional'] = "Click here to upload additional files";
$txt['upload.success'] = "successfully uploaded into";
$txt['upload.total'] = "files uploaded in total.";

?>