<?php

/*
	$Id: thumb.php,v 1.13 2005/07/21 20:02:44 bobbitt Exp $

	album.php
	Written by Mike Bobbitt and DJ Houghton
	http://dev.bobbitt.ca/forums

	thumb.php
	Thumbnail Functions
*/

// Bail if this is not being called via album.php
if (!defined('album-php'))
	die('This file cannot be run directly.');

// Pick out CVS version and date for this file
$thumb_cvsver = '$Revision: 1.13 $';
$thumb_cvsdate = '$Date: 2005/07/21 20:02:44 $';
$thumb_cvsver = preg_replace("/.*Revision:\W(\d+\.\d+).*\$/", "$1", $thumb_cvsver);
$thumb_cvsdate = preg_replace("/.*Date:\s(.*)\s+\S/", "$1", $thumb_cvsdate);


/*
	showThumb($photo)

	$photo = Path to photo (relative to album root) to display the thumbnail for.

	Returns HTML to display the thumbnail for $thumbnail, based on the config.
*/
function showThumb($photo) {
	global $thumbmod;
	global $metadata, $install, $thumb_height, $thumb_width, $album;
	global $photo_icon, $album_dir, $album_web, $thumb_quality;
	global $obj;

	debug("Entering subroutine showThumb($photo);", 4, __LINE__, $thumbmod, __FUNCTION__);

	$thumb_html = "";

	$thumbdir = $obj[$photo]['metadir'];

	// Calculate the paths for the thumbnail images and build the
	// thumbnails if necessary...
	$thumb = $thumbdir."/".basename($photo);

	// Create metadata/thumb directory if doesn't exist
	if (!is_dir($thumbdir))
		mkdirs($thumbdir);

	debug("Looking for thumbnail at [$thumb]/[$thumbdir]", 2, __LINE__, $thumbmod, __FUNCTION__);

	// Create if required
	if (!file_exists($thumb)) {
		createThumb($photo, $thumb, $thumb_height, $thumb_width, $thumb_quality);
	} else {
		$thumb_html .= '<a href="';
		$thumb_html .= $obj[$photo]['url'];
		$thumb_html .= '">';
		$thumb_html .= "<img src=\"";
		$thumb_html .= "$metadata$photo";
		$thumb_html .= '" title="';
		$thumb_html .= $obj[$photo]['file'].'" border="0"/><br /></a>';
	}

	debug("Leaving subroutine showThumb($photo);", 4, __LINE__, $thumbmod, __FUNCTION__);

	return ($thumb_html);
}

/*
	$status = createThumb($file_name_src, $file_name_dest, $thumb_height, $thumb_width, $quality)

	$status = TRUE if thumb was created, otherwise FALSE
	$file_name_src = Source file to make a thumbnail of
	$file_name_dest = Destination for newly created thumbnail
	$thumb_height = Max height of thumbnail
	$thumb_width = Max width of thumbnail
	$quality = (Default: 75) Quality for new thumbnail

	This functions create resampled and resized images.
	If GD is not present, it simply exits.
	By GD it's impossible to create GIF images, so any gif images will be converted in JPEG type.
	ONLY JPEG, GIF, PNG IMAGES ARE SUPPORTED
	Adapted from code by Riccardo CiniC Bonciani: riboncia@inwind.it
*/
function createThumb($file_name_src, $file_name_dest, $thumb_height, $thumb_width, $quality = 75) {
	global $thumbmod;
	global $album_dir, $install;

	debug("Entering subroutine createThumb($file_name_src,$file_name_dest,$thumb_height,$thumb_width,$quality);", 4, __LINE__, $thumbmod, __FUNCTION__);

	if (!function_exists('gd_info')) {
		debug("GD is not installed!", 2, __LINE__, $thumbmod, __FUNCTION__);
		return FALSE;
	}

	$original = $album_dir."/".$file_name_src;
	$destination=$file_name_dest;

	if (file_exists($original) && isset ($file_name_dest)) {
		debug("Creating thumbnail for $original at $file_name_dest", 2, __LINE__, $thumbmod, __FUNCTION__);
		$est_src = pathinfo(strtolower($original));
		$est_dest = pathinfo(strtolower($file_name_dest));

		$size = getimagesize($original);
		$h = number_format($thumb_height, 0, ',', '');
		$w = number_format(($size[0] / $size[1]) * $thumb_height, 0, ',', '');

		if ($est_dest['extension'] == "gif" || $est_dest['extension'] == "jpg") {
			$file_name_dest = substr_replace($file_name_dest, 'jpg', -3);
			$dest = imagecreatetruecolor($w, $h);
			imageantialias($dest, TRUE);
		}
		elseif ($est_dest['extension'] == "png") {
			$dest = imagecreatetruecolor($w, $h);
			imageantialias($dest, TRUE);
		} else {
			return FALSE;
		}

		switch ($size[2]) {
			case 1 : //GIF
				$src = imagecreatefromgif($original);
				break;
			case 2 : //JPEG
				$src = imagecreatefromjpeg($original);
				break;
			case 3 : //PNG
				$src = imagecreatefrompng($original);
				break;
			default :
				return FALSE;
		}

		imagecopyresampled($dest, $src, 0, 0, 0, 0, $w, $h, $size[0], $size[1]);

		switch ($size[2]) {
			case 1 :
			case 2 :
				imagejpeg($dest, $destination, $quality);
				break;
			case 3 :
				imagepng($dest, $destination);
		}
		return TRUE;
	}

	debug("Leaving subroutine createThumb($file_name_src,$file_name_dest,$thumb_height,$thumb_width,$quality);", 4, __LINE__, $thumbmod, __FUNCTION__);

	return FALSE;
}
?>