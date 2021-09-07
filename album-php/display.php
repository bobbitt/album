<?php


/*
	$Id: display.php,v 1.17 2005/07/21 23:34:18 bobbitt Exp $

	album.php
	Written by Mike Bobbitt and DJ Houghton
	http://dev.bobbitt.ca/forums

	display.php
	Album Display Functions
*/

// Bail if this is not being called via album.php
if (!defined('album-php'))
	die('This file cannot be run directly.');

// Pick out CVS version and date for this file
$display_cvsver = '$Revision: 1.17 $';
$display_cvsdate = '$Date: 2005/07/21 23:34:18 $';
$display_cvsver = preg_replace("/.*Revision:\W(\d+\.\d+).*\$/", "$1", $display_cvsver);
$display_cvsdate = preg_replace("/.*Date:\s(.*)\s+\S/", "$1", $display_cvsdate);

/*
	photoAlbum($album)

	$album = Album name (relative to $album_dir) to display

	Displays the current sub-albums and photos in $album.
*/
function photoAlbum($album) {
	global $displaymod, $txt;
	global $obj, $columns, $album_dir, $thumbmod;
	global $script;

	// Clean up the album path
	//$album = addslashes($album);

	// Get object info
	getObjInfo("/".$album);

	$prefix = "$album_dir/";

	$relprefix = "";

	if ($album)
		$relprefix = "$album/";

	$prefix .= $relprefix;

	if (!is_dir($prefix)) {
		error("fatal", $txt['error.open']." ".$txt['error.album1']." $prefix", __LINE__, $displaymod, __FUNCTION__);
	}

	// Get the directory info. Find matching filenames and potential sub-folders
	$fp = opendir(realpath($prefix));
	while (($file = readdir($fp)) !== false) {
		debug("File: $file", 3, __LINE__, $displaymod, __FUNCTION__);

		$relfile = "/$relprefix$file";

		// Get object info
		getObjInfo($relfile);

		if (!preg_match('/^\./', $file)) {
			if ($obj[$relfile]['is_photo']) {
				$files[$file] = str2path("/".$file);
			}
			elseif ($obj[$relfile]['is_album']) if (isset ($dirs)) {
				debug("Directory: [$file]", 2, __LINE__, $displaymod, __FUNCTION__);
				$dirs = array_merge($dirs, array ($file));
			} else {
				debug("Directory: [$file]", 2, __LINE__, $displaymod, __FUNCTION__);
				$dirs = array ($file);
			}
		}
	}
	closedir($fp);

	// Build the table of albums (folders)
	echo "<center>\n";

	if (isset ($dirs)) {
		// Sort the items
		sort($dirs);

		// Iterate through the list
		for ($i = 0; $i < count($dirs); $i ++) {
			$folder = $dirs[$i];

			debug("Folder: [$folder]", 2, __LINE__, $displaymod, __FUNCTION__);

			$fullpath = "$script?album=";
			if ($album)
				$fullpath .= $album."/";
			$fullpath .= $folder;

			echo "<a href=\"".$fullpath."\"/>[".$folder."]</a><br>\n";
		}
		if (isset ($files))
			echo "<hr>\n";
	}

	// Setup the table of images
	echo "<table>\n";
	$c = 0;

	if (isset ($files)) {
		// Natural, case insensitive sort of files
		natcasesort($files);

		// Iterate through files
		foreach ($files as $key => $value) {
			debug("Now processing [$key:$value]", 3, __LINE__, $displaymod, __FUNCTION__);

			if (preg_match("/^\//", $album) || !$album)
				$object = "$album/$key";
			else
				$object = "/$album/$key";

			$photo = $value;

			// End of column
			if ($c % $columns == 0)
				echo "<tr>\n";

			echo '<td align="center">';

			require_once ($thumbmod);
			echo showThumb($object);

			if (isset ($obj[$object]['title']))
				echo $obj[$object]['title'];
			else
				echo $obj[$object]['file'];

			echo "</td>\n";
			if ($c % $columns == ($columns -1))
				echo "</tr>\n";
			$c ++;
		}
	}
	echo<<<HTML
</table>
</center>
HTML;
}

/*
	aboutAlbum()

	Shows a short "about album.php" description.
*/
function aboutAlbum() {
	global $displaymod;
	global $ver;

	// **** NOTE ****
	// Removing or editing this section violates the terms of the license.
	// You must leave it in tact in order to use album.php.
	// **** NOTE ****

	echo<<<HTML
</center>
<br />
Version $ver written by <a href="mailto:Mike@Bobbitt.ca">Mike Bobbitt</a> and DJ Houghton.
<br />&nbsp;<br />
See <a href="http://dev.Bobbitt.ca/forums" target="_blank">http://dev.Bobbitt.ca/forums</a> for updates and information.
Please post any problems or questions about this program in the <a href="http://dev.Bobbitt.ca/forums" target="_blank">the album.php support forums</a>.
<br />&nbsp;<br />
&copy; 2004-
HTML;
	echo date("Y");
	echo<<<HTML
 Cipher Logic Canada Inc. All Rights Reserved.
<br />&nbsp;<br />
HTML;

	// **** NOTE ****
	// Removing or editing this section violates the terms of the license.
	// You must leave it in tact in order to use album.php.
	// **** NOTE ****

}

/*
	showFooter()

	Displays the album.php footer.
*/
function showFooter($exitcode = 0) {

	global $ver, $cvsdate, $warnings, $warncount, $showwarn, $txt;
	global $displaymod;
	if ($showwarn) {
		echo stripslashes(urldecode($showwarn));
		echo<<<HTML
<br />
<center><a href="" OnClick="window.close()">
HTML;
		echo $txt['general.close'];

		echo<<<HTML
</a></center>
HTML;
		exit (0);
	}

	if (isset ($warnings)) {
		echo<<<HTML
<br />
<div class="error_message">There were $warncount warnings. Please <a onclick="window.open('?showwarn=
HTML;
		echo urlencode($warnings);
		echo<<<HTML
		','Frequency','width=640,height=220,resizable'); return false" href="">click here</a> to see them.
</div>
<br />
HTML;
	}

	// **** NOTE ****
	// Removing this section violates the terms of the license.
	// You must leave it in tact in order to use album.php.
	// **** NOTE ****

	echo<<<HTML
<br />
<small><small><a title="album.php $ver $cvsdate" href="?function=about">
album.php $ver
</a></small></small>
</body>
</html>
HTML;

	// **** NOTE ****
	// Removing this section violates the terms of the license.
	// You must leave it in tact in order to use album.php.
	// **** NOTE ****

	exit ($exitcode);
}
?>