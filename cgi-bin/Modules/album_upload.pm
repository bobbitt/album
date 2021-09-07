#!/usr/bin/perl --
# $Id: album_upload.pm,v 1.3 2004/09/13 15:28:10 bobbitt Exp $

######################## START OF POD ########################

=head1 NAME

show_login.pm - show login functions for album.pl.

=head1 INFORMATION

Author: J.J.Frister, taken from album.pl Mike Bobbitt (Mike@Bobbitt.ca), Cipher Logic Canada Inc.

For updates, instructions and examples see http://perl.bobbitt.ca/forums on the web.

=head1 LICENSE

This program is © 1999-2004 Cipher Logic Canada Inc. & © 2004 fristersoft. All Rights Reserved.

As long as you leave this POD section and my contact info above in tact, feel free to use this as you see fit. You can pretty much do anything with this script except resell it. :)

If you come up with any good modifications to it, please let me know. I'd love to fold your mod into the public version (with credit, of course).

Good luck!

=head1 SUBROUTINES

=cut
######################## END OF POD ########################


######################## START OF SUBROUTINES ########################

##########################################################################

=head3 uploadPhoto()

 uploadPhoto();

Called when a user wants to upload a photo. Shows the form and handles the file transfer.

=cut
sub uploadPhoto
{
my $myobject;
my $temp;

	debug("Entering subroutine: uploadPhoto()",4,__LINE__,$::upload_module);

	openDescfile("$::album_dir/");
	getDescription($::rootalbumname);
	close(DESC);

	if (!$::shortdesc)
	{
		$::shortdesc=$::S{36};
	}

	if (!$::allow_uploads)
	{
		# print the HTML HEADER
		print <<HTML;
<head>
HTML

		if ($::style_sheet)
		{
			print <<HTML;
<link rel="stylesheet" type="text/css" href="$::style_sheet">
HTML
		}
		print <<HTML;
<h1>$::S{37}</h1>
<br />
<br />
$::S{38} <a href="$::albumprog">$::shortdesc</a>.
HTML
		exit(0);
	}

	# same as debug=3
	if ($::debug gt 2)
	{
		print "Displaying all form values:<br /><br />";
		my @all=$form->param;
		my $name;
		foreach $name (@all)
		{
			print "<pre>Form Data: $name ->", $form->param($name),"</pre><br />\n";
		}
	}

	# Log the user in
	if ($form->param('userid'))
	{
		$::username=$form->param('userid');
	}
	if ($form->param('upload_password'))
	{
		$::password=$form->param('upload_password');
	}

	$myobject=buildTemplate();

	if ($form->param('upload_file1'))
	{

		debug("A photo is being uploaded.",2,__LINE__,$::upload_module);

		my $em='';

		# import the paramets into a series of variables in 'q' namespace
		$form->import_names('q');
		#  check if the necessary fields are empty or not
		$em .= "<br />$::S{39}<br />" if !$q::userid;
		if (!$q::upload_password && $::authentication_type)
		{
			$em .= "$::S{40}<br />"
		}
		$em .= "$::S{41}<br />" if !$q::upload_file1;

		print $myobject;

		if ($em)
		{
			error(__LINE__,"upload_error",$em,$::upload_module);
		}

		if (!Authenticate($::block_ubb_junior_members_from_uploading))
		{
			error(__LINE__,"upload_error","$::S{42} $q::userid",$::upload_module);
		}

		# Check to see if the user is a guest
		if (isGuest())
		{
			error(__LINE__,"upload_error","$::S{298}",$::upload_module);
		}

		# now upload files
		for($temp=1;$temp<=$::concurrent_uploads;$temp++)
		{
			if ($form->param("upload_file$temp"))
			{
				fileUpload($temp);
			}
		}
	}
	else
	{
		debug("No photo is being uploaded.",2,__LINE__,$::upload_module);

		print $myobject;
	}

	debug("Leaving subroutine: uploadPhoto()",4,__LINE__,$::upload_module);

}


##########################################################################

=head3 showUploadForm()

 $upload_form=showUploadForm();

 $upload_form - Variable to return completed upload form into.

Returns the upload form, so it can be substituted into the template.

