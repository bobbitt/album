<?php


/*
	$Id: log.php,v 1.6 2005/07/04 21:03:46 bobbitt Exp $

	album.php
	Written by Mike Bobbitt and DJ Houghton
	http://dev.bobbitt.ca/forums

	log.php
	Logging Functions
*/

// Bail if this is not being called via album.php
if (!defined('album-php'))
	die('This file cannot be run directly.');

// Pick out CVS version and date for this file
$log_cvsver = '$Revision: 1.6 $';
$log_cvsdate = '$Date: 2005/07/04 21:03:46 $';
$log_cvsver = preg_replace("/.*Revision:\W(\d+\.\d+).*\$/", "$1", $log_cvsver);
$log_cvsdate = preg_replace("/.*Date:\s(.*)\s+\S/", "$1", $log_cvsdate);


?>