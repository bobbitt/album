<?php


/*
	$Id: core.php,v 1.20 2005/07/22 19:55:05 bobbitt Exp $

	album.php
	Written by Mike Bobbitt and DJ Houghton
	http://dev.bobbitt.ca/forums

	core.php
	Core Functions
*/

// Bail if this is not being called via album.php
if (!defined('album-php'))
	die('This file cannot be run directly.');

// Pick out CVS version and date for this file
$core_cvsver = '$Revision: 1.20 $';
$core_cvsdate = '$Date: 2005/07/22 19:55:05 $';
$core_cvsver = preg_replace("/.*Revision:\W(\d+\.\d+).*\$/", "$1", $core_cvsver);
$core_cvsdate = preg_replace("/.*Date:\s(.*)\s+\S/", "$1", $core_cvsdate);

/*
	$obj=getObjInfo($object)

	$obj = Array holding all object data
	$object = Object to get info for, relative to $album_dir

	Displays $debug_message if $debug_level is <= $debug, otherwise does nothing.
*/
function getObjInfo($object) {
	global $coremod;
	global $debug, $obj, $album_dir, $album_web, $descfile;
	global $metadata, $install;

	debug("Filling object array for $object", 4, __LINE__, $coremod, __FUNCTION__);

	// Don't double load data
	if (isset ($obj[$object]['loaded']))
		return ($obj);

	// Mark this object as processed
	$obj[$object]['loaded'] = 1;

	// Get Realpath
	$obj[$object]['realpath'] = realpath("$album_dir/$object");

	// Get directory, file and extension portions
	$fileinfo = pathinfo($obj[$object]['realpath']);

	if (isset ($fileinfo['extension']))
		$obj[$object]['ext'] = $fileinfo['extension'];
	else
		$obj[$object]['ext'] = "";

	// Is it an album?
	if (is_dir($obj[$object]['realpath'])) {
		$obj[$object]['is_album'] = 1;
		$obj[$object]['is_photo'] = 0;
		$obj[$object]['is_movie'] = 0;

		if (isset ($fileinfo['dirname']))
			$obj[$object]['parent'] = $fileinfo['dirname'];
		else
			$obj[$object]['parent'] = "";

		$obj[$object]['file'] = "";

		// Set album name
		$obj[$object]['album'] = $object;

		// Metadata directory
		$obj[$object]['metadir'] = dirname("$install/$metadata".$obj[$object]['album']);
	} else {
		// It's a file -- probably a photo or movie
		$obj[$object]['is_album'] = 0;

		if (isset ($fileinfo['dirname']))
			$obj[$object]['parent'] = $fileinfo['dirname'];
		else
			$obj[$object]['parent'] = "";

		if (isset ($fileinfo['basename']))
			$obj[$object]['file'] = $fileinfo['basename'];
		else
			$obj[$object]['file'] = "";

		// Set album name
		$obj[$object]['album'] = dirname($object);

		$is_photo = 0;
		$is_movie = 0;

		// Is it a photo?
		if (is_file($obj[$object]['realpath']) && isAPhoto($obj[$object]['ext'])) {
			$is_photo = 1;
		}

		if ($is_photo)
			$obj[$object]['is_photo'] = 1;
		else
			$obj[$object]['is_photo'] = 0;

		// Is it a movie?
		if (is_file($obj[$object]['realpath']) && isAMovie($obj[$object]['ext'])) {
			$is_movie = 1;
		}

		if ($is_movie)
			$obj[$object]['is_movie'] = 1;
		else
			$obj[$object]['is_movie'] = 0;

		// Metadata directory
		$obj[$object]['metadir'] = "$install/$metadata".$obj[$object]['album'];

		// URL to object
		$obj[$object]['url'] = $album_web.$object;
	}

	// Titles and descriptions
	$tempdesc = $obj[$object]['metadir']."/$descfile";
	debug("Looking for $tempdesc descriptions file.", 3, __LINE__, $coremod, __FUNCTION__);
	if (file_exists($tempdesc)) {
		$obj = array_merge_recursive2($obj, parse_ini_file($tempdesc, true));
	}

	if ($debug >= 4) {
		echo "<pre>\$obj Array:<br />";
		print_r($obj);
		echo "</pre><br />";
	}

	return ($obj);
}

