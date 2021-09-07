#!/usr/bin/php
<?php

// Orgainze Photos
// Mike Bobbitt - Mike@Army.ca


// Organizes photos by renaming them based on EXIF headers
// to match the date/time they were taken.
// E.G.: IMG00623.jpg becomes /2007-07-12_19-26-42.jpg

// Where are we reading photos from
$sourcedir="/home/bobbitt/images/new";

// Where are we saving the renamed photos to
$destdir="/home/bobbitt/images/renamed";

// Do you want to keep the same directory structure or use YYYY-MM?
// 1: vaction2007/img.jpg changes to vacation2007/2007-07-12_19-26-42.jpg
// 0: vaction2007/img.jpg changes to 2007-01/2007-07-12_19-26-42.jpg
$keep_dirs = 1;

// Overwrite files if they already exist?
// I recommend running with overwrite off the first time to see what will happen!
$overwrite = 0;

// Valid image extensions (only images that have EXIF header info)
$imgexts = "(jpe?g|tiff?)";

// Valid movie extensions (regex)
$movieexts = "(avi|mpe?g|3gp)";

// Regular rexpression of filenames to exclude (thmb_* by default)
$exclude="(^..?$|^thmb_)";

// Show debug info?
$debug=0;

// Escaped version of $sourcedir
$esourcedir = preg_replace("/\//si", "\/", $sourcedir);

// Increase max execution time - this could take a while
ini_set('max_execution_time', 1200);

// Make sure we have a place to put stuff
makeADir($destdir);

$allitems=returseDirTree("/",true);

chdir($destdir);

if ($debug) {
	foreach ($allitems as $item) {
		echo "$item\n";
	}
}

exit(0);

function returseDirTree($dirarg, $recursive) {
	global $exclude;
	global $sourcedir;
	global $esourcedir;
	global $destdir;
	global $keep_dirs;
	global $lastfile, $lastdir;
	global $imgexts, $movieexts;
	global $overwrite;
	global $debug;

	$directory = $sourcedir . "/" . $dirarg;

	// Change to that dir
	chdir($directory);

	// Load all files in current dir
	$files = glob('*');

	$guessed = 0;

	foreach ($files as $file) {
		if (!preg_match("/$exclude/",$file)) {
			$reldir = preg_replace("/^$esourcedir\/*/", "", $directory);
			$reldir = trim($reldir, "\\\/");

			if ($debug) {
				echo "File: $file\n";
			}

			if (is_dir($directory. "/" . $file)) {
				if($recursive) {
					returseDirTree($reldir. "/" . $file, $recursive);
				}
				$file = $reldir . "/" . $file;
				$file = preg_replace("/\/+/si", "/", $file);
				$file = trim($file, "\\\/");
			} else {
				if ($reldir) {
					$file = $reldir . "/" . $file;
				}
				$file = preg_replace("/\/+/si", "/", $file);
	
				$stamp="";

				// is it a photo with EXIF data?
				if (preg_match("/\.$imgexts$/i", $file)) {
					$exif = exif_read_data($sourcedir . "/" . $file, 'ANY_TAG');

					if ($debug) {
						echo "\n\n===== $file =====\n";
						print_r($exif);
					}

					// Find a timestamp if you can
					if (isset($exif['DateTime'])) {
						$stamp = $exif['DateTime'];
					}
					if (isset($exif['DateTimeOriginal'])) {
						$stamp = $exif['DateTimeOriginal'];
					}
				}

				// Convert filenames for Cycorder: they are [unix timestamp].mov
				if (preg_match("/(\d+)\.mov/i", $file)) {
					$filename = preg_replace("/(.*)\..*/","\$1",$file);
					$stamp = date("Y-m-d_H-i-s", $filename);
				}

				// Name movies to the previous timpestamp
				if (preg_match("/\.$movieexts$/i", $file)) {
					$stamp = $lastfile;

					// Prevent duplicates
					$guessed++;
				} else {
					$guessed = 0;
				}

				// Handle files that had no exif header (usually not images)
				if (!$stamp) {
					if ($lastdir) {
						$cleandir = $lastdir;
					} else {
						$cleandir = preg_replace("/(.*)\/.*/","\$1",$file);
					}

					// Did we miss the match?
					if ($cleandir == $file) {
						$cleandir = "";
					}
					$cleanstamp = preg_replace("/(.*\/)?(.*)\..*$/","\$2",$file);
				}
				else
				{
					$patterns=array("/:/","/\//","/ /");
					$replace=array("-","-","_");
					$cleanstamp=preg_replace($patterns,$replace,$stamp);
					$cleandir=preg_replace("/(\d{4}-\d{2}).*/","\$1",$cleanstamp);
				}

				// Are we keeping the old dir names?
				if ($keep_dirs) {
					$cleandir = preg_replace("/(.*)\/.*/","\$1",$file);

					// Did we miss the match?
					if ($cleandir == $file) {
						$cleandir = "";
					}
				}

				// Keep track of the last known timestamp for movies
				$lastfile = $cleanstamp;

				// Is this the 2nd (or more) movie in a row?
				if ($guessed) {
					$cleanstamp .= chr($guessed + 96);
				}

				// Pick up the last directory too, so non-image files can go in the same place
				$lastdir = $cleandir;

				// Pull off the file's extension
				$ext=preg_replace("/.*\.(.*)/","\$1",$file);

				// Make the target directory, if it doesn't exist
				makeADir($destdir . "/" . $cleandir);

				$newfile = "";
				if ($cleandir) {
					$newfile .= $cleandir . "/";
				}
				$newfile .= $cleanstamp . "." . $ext;

				$destfile = $destdir . "/" . $newfile;

				// Are we going to overwrite a file?
				if (file_exists($destfile)) {
					if ($overwrite) {
						echo "OVERWRITING: ";
					} else {
						$tempfile = $destdir . "/";
						if ($cleandir) {
							$tempfile .= $cleandir . "/";
						}
						$tempfile .= $cleanstamp;
						$tag = 97;
						while (file_exists($tempfile . chr($tag) . "." . $ext)) {
							$tag++;
						}
						$destfile = $tempfile . chr($tag) . "." . $ext;
						$newfile = "";
						if ($cleandir) {
							$newfile .= $cleandir . "/";
						}
						$newfile .= $cleanstamp. chr($tag) . "." . $ext;
					}
				}
				rename($sourcedir . "/" . $file, $destfile) or die("Could not move $file to $destfile.");
				echo "$file ---> $newfile\n";

				// Ok, now set the proper attributes on the new file
				chown($destfile, "apache");
				chgrp($destfile, "bobbitt"); 
				chmod($destfile, 0644);
			}
		}
	}
}

// Check to see if the dir exists, if not create it
function makeADir($dir)
{
	global $debug;

	if (!is_dir($dir)) {
		if ($debug) {
			echo "Making directory: $dir\n";
		}
		mkdir($dir, 0755, true) or die("Could not make dir [$dir]");
		chown($dir, "apache");
		chgrp($dir, "bobbitt"); 
		chmod($dir, 0775);
	}
}

?>
