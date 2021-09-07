<?php


/*
	$Id: error.php,v 1.18 2005/07/22 16:48:55 bobbitt Exp $

	album.php
	Written by Mike Bobbitt and DJ Houghton
	http://dev.bobbitt.ca/forums

	error.php
	Error Handling
*/

// Bail if this is not being called via album.php
if (!defined('album-php'))
	die('This file cannot be run directly.');

// Pick out CVS version and date for this file
$error_cvsver = '$Revision: 1.18 $';
$error_cvsdate = '$Date: 2005/07/22 16:48:55 $';
$error_cvsver = preg_replace("/.*Revision:\W(\d+\.\d+).*\$/", "$1", $error_cvsver);
$error_cvsdate = preg_replace("/.*Date:\s(.*)\s+\S/", "$1", $error_cvsdate);

/*
	error($error,$extra_info,$module,$function)

	$error = The error code
	$extra_info = Related text such as system error messages
	$line = (Optional) PHP code line, used for reference
	$module = (Optional) Module name
	$function = (Optional) Function namme

	Displays error info in a consistent format, and aborts execution.
*/
function error($error, $extra_info, $line = "", $module = "", $function = "") {
	global $errormod, $txt;
	global $displaymod;

	echo "<br />".$txt['error.title']."<br /><br />";

	$errstring = "";

	if ($line || $module || $function) {
		$errstring .= "[";
		if ($module)
			$errstring .= $module;
		if ($module && ($function || $line))
			$errstring .= ":";
		if ($function)
			$errstring .= $function;
		if (($module || $function) && $line)
			$errstring .= ":";
		if ($line)
			$errstring .= "$line";
		$errstring .= "] ";
	}

	switch ($error) {

		// General fatal error
		case 'fatal' :
			$errstring .= $txt['error.fatal'].": $extra_info";
			break;

			// File/dir is not writable
		case 'not_writable' :
			$errstring .= $txt['error.not_writable'].": $extra_info";
			break;

			// File/dir is not readable
		case 'not_readable' :
			$errstring .= $txt['error.not_readable'].": $extra_info";
			break;

			// Basic sanity failure
		case 'sanity' :
			$errstring .= $txt['error.sanity'].": $extra_info";
			break;

			// Upload failed
		case 'upload' :
			$errstring .= $txt['error.upload'].": $extra_info";
			break;

			// ZZip module is not installed
		case 'nozip' :
			$errstring .= $txt['error.nozip'];
			break;

			// File is not a valid image
		case 'not_image' :
			$errstring .= $txt['error.not_image']."$extra_info";
			break;

			// Catch all unprocessed error codes due to sloppy coding :-\
		default :
			$errstring .= $txt['error.unknown'].": $error ($extra_info)".$txt['error.report'];
	}

	echo '<div class="error_message">', $errstring, "</div>";
	echo javaAlert($errstring);

	require_once ($displaymod);

	showFooter(1);
}

/*
	$java=javaAlert($message)

	$java = HTML code to create a JS popup containing $message
	$message = Message to show in popup

	Returns the HTML to show a JS popup window with a single OK button.
	The returned code must be displayed to the browser to be used.
*/
function javaAlert($message) {
	global $errormod;

	$message = preg_replace("/[\n\r]/", "", $message);
	$javastuff =<<<HTML
<script language="JavaScript">
<!--
alert('$message');
//-->
</script>
HTML;
	return ($javastuff);
}
?>