// Returns 1 if the passed in filename was a photo, otherwise returns 0
// Note the file does not have to exist on disk
function isAPhoto($filename) {
	global $imgexts;

	$is_photo = 0;

	// Is it a photo?
	foreach (split(",", $imgexts) as $imgext) {
		if (preg_match("/$imgext$/i", $filename)) {
			$is_photo = 1;
		}
	}

	return ($is_photo);
}

// Returns 1 if the passed in filename was a photo, otherwise returns 0
// Note the file does not have to exist on disk
function isAMovie($filename) {
	global $movieexts;

	$is_movie = 0;

	// Is it a movie?
	foreach (split(",", $movieexts) as $movieext) {
		if (preg_match("/$movieext$/i", $filename)) {
			$is_movie = 1;
		}
	}

	return ($is_movie);
}

/*
	debug($debug_message,$debug_level,$line,$module,$function)

	$debug_message = Message to display
	$debug_level = Only display message if $debug is > $debug_level
	$line = (Optional) PHP code line, used for reference
	$module = (Optional) Module name
	$function = (Optional) Function namme

	Displays $debug_message if $debug_level is <= $debug, otherwise does nothing.
*/
function debug($debug_message, $debug_level, $line = "", $module = "", $function = "") {
	global $coremod;
	global $debug;

	if (($debug_level <= $debug) && $debug) {
		// Handle subroutine indenting
		if (preg_match("/^Entering subroutine.*/i", $debug_message)) {
			echo "<ul>";
		}

		echo "<pre>";
		if ($line) {
			echo "$line: ";
		}

		if ($module || $function) {
			echo "[";
			if ($module)
				echo $module;
			if ($module && $function)
				echo ":";
			if ($function)
				echo $function;
			echo "] ";
		}

		echo "$debug_message";
		echo "</pre>\n";

		// Handle subroutine outdenting
		if (preg_match("/^Leaving subroutine.*/i", $debug_message)) {
			echo "</ul>";
		}
	}
}

/*
	mkdirs($dirname)

	$dirname = Name of directory to make

	Just like java.io.File#mkdirs...create all dirs in this path.
*/
function mkdirs($dirname) {
	global $coremod, $txt;
	global $path;

	$dir = split("/", $dirname);
	for ($i = 0; $i < count($dir); $i ++) {
		$path .= $dir[$i]."/";
		if (!is_dir($path))
			if (!mkdir($path, 0777))
				error("fatal", $txt['error.dircreate']." $dirname ($path).", __LINE__, $coremod, __FUNCTION__);
		debug("Created partial directory: $path", 4, __LINE__, $coremod, __FUNCTION__);
	}

	debug("Created directory: $dirname", 3, __LINE__, $coremod, __FUNCTION__);

	if (is_dir($dirname))
		return 1;
}

/*
	str2path($path_str)

	$path_str = String to convert to a path.

	Convert the given string to a path and return the result.
	Similar to realpath() except it works for dirs that do not exist.
*/
function str2path($path_str) {
	global $coremod;
	$pwd = '';
	$strArr = preg_split("/(\/)/", $path_str, -1, PREG_SPLIT_NO_EMPTY);
	$pwdArr = "";
	$j = 0;
	for ($i = 0; $i < count($strArr); $i ++)
		if ($strArr[$i] != "..") {
			if ($strArr[$i] != ".") {
				$pwdArr[$j] = $strArr[$i];
				$j ++;
			}
		} else {
			array_pop($pwdArr);
			$j --;
		}
	$pStr = implode("/", $pwdArr);
	if (strpos($pStr, ":", 0) == 1 || ereg("/^.[/|\]/", $pStr))
		return $pStr;
	$pwd = strlen($pStr) > 0 ? ("/".$pStr) : "/";
	return $pwd;
}