=cut
sub showUploadForm()
{
my $upload_form;
my $temp;
my $spacer;

	debug("Entering subroutine: showUploadForm()",4,__LINE__,$::upload_module);

	$upload_form.="<table>\n";

	# userid field
	$upload_form.="<tr>\n";
	$upload_form.="<td align=\"right\">\n";

	# Display name/userid depending on if we're using anonymous uploads or not
	if ($::authentication_type)
	{
		$upload_form.="$::S{55}\n";
	}
	else
	{
		$upload_form.="$::S{56}\n";
	}
	$upload_form.="</td>\n";
	$upload_form.="<td>\n";

	# Get cookie info, if present
#	$::username=$::password="";

	debug("Username/Pass before cookieLogin: $::username/$::password",4,__LINE__,$::upload_module);

	cookieLogin();

	debug("Username/Pass after cookieLogin: $::username/$::password",4,__LINE__,$::upload_module);

	$upload_form.="<input type=\"text\" name=\"userid\" value=\"$::username\" size=\"20\" />\n";
	$upload_form.="<input type=\"hidden\" name=\"username\" value=\"$::username\" size=\"20\" />\n";
	$upload_form.=passVars(1);
	$upload_form.="</td>\n";
	$upload_form.="</tr>\n";

	# Don't display password field if we're using anonymous uploads
	if ($::authentication_type)
	{
		# password field
		$upload_form.="<tr>\n";
		$upload_form.="<td align=\"right\">\n";
		$upload_form.="$::S{57}\n";
		$upload_form.="</td>\n";
		$upload_form.="<td>\n";
		$upload_form.="<input type=\"password\" name=\"upload_password\" value=\"$::password\" size=\"20\" />\n";
		$upload_form.="<input type=\"hidden\" name=\"password\" value=\"$::password\" size=\"20\" />\n";
		$upload_form.="</td>\n";
		$upload_form.="</tr>\n";
	}

	# Set indent spacer
	if ($::concurrent_uploads gt 1)
	{
		$spacer="&nbsp;&nbsp;&nbsp;";
	}

	# Get Category List, by recursively searching all dirs (stored in $::object)
	if (!$::per_member_upload || isAdmin())
	{
		debug("About to call the recuriveScan($::album_dir)",2,__LINE__,$::upload_module);

		$::doing_upload=1;
		recursiveScan($::album_dir);
		$::doing_upload=0;
	}

	debug("Returned from the recuriveScan($::album_dir)",2,__LINE__,$::upload_module);

	for($temp=1;$temp<=$::concurrent_uploads;$temp++)
	{
		debug("Iterating in upload file loop #$temp.",3,__LINE__,$::upload_module);

		# file field
		$upload_form.="<tr>\n";
		$upload_form.="<td align=\"right\">\n";
		$upload_form.="$::S{58}$temp$::S{221}\n";
		$upload_form.="</td>\n";
		$upload_form.="<td>\n";
		$upload_form.="$spacer<input type=\"file\" name=\"upload_file$temp\" size=\"30\" maxlength=\"80\" />";
		$upload_form.="</td>\n";
		$upload_form.="</tr>\n";

		# Show all available albums
		if (!$::per_member_upload || isAdmin())
		{
			$upload_form.=<<HTML;
<tr>
<td align="right">
$::S{59}</td><td>
$spacer<select name="category$temp">
HTML

		my $numlines=scalar(split("\n",$::object));

		# If there is no default album and multiple albums, make the user select one
		if ($::object!~/selected/i && $numlines > 2)
		{
			$upload_form.=<<HTML;
<option value="$S{317}" selected>$S{317}</option>
HTML
		}


			$upload_form.=<<HTML;
$::object
</select>
</td></tr>
HTML
		}
		# Use "per member" upload directories
		else
		{
			$upload_form.="<input type=\"hidden\" name=\"category$temp\" value=\"per_member_upload\" />"
		}

		$upload_form.=<<HTML;
<tr>
<td align="right">
$::S{60}</td><td>
$spacer<input type="text" name="title$temp" size="30" maxlength="40" />
</td></tr>
<tr>
<td align="right">
$::S{61}
</td><td>
$spacer<textarea rows="$::enterdesc_rows" name="description$temp" cols="$::enterdesc_cols">
</textarea>
HTML
		if ($::authentication_type)
		{
			$upload_form.=<<HTML;
</td>
</tr>
<tr>
<td align="right">$S{340}
</td><td>
HTML
		}
                if($::authentication_type eq 5)
		{
			$upload_form.=<<HTML;
$spacer<select size="1" name="view_level$temp"><option selected>$S{341}</option><option>$S{342}</option><option>$S{343}</option><option>$S{299}</option></select>
HTML
		}
		if($::authentication_type eq 1 || $::authentication_type eq 3 || $::authentication_type eq 4)
		{
			$upload_form.=<<HTML;
$spacer<select size="1" name="view_level$temp"><option selected>$S{341}</option><option>$S{345}</option><option>$S{299}</option></select>
HTML
		}
		if($::authentication_type eq 2)
		{
			$upload_form.=<<HTML;
$spacer<select size="1" name="view_level$temp"><option selected>$S{341}</option><option>$S{345}</option><option>$S{346}</option><option>$S{299}</option></select>
HTML
		}
		$upload_form.=<<HTML;
<hr />
</td></tr>
HTML
	}

	$upload_form.="<tr>\n";
	$upload_form.="<td colspan=\"2\" align=\"center\">\n";
	$upload_form.="<input type=\"submit\" name=\".submit\" value=\"$::S{62}\" class=\"button\" />";
	$upload_form.="</td>\n";
	$upload_form.="</tr>\n";
	$upload_form.=<<HTML;
<input type="hidden" name="function" value="$::upload" />
HTML
	if ($::debug)
	{
		$upload_form.=<<HTML;
<input type="hidden" name="$::debug_code" value="$::debug" />
HTML
}

	$upload_form.="</table>\n";

	debug("Leaving subroutine: showUploadForm()",4,__LINE__,$::upload_module);

	return($upload_form);
}


