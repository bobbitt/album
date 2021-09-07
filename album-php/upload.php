<?php


/*
	$Id: upload.php,v 1.12 2005/07/22 16:48:54 bobbitt Exp $

	album.php
	Written by Mike Bobbitt and DJ Houghton
	http://dev.bobbitt.ca/forums
	
	upload.php
	Upload Functions
*/

// Bail if this is not being called via album.php
if (!defined('album-php'))
	die('This file cannot be run directly.');

// Pick out CVS version and date for this file
$upload_cvsver = '$Revision: 1.12 $';
$upload_cvsdate = '$Date: 2005/07/22 16:48:54 $';
$upload_cvsver = preg_replace("/.*Revision:\W(\d+\.\d+).*\$/", "$1", $upload_cvsver);
$upload_cvsdate = preg_replace("/.*Date:\s(.*)\s+\S/", "$1", $upload_cvsdate);

// Show the HTML form for uploads
function showUploadForm() {
	global $max_file_size, $txt, $debug, $album_dir, $script;

	echo '<h1>', $txt['upload.upload'], '</h1>';

	// Get list of sub-directories
	$objects = recursiveScan();

	if ($debug >= 4) {
		print_r($objects);
	}

	echo<<<HTML
<div class="block">
<form enctype="multipart/form-data" method="POST" action="$script">
    <input type="hidden" name="MAX_FILE_SIZE" value="$max_file_size" />
    <input type="hidden" name="function" value="file_upload" />

HTML;

	$uploadHTML = $txt['upload.fileupload'];

	$uploadHTML .= '<input name="datafile" type="file" />'."\n";
	;

	$uploadSelect = "<br /><br />".$txt['upload.destination'];

	$uploadSelect .= '<select name="album">';
	;

	foreach ($objects['dirs'] as $dir) {

		// Escape slashes
		$slashalbum = preg_replace("/\//", "\\\/", $album_dir);

		$dir = preg_replace("/^$slashalbum\/(.*)/", "\$1", $dir);
		$uploadSelect .= "<option>$dir</option>";
	}

	$uploadSelect .= "</select></br>";

	$uploadHTML .= $uploadSelect;

	echo<<<HTML
$uploadHTML
<br />
<script language="JavaScript" type="text/javascript"><!--
document.write('<div id="moreUploads"></div><font size="1">&nbsp;&nbsp;&nbsp;[ <a href="#" onclick="addUploads(); return false;">
HTML;

	echo $txt['upload.additional'];

	echo<<<HTML
</a> ]</font><br />');

// Set the "outer" HTML of an element.
function setOuterHTML(element, toValue)
{
	if (typeof(element.outerHTML) != 'undefined')
	element.outerHTML = toValue;
	else
	{
		var range = document.createRange();
		range.setStartBefore(element);
		element.parentNode.replaceChild(range.createContextualFragment(toValue), element);
	}
}
function addUploads()
{
setOuterHTML(document.getElementById("moreUploads"), '<div style="margin-bottom: 2ex;">
HTML;

	echo $txt['upload.fileupload'];

	// Escape ' characters
	$uploadSelect = preg_replace("/'/", "\\'", $uploadSelect);
	
	// Make dir droplist work with multuple entries
	$uploadSelect = preg_replace("/name=\"album\"/", "name=\"extraalbum[]\"", $uploadSelect);

	echo<<<HTML
<input name="extralog[]" type="file" />$uploadSelect</div><div id="moreUploads"></div>');
}
// --></script>
</div>
<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="
HTML;

	echo $txt['upload.upload'];

	echo<<<HTML
" /><br /><br />
</form>
HTML;
}

// Open a file for processing. If it's a zip file, unzip it. Returns the file contents as an array.
// $filename	-	Actual temporary filename on disk (E.G. C:\PHP\uploadtemp\php87.tmp)
// $uploadname	-	Filename (no path) of uploaded file (E.G. IM00561.jpg)
// $destination	-	Album (relative to root) to upload image to
function downloadFile($filename, $uploadname, $destination) {
	global $uploadmod;

	// Unzip it first
	if (preg_match("/\.zip$/", $uploadname)) {
		// Can we unzip files?
		if (!function_exists('zip_open')) {
			error("nozip", "", __LINE__, $uploadmod, __FUNCTION__);
		} else {
			$zip = zip_open($filename);

			if ($zip) {

				while ($zip_entry = zip_read($zip)) {
					debug("Zip File Name:	".zip_entry_name($zip_entry), 2, __LINE__, __FUNCTION__);
					debug("Actual Filesize:	".zip_entry_filesize($zip_entry), 2, __LINE__, __FUNCTION__);
					debug("Compressed Size:	".zip_entry_compressedsize($zip_entry), 2, __LINE__, __FUNCTION__);
					debug("Compression Method:	".zip_entry_compressionmethod($zip_entry), 2, __LINE__, __FUNCTION__);

					if (zip_entry_open($zip, $zip_entry, "r")) {
						$buf = zip_entry_read($zip_entry, zip_entry_filesize($zip_entry));
						writeFile($buf, zip_entry_name($zip_entry), $destination, 1);

						zip_entry_close($zip_entry);
					}
				}
				zip_close($zip);
			}
		}
	} else {
		if (isAPhoto($uploadname)) {
			writeFile($filename, $uploadname, $destination);
		}
		else {
			error("not_image", $uploadname, __LINE__, $uploadmod, __FUNCTION__);
		}
	}
}

// $mode	-	0 = $file is a disk filename, just copy it over; 1 = $file is the binary contents of the image to write
function writeFile($file, $uploadname, $destination, $mode = 0) {
	global $uploadmod, $txt;
	global $album_dir;

	verifyPath($destination);

	// Make it absolute
	$finaldestination = "$album_dir/$destination";

	if (!is_writable($finaldestination)) {
		error("not_writable", $finaldestination, __LINE__, $uploadmod, __FUNCTION__);
	}

	// Now add the filename
	$finaldestination .= "/$uploadname";

	// Ok, it's a straight file move
	if (!$mode) {

		if (!is_readable($file)) {
			error("not_readable", $file, __LINE__, $uploadmod, __FUNCTION__);
		}

		// Move the file
		if (!move_uploaded_file($file, $finaldestination)) {
			error("upload", $file, __LINE__, $uploadmod, __FUNCTION__);
		}
	} else {
		// We have to write the contents of $file to $destination now
		if (!$handle = fopen($finaldestination, 'a')) {
			error("not_writable", $finaldestination, __LINE__, $uploadmod, __FUNCTION__);
			exit;
		}

		// Write $somecontent to our opened file.
		if (fwrite($handle, $file) === FALSE) {
			error("not_writable", $finaldestination, __LINE__, $uploadmod, __FUNCTION__);
			exit;
		}

		fclose($handle);

	}

	echo "<b>$uploadname</b> ".$txt['upload.success']." <b>$destination</b>.<br /><br />\n";
}

// Pick out the files and process them
function doUpload() {
	global $txt;
	global $script, $displaymod;

	echo "<h1>".$txt['upload.upload']."</h1>\n";

	// Nothing so far
	$filesprocessed = 0;

	// Combine all entered files
	foreach ($_FILES as $datafile) {
		if (is_array($datafile['name'])) {
			// Additional upload files
			$numfiles = count($datafile['name']);

			for ($loop = 0; $loop < $numfiles; $loop ++) {
				downloadFile($datafile['tmp_name'][$loop], $datafile['name'][$loop], $_POST['extraalbum'][$loop]);
				$filesprocessed ++;
			}
		} else {
			// Single upload file
			$file = downloadFile($datafile['tmp_name'], $datafile['name'], $_POST["album"]);
			$filesprocessed ++;
		}
	}
	echo $filesprocessed." ".$txt['upload.total']."<br /><br />\n";
	echo "<center><a href=\"$script\">".$txt['general.Return']."</a></center><br />\n";

	require_once ($displaymod);
	showFooter(0);
}
?>