/*
	array_merge_recursive2()

	Similar to array_merge_recursive but keyed-valued are always overwritten.
	Priority goes to the 2nd array.

	@static yes
	@public yes
	@param $paArray1 array
	@param $paArray2 array
	@return array
 */
function array_merge_recursive2($paArray1, $paArray2) {
	if (!is_array($paArray1) or !is_array($paArray2)) {
		return $paArray2;
	}
	foreach ($paArray2 AS $sKey2 => $sValue2) {
		$paArray1[$sKey2] = array_merge_recursive2(@ $paArray1[$sKey2], $sValue2);
	}
	return $paArray1;
}

// Check $path for anything that looks like a hack
function verifyPath($path) {
	// Check for relative paths... those are bad!
	if (preg_match("/^\\*\./", $path) || preg_match("/^\/*\./", $path)) {
		$errstr = $txt['error.sanitypath']." $path.";
	}

	// Special characters are also naughty
	if (preg_match("/[:|><]/", $path)) {
		$errstr = $txt['error.sanitychars']." $path.";
	}
}

/*
	sanityCheck()

	Does some basic (but important) checking of the script and it's environment to ensure
	that everything is ok.
 */
function sanityCheck() {
	global $txt, $album, $photo, $max_upload_size, $warnings, $warncount;
	global $coremod;

	// Check for security holes

	// Relative paths
	verifyPath($album);
	verifyPath($photo);

	// Check to see if file uploads are allowed
	if (!ini_get('file_uploads')) {
		$warncount ++;
		$warnings .=<<<HTML
<div class="error_message">
ERROR: File uploads are not allowed. (See file_uploads in php.ini)
</div>
HTML;
	}

	$postmax = ini_get('upload_tmp_dir');

	if (!is_writable($postmax)) {
		$warncount ++;
		$warnings .=<<<HTML
<div class="error_message">
ERROR: File upload directory ($postmax) is not writable. (See upload_tmp_dir in php.ini)
</div>
HTML;
	}

	// Check max file upload size
	$fileupmax = returnBytes(ini_get('upload_max_filesize'));
	$postmax = returnBytes(ini_get('post_max_size'));

	if ($fileupmax < $postmax) {
		$filemax = $fileupmax;
		$parm = "upload_max_filesize";
	} else {
		$filemax = $postmax;
		$parm = "post_max_size";
	}

	debug("Fileupmax: $fileupmax -- Postmax: $postmax -( Hard Max: $filemax )- CT File Max: $max_upload_size", 2, __LINE__, __FUNCTION__);

	if ($filemax < $max_upload_size) {
		$warncount ++;
		$warnings .=<<<HTML
<div class="error_message">
Warning: Uploaded files have a maximum size of $filemax bytes. (See $parm in php.ini)
</div>
HTML;
	}

	if (!function_exists('gd_info')) {
		$warncount ++;
		$warnings .=<<<HTML
<div class="error_message">
Warning: <a href="http://www.boutell.com/gd/">GD library</a> is not installed. Graphs will be unavailable.
</div>
HTML;
	}

	// Can we unzip files?
	if (!function_exists('zip_open')) {
		$warncount ++;
		$warnings .=<<<HTML
<div class="error_message">
Warning: <a href="http://zziplib.sourceforge.net/">ZZIPlib library</a> is not installed. You cannot upload .zip files. (See Extension=php_zip.dll in php.ini)
</div>
HTML;
	}

	if (isset ($errstr)) {
		error("sanity", $errstr, __LINE__, $coremod, __FUNCTION__);
	}
}

/*
	recursiveScan()

	$path = Absolute path of directory to scan

	Does some basic (but important) checking of the script and it's environment to ensure
	that everything is ok.

	Returns retults as an array of arrays:

	$results['dirs'] = Array of directories
	$results['files'] = Array of files
 */