##########################################################################

=head3 fileUpload()

 fileUpload($count);

 $count - The file number to process (must be between 1 and $::concurrent_uploads).

Handles the nitty gritty file upload stuff. Called once for each file to upload.

=cut
sub fileUpload
{
my $count=shift;
my $bytes_read=0;
my $size='';
my $buff='';
my $start_time;
my $time_taken;
my $filename='';
my $write_file='';
my $user_quota;
my $system_call;
my $height;
my $width;
my $height2;
my $width2;
my $filepath;
my $photo_title;
my $photo_desc;
my $photo_level;
my $category;
my $temp;
my $logname;
my $output;
my $dirtomk;

$temp=$form->param("upload_file$count");
eval("\$filepath=\$temp");
$temp=$form->param("title$count");
eval("\$photo_title=\$temp");
$temp=$form->param("description$count");
eval("\$photo_desc=\$temp");
$temp=$form->param("view_level$count");
eval("\$photo_level=\$temp");
$temp=$form->param("category$count");
eval("\$category=\$temp");
my $errflag=0;

	debug("Entering subroutine: fileUpload($count);",4,__LINE__,$::upload_module);

	debug("\$filepath: $filepath",3,__LINE__,$::upload_module);
	debug("\$category: $category",3,__LINE__,$::upload_module);
	debug("\$photo_title: $photo_title",3,__LINE__,$::upload_module);
	debug("\$photo_desc: $photo_desc",3,__LINE__,$::upload_module);
	debug("\$photo_level: $photo_level",3,__LINE__,$::upload_module);

	require $::display_module;

	if ($filepath =~ /([^\/\\]+)$/)
	{
		$filename="$1";
	}
	else
	{
		$filename="$filepath";
	}
	# Convert spaces to _'s and strip out any prohibited charactes in the filename
	$filename=~s/\s+/_/g;
	$filename=~tr/a-zA-Z0-9_./ /c;
	$filename=~s/\s+//g;

	# Check to see if the user forgot to select an album
	if ($category eq $S{317})
	{
		print javaAlert("$::S{318}");
		return;
	}

	# Is $::per_member_upload on? If so, change the category, and create the directory if it's not already there.
	if ($category eq "per_member_upload")
	{
		# UBB categories are user numbers, all others are user names
		if ($::authentication_type eq 2)
		{
			$category=$::usernumber;
		}
		else
		{
			$category=$::username;
		}

		chomp($category);

		# Fix provided by PattayaPete (junk@freelancerbar.com)
		$category=~s/^\s*(\S+)\s*$/$1/g;

		my $tempdir=$::album_dir;

		if ($::member_subdir)
		{
			$tempdir="$::album_dir/$::member_subdir";
			chomp($tempdir);
			debug("Using \$::member_subdir, so target directory is now $tempdir",2,__LINE__,$::upload_module);
		}

		$dirtomk="$tempdir/$category";
		chomp($dirtomk);

		# Create directory for user, if not already present
		if (!(-d $dirtomk))
		{
			require $::admin_module;
			if (createAlbum($::member_subdir,$category,$::displayname,"$::S{201} $::displayname$::S{226}",$::loggedin,$::mem_level,1))
			{
				print javaAlert("$::S{28} $dirtomk");
				return;
			}
		}
		else
		{
			# Get quota by doing a scan
			recursiveScan($dirtomk);
		}

		# Fix up the category now so things work correctly from here on in...
		$category=$::member_subdir."/".$category;

	}

	# Check for any fooling around
	if (!(-d "$::album_dir/$category"))
	{
		error(__LINE__,"sanity","$::S{63} ($::album_dir/$category)",$::upload_module);
	}

	$write_file="$::album_dir/$category"."/"."$filename";

	debug("Filename=$filename",2,__LINE__,$::upload_module);
	debug("Writefile=$write_file [$::member_subdir]",2,__LINE__,$::upload_module);

	debug("Checking to see if $write_file is a photo.",2,__LINE__,$::upload_module);

	$::object=0;

	# Check file type
	if (!(isAPhotoOrJp2($write_file) || (isAMovie($write_file) && $::movie_upload)))
	{
		print javaAlert("$::S{25} $::S{64} $filename $::S{65}");
		$errflag=1;
		return;
	}

	# Don't overwrite, if not allowed
	if (!$::upload_overwrite)
	{
		if (-e $write_file)
		{
			print javaAlert("$::S{25} $::S{46} $filename $::S{66}");
			$errflag=1;
			return;
		}
	}

	# Open file for writing
	if (!open(WFD,">$write_file"))
	{
		print javaAlert("$::S{25} $::S{67} $write_file $::S{68}");
		return;
	}

	$start_time=time();
	debug("Starting upload of [$filepath] into [$write_file] at time $start_time...",2,__LINE__,$::upload_module);
	while ($bytes_read=read($filepath,$buff,2096))
	{
		$size+=$bytes_read;
		debug("Uploading $size bytes so far...",3,__LINE__,$::upload_module);
		debug("Buffer contains [$buff]",4,__LINE__,$::upload_module);
		binmode WFD;
		print WFD $buff;
	}

	debug("size=$size",2,__LINE__,$::upload_module);

	close(WFD);

	# Check to see if file exceeds set limit for photos
	if (isAPhotoOrJp2($filepath))
	{
		if ($size>($::upload_size_limit*1024) && (isAdmin() ne 1))
		{
			unlink($write_file);
			print javaAlert("$::S{25} $::S{69} $::upload_size_limit $::S{70}.");
			$errflag=1;
			return;
		}
	}
	else
	{
		if ($size>($::movie_upload_size_limit*1024) && (isAdmin() ne 1))
		{
			unlink($write_file);
			print javaAlert("$::S{307} $::S{69} $::movie_upload_size_limit $::S{70}.");
			$errflag=1;
			return;
		}
	}


	# Check to see if the user has exceeded their quota
	$user_quota=$::temp_quota_total+$size;
	debug("User's current used quota is $user_quota. They are allowed $::quota Kb.",2,__LINE__,$::upload_module);

	if ($::per_member_upload && $::quota && ($user_quota > ($::quota*1024)) && (isAdmin() ne 1))
	{
		unlink($write_file);
		print javaAlert("$::S{71} $::quota $::S{70} $::S{72}");
		$errflag=1;
		return;
	}

	$time_taken=(stat $write_file)[7];

	# Check to see if file is greater than size zero
	if ($time_taken <= 0)
	{
		unlink($write_file);
		print javaAlert("$::S{73} $filename $::S{75}$::S{74} $time_taken$::S{76}");
		$errflag=1;
		return;
	}
	else
	{
		print javaAlert("$::S{46} $filename $::S{77} $size $::S{78}");

		$time_taken=time()-$start_time;

		chomp($::displayname);

		# Update the description for this new photo
		require $::ratings_module;
		updateDesc($filename,"$::album_dir/$category/",$photo_title,"$photo_desc<br /><br /><small><small>$::S{79} $::displayname$::S{226}</small></small>",$::loggedin,translateLevel($photo_level));

		debug("updateDesc($filename,\"$::album_dir/$category/\",$photo_title,\"$photo_desc<br /><br /><small><small>$::S{79} $::displayname$::S{226}</small></small>\",$::loggedin,$photo_level);",3,__LINE__,$::upload_module);

		$time_taken=0;

		# Set full filename
		$filepath="$::album_dir/$category/$filename";

		# If desired, resize the photo
		if ($::pic_resize)
		{
			debug("\$::pic_resize=$::pic_resize",3,__LINE__,$::upload_module);

			# Is pic_resize a file size? (does it end in "k"?)
			if ($::pic_resize=~/\d+k$/i)
			{
				$time_taken=2;
			}
			# Only resize "large" pics
			elsif (!$::always_pic_resize)
			{
				($height,$width)=getPhotoDimensions($filepath);

				# Pick out pic_resize height/width
				$height2=$width2=$::pic_resize;
				$width2=~s/([^x]*)x([^x]*)/$1/;
				$height2=~s/([^x]*)x([^x]*)/$2/;

				debug("Preferred image size is as follows: $width2 wide by $height2 high.",2,__LINE__,$::upload_module);
				debug("$filename size is as follows: $width wide by $height high.",2,__LINE__,$::upload_module);

				# Compare size to requested size
				if ((($height > $height2) && $height2) || (($width > $width2) && $width2))
				{
					# The uploaded pic is bigger on at least one dimension, so resize is required
					$time_taken=1;
					debug("Picture is big, and needs to be scaled down.",2,__LINE__,$::upload_module);
				}
			}
			else
			{
				$time_taken=1;
			}

			# Pic is being resized
			if ($time_taken)
			{
				$::thumb_quality="";
				$::thumb_width="";
				$start_time=genThumb($filepath,$filepath,$time_taken);
			}
		}

		# Some extra processing, if the file was uploaded properly
		if (!$errflag)
		{
		my $sysdate;

			# Log upload
			if ($::upload_logfile)
			{
				if ($::displayname)
				{
					$logname=$::displayname;
				}
				else
				{
					$logname=$::username;
				}

				$sysdate=setDate(time,1);

				open(UPLOADLOG,">>$::upload_logfile") || error(__LINE__,"cant_append","$::upload_logfile: $!",$::upload_module);
				print UPLOADLOG "$sysdate	$ENV{'REMOTE_ADDR'}	$logname	$category/$filename\n";
				close(UPLOADLOG);
			}

			# If there's an extra upload command, run it now
			if ($::postupload)
			{
			my $tempobject="";
			my $tempcommand=$::postupload;

				# Convert ####OBJECT#### into the photo's full path
				$tempcommand=~s/####OBJECT####/"$filepath"/g;

				$tempcommand=substituteData($tempcommand);

				$tempobject="$filepath.$$";

				if (!-e $tempobject)
				{
					$tempcommand.=" \"$tempobject\"";
				}

				debug("Running postupload task: $tempcommand",2,__LINE__,$::upload_module);

				$output=`$tempcommand 2>&1`;
				debug("POSTUPLOAD RETURNED: $output",2,__LINE__,$::upload_module);

				if ($output)
				{
					print "$::S{18} $output<br /><br />";
				}

				# If an object was created, replace the original with the new
				if (-e $tempobject)
				{
					unlink($filepath);

					if (!rename($tempobject,$filepath))
					{
						print "$::S{150} $tempobject $::S{219}";
					}
				}
				else
				{
					debug("$tempobject not found (this may not be a problem)",3,__LINE__,$::upload_module);
				}
			}
		}
	}
	debug("Leaving subroutine: fileUpload($count);",4,__LINE__,$::upload_module);
}


##########################################################################
######################## END OF SUBROUTINES ########################

######################## END OF FILE ########################

1;