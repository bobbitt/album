<?php


/*
	$Id: config.php,v 1.18 2005/07/21 23:34:18 bobbitt Exp $

	album.php
	Written by Mike Bobbitt and DJ Houghton
	http://dev.bobbitt.ca/forums

	config.php
	Load/Display/Change Configuration Settings
*/

// Bail if this is not being called via album.php
if (!defined('album-php'))
	die('This file cannot be run directly.');

// Pick out CVS version and date for this file
$config_cvsver = '$Revision: 1.18 $';
$config_cvsdate = '$Date: 2005/07/21 23:34:18 $';
$config_cvsver = preg_replace("/.*Revision:\W(\d+\.\d+).*\$/", "$1", $config_cvsver);
$config_cvsdate = preg_replace("/.*Date:\s(.*)\s+\S/", "$1", $config_cvsdate);


/*
	parseConfigFile($configfile)

	$configfile = file path to album.cfg. May be absolute or relative.

	Loads the contents of album.cfg and preprocesses where required.
*/
function parseConfigFile($configfile) {
	global $configmod;
	global $config;
	global $album_dir, $album_web, $metadata, $templates, $stringtable, $imgexts, $movieexts;
	global $logfile, $descfile, $img_dir;
	global $photo_icon;
	global $stylesheet, $columns;
	global $max_upload_size;
	global $thumb_height, $thumb_width, $thumb_quality;

	// Open config file
	if (file_exists($configfile))
		$config = parse_ini_file($configfile);
	else
				error("fatal", $txt['error.open']." ".$txt['error.config1']." $configfile", __LINE__, $configmod, __FUNCTION__);		

	// Copy config values down to shorter vars
	$album_dir = $config['album_dir'];
	$album_web = $config['album_web'];
	$metadata = $config['metadata'];
	$templates = $config['templates'];
	$stringtable = $config['stringtable'];
	$imgexts = $config['imgexts'];
	$movieexts = $config['movieexts'];
	$logfile = $config['logfile'];
	$descfile = $config['descfile'];
	$img_dir = $config['img_dir'];
	$photo_icon = $config['photo_icon'];
	$stylesheet = $config['stylesheet'];
	$columns = $config['columns'];
	$max_upload_size = $config['max_upload_size'];
	$thumb_height = $config['thumb_height'];
	$thumb_width = $config['thumb_width'];
	$thumb_quality = $config['thumb_quality'];

	// Fix up paths
	$album_dir = str_replace('\\', "/", $album_dir);
	$img_dir = str_replace("\\", "/", $img_dir);

	// Fix up icon paths
	$photo_icon = "$img_dir/$photo_icon";

	// Convert all units to bytes
	$max_upload_size = returnBytes($max_upload_size);

	// Set file upload characteristics (these are ignored, but in here for good measure)
	ini_set('file_uploads', 1);
	ini_set('post_max_size', $max_upload_size);
	ini_set('upload_max_filesize', $max_upload_size);
}

/*
	downloadVars()

	Download variables from forms or URLs and makes them globally accessible.
*/
function downloadVars() {
	global $configmod;
	global $album, $photo, $function, $displaymod, $showwarn, $debug;

	// album name
	if (isset ($_REQUEST['album'])) {
		$album = $_REQUEST['album'];
	}

	// Handle single quotes
	$album = str_replace("\'", "'", $album);

	// photo name
	if (isset ($_REQUEST['photo'])) {
		$function = $_REQUEST['photo'];
	}

	// Handle single quotes
	$photo = str_replace("\'", "'", $photo);

	// function code
	if (isset ($_REQUEST['function'])) {
		$function = $_REQUEST['function'];
	}

	// Debug
	if (isset ($_REQUEST['debug'])) {
		$debug = $_REQUEST['debug'];
	}

	// Warnings info
	if (isset ($_REQUEST['showwarn'])) {
		$showwarn = $_REQUEST['showwarn'];
	}
}

/*
	readStringtable()

	Reads in the stringtable.
*/
function readStringtable() {
	global $configmod, $txt;
	global $stringtable, $install;
	global $strings_loaded, $strings_cvsver, $strings_cvsdate;

	$hard_coded = "album_strings_en.php";
	$strings_loaded = 0;

	// Check config'd path
	if (is_readable($stringtable)) {
		require_once ($stringtable);
		debug("Loaded string table from $stringtable.", 3, __LINE__, $configmod, __FUNCTION__);
		$strings_loaded = 1;
	}

	// Check relative path
	if (!$strings_loaded && is_readable($hard_coded)) {
		require_once ($hard_coded);
		$stringtable = $hard_coded;
		debug("Loaded string table (hard coded) from $hard_coded.", 3, __LINE__, $configmod, __FUNCTION__);
		$strings_loaded = 1;
	}

	// Check absolute path
	$hard_coded="$install/$hard_coded";
	if (!$strings_loaded && is_readable($hard_coded)) {
		require_once ("$install/$hard_coded");
		$stringtable = $hard_coded;
		debug("Loaded string table (hard coded) from $install/$hard_coded.", 3, __LINE__, $configmod, __FUNCTION__);
		$strings_loaded = 1;
	}

	// Just couldn't load the thing...
	if (!$strings_loaded) {
		error("fatal", "Could not open string table at $stringtable.", __LINE__, $configmod, __FUNCTION__);
	}

	// Confirm that stringtable was loaded
	if ($txt['general.name'] != "album.php") {
		error("fatal", "Your stringtable ($stringtable) appears to be corrupt.", __LINE__, $configmod, __FUNCTION__);
	}
}
?>