function recursiveScan($path = "") {
	global $txt, $album, $photo, $album_dir;
	global $coremod;

	// Load album_dir if nothing else was passed in
	if (!$path) {
		$path = $album_dir;
	}

	$results['files'] = array ();
	$results['dirs'] = array ();
	$stack[] = $path;

	while ($stack) {
		$current_dir = array_pop($stack);
		if ($dh = opendir($current_dir)) {
			while (($file = readdir($dh)) !== false) {
				if ($file !== '.' AND $file !== '..') {
					$current_file = "{$current_dir}/{$file}";
					if (is_file($current_file)) {
						array_push($results['files'], "{$current_dir}/{$file}");
					}
					elseif (is_dir($current_file)) {
						$stack[] = $current_file;
						array_push($results['dirs'], $current_file);
					}
				}
			}
		} else {
			error("fatal", $txt['error.open']." ".$txt['error.config1']." $configfile", __LINE__, $coremod, __FUNCTION__);
		}
	}

	sort($results['dirs']);
	sort($results['files']);

	return ($results);
}

// Convert PHP config values to bytes
// Accepts g, m and k suffixes to denote Gigabytes, Megabytes and Kilobytes
function returnBytes($val) {
	$val = trim($val);
	$last = strtolower($val {
		strlen($val) - 1});
	switch ($last) {
		case 'g' :
			$val *= 1024;
		case 'm' :
			$val *= 1024;
		case 'k' :
			$val *= 1024;
	}

	return $val;
}

// Shows versions for all files
function showAllVersions() {
	global $txt;
	global $stringtable, $strings_loaded;
	
	$passcol="008800";
	$failcol="dd0000";
	$warncol="eF9938";

	$files = array ("index", "admin", "config", "core", "display", "error", "log", "strings", "thumb", "upload");

	echo "<h1>".$txt['general.name']." ".$txt['general.VersionInfo']."</h1>";

	echo "<table><tr><th>".$txt['general.File']."</th><th>".$txt['general.YourVersion']."</th><th>".$txt['general.YourDate']."</th><th>".$txt['general.CurrentVersion']."</th><th>".$txt['general.CurrentDate']."</th></tr>";

	$curversions = file("http://dev.bobbitt.ca/album-php/versions.php");

	foreach ($curversions as $curver) {
		$curver = split("\t", chop($curver));
		$versions[$curver[0]]['ver'] = $curver[1];
		$versions[$curver[0]]['date'] = $curver[2];
	}

	foreach ($files as $file) {
		echo "<tr><td>";

		// Make all vars global
		eval ("global \$".$file."_cvsver, \$".$file."_cvsdate, \$".$file."mod;");

		// Set the filename
		eval ("\$filename = \$".$file."mod;");

		// Handle strings file
		if ($file == "strings" && $strings_loaded) {
			$filename = $stringtable;
		}

		echo "$filename</td><td align=\"center\">";

		// Read file if it's readable, otherwise say no way
		if (is_readable($filename)) {
			require_once ($filename);
			eval ("\$yourver = \$".$file."_cvsver;");
			eval ("\$yourdate = \$".$file."_cvsdate;");
		} else {
			// Reset versions
			$yourver = $yourdate = "N/A";
			$vercol = $datecol = $failcol;
		}

		if (isset ($versions[$filename])) {
			$curver = $versions[$filename]['ver'];
			$curdate = $versions[$filename]['date'];

			// Version compliance
			if ($curver > $yourver) {
				$vercol = $failcol;
			}
			if ($curver == $yourver) {
				$vercol = $passcol;
			}
			if ($curver < $yourver) {
				$vercol = $warncol;
			}

			// Date compliance
			if ($curdate > $yourdate) {
				$datecol = $failcol;
			}
			if ($curdate == $yourdate) {
				$datecol = $passcol;
			}
			if ($curdate < $yourdate) {
				$datecol = $warncol;
			}

		} else {
			$curver = $curdate = "N/A";
			$vercol = $datecol = $failcol;
		}

		echo "<font color=\"#$vercol\">$yourver</font></td><td align=\"center\"><font color=\"#$datecol\">$yourdate</font>";
		echo "</td><td align=\"center\"><font color=\"#$vercol\">$curver</font</td><td align=\"center\"><font color=\"#$datecol\">$curdate</font>";
		echo "</td></tr>";
	}

	echo "</table><br />\n";
}
?>