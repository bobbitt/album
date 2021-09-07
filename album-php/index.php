<?php


/*
	$Id: index.php,v 1.32 2005/07/22 19:55:05 bobbitt Exp $

	album.php
	Written by Mike Bobbitt and DJ Houghton
	http://dev.bobbitt.ca/forums

	index.php
	Main File
*/

// Location of config file
$configfile = "album.cfg";

// Set debug level:
//	0 = None
//	1 = Special - Nothing has this code, so you can add a ,1 to any debug statement to make it stand out on it's own
//	2 = Standard - No recursive info or detailed file info. Usually just startup info.
//	3 = Detailed - Some recursive and detailed info.
//	4 = Overwhelming - Everything that ever had a debug turned on.
//	5 = Also show phpinfo();
$debug = 1;

/*
	Release Notes

	$Log: index.php,v $
	Revision 1.32  2005/07/22 19:55:05  bobbitt
	* Online versions checking
	
	Revision 1.31  2005/07/21 23:34:18  bobbitt
	* ?function=upload completed
	* Better sanity checking
	* Subroutines for photo/image detection
	* showFooter now forces exit
	
	Revision 1.30  2005/07/21 20:02:15  bobbitt
	* Added function=versions
	
	Revision 1.29  2005/07/05 19:34:36  bobbitt
	*** empty log message ***
	
	Revision 1.28  2005/03/18 20:56:21  bobbitt
	* Added stylesheet config item
	* Created initial album.css
	* Added max_upload_size config item
	* Added returnBytes function to convert units to bytes
	* Created warnings display system
	* Uploads partly completed

	Revision 1.27  2005/03/15 21:14:25  bobbitt
	* Added recursiveScan
	* Added album droplist to upload form (still not functional)
	* Added not_readable error code

	Revision 1.26  2005/03/02 22:12:19  bobbitt
	* Basic upload form
	* Added sanity checking
	* Moved some strings to album_strings

	Revision 1.25  2005/02/25 01:20:48  bobbitt
	* Updated URLs and reformatted

	Revision 1.24  2005/02/01 18:23:31  bobbitt
	* Added release notes section

 */

// Define var to prevent sub-files from being run directly
define('album-php', 1);

// Build CVS version information
$cvsver = '$Revision: 1.32 $';
$cvsdate = '$Date: 2005/07/22 19:55:05 $';
$index_cvsver = preg_replace("/.*Revision:\W(\d+\.\d+).*\$/", "$1", $cvsver);
$index_cvsdate = preg_replace("/.*Date:\s(.*)\s+\S/", "$1", $cvsdate);

$major_ver = "0";
$ver = $major_ver.".".$index_cvsver;
$cvsdate = $index_cvsdate;

// Show phpinfo()
if ($debug == 5) {
	phpinfo();
}

// Set module nammes
$indexmod = "index.php";
$errormod = "error.php";
$configmod = "config.php";
$displaymod = "display.php";
$adminmod = "admin.php";
$uploadmod = "upload.php";
$thumbmod = "thumb.php";
$logmod = "log.php";
$coremod = "core.php";

// Are we just checking versions?
if (defined('album-php-versions')) {
	 return(0);
}

// Load Required files
require_once ($coremod);
require_once ($errormod);
require_once ($configmod);

// Try to find SCRIPT_FILENAME if it exists
$install = $_ENV["SCRIPT_FILENAME"];
if (!$install) {
	$install = $_SERVER["SCRIPT_FILENAME"];
}
$install = str_replace('\\', "/", dirname(realpath($install)));
debug("Install path is: [$install]", 2, __LINE__, $indexmod, __FUNCTION__);

// Now pick out the relative URL
$script = $_SERVER['PHP_SELF'];

parseConfigFile($configfile);
readStringtable();

// Let's show all errors
ini_set('error_reporting', E_ALL);
ini_set('display_errors', true);
ini_set('html_errors', true);

// Pull down web vars into globally accessible vars
downloadVars();

// Do some sanity and security checking
sanityCheck();

// Start writing out the resulting HTML file.
echo<<<HTML
<html>
<head>
HTML;

if ($stylesheet) {
	echo '<link rel="stylesheet" type="text/css" href="', $stylesheet, '" />';
}

echo<<<HTML

<title>
HTML;

echo basename($album);
echo " - ";
echo $txt['general.name'];

echo<<<HTML
</title>
</head>
<body>
<div id="content">
<div class="main">
HTML;

// Are we simply showing warnings?
if (isset ($showwarn)) {
	require_once ($displaymod);
	showFooter();
	exit (0);
}

switch ($function) {
	// Show "about" page
	case 'about' :
		require_once ($displaymod);
		aboutAlbum();
		break;

		// Show upload form
	case 'upload' :
		require_once ($uploadmod);
		showUploadForm();
		break;

		// Actually perform upload
	case 'file_upload' :
		require_once ($uploadmod);
		doUpload();
		break;

		// Display album
	case 'album' :
	default :
		require_once ($displaymod);
		photoAlbum($album);
		break;

		// Show all file versions
	case 'versions' :
		require_once ($coremod);
		showAllVersions();
		break;
}

require_once ($displaymod);
showFooter();
?>