#!/usr/bin/perl --
# $Id: album_admin.pm,v 1.5 2004/09/13 15:28:10 bobbitt Exp $

######################## START OF POD ########################

=head1 NAME

album_admin.pm - Admin functions for album.pl.

=head1 INFORMATION

Author: Mike Bobbitt (Mike@Bobbitt.ca), Cipher Logic Canada Inc.

For updates, instructions and examples see http://perl.bobbitt.ca/forums on the web.

=head1 LICENSE

This program is © 1999-2004 Cipher Logic Canada Inc. All Rights Reserved.

As long as you leave this POD section and my contact info above in tact, feel free to use this as you see fit. You can pretty much do anything with this script except resell it. :)

If you come up with any good modifications to it, please let me know. I'd love to fold your mod into the public version (with credit, of course).

Good luck!

=head1 SUBROUTINES

=cut
######################## END OF POD ########################


######################## START OF SUBROUTINES ########################

##########################################################################

=head3 showAdminMenu()

 $admin_menu=showAdminMenu($style);

 $style - 0 = Long menu (titles, all options - used at the top of photo/album pages); 1 = Short menu (no title, some options - used under thumbnails)

 $admin_menu - Variable to return completed Administration menu into.

Returns the Administration menu, so it can be substituted into the template.

=cut
sub showAdminMenu
{
my $admin_menu;
my $isadmin;
my $stuff="";
my $link_stuff="";
my $style=shift;

	debug("Entering subroutine: showAdminMenu($style)",4,__LINE__,$::admin_module);

	$admin_menu="";

	debug("\$::owner = $::owner",2,__LINE__,$::admin_module);
	debug("\$::loggedin = $::loggedin",2,__LINE__,$::admin_module);
	debug("\$::default_admins = $::default_admins",2,__LINE__,$::admin_module);
	debug("\$::textmenu = $::textmenu",2,__LINE__,$::admin_module);

	$isadmin=isAdmin();

	$stuff=$::relpath;
	$link_stuff=$::link_relpath;

	# This shouldn't be required. passVars should load an album tag in, but it doesn't...
	$stuff.=$::webdelim;
	$link_stuff.=$::webdelim;

	if (isAPhotoOrJp2($::relpath) || isAMovie($::relpath))
	{
		$stuff.="photo";
	}
	else
	{
		$stuff.="album";
	}
	$link_stuff.="url";
	$stuff.="=$::relpath";
	$link_stuff.="=$::link_relpath";
	$stuff.=passVars(0);
	$link_stuff.=passVars(0);
	$stuff.="\" class=\"adminlink\">";
	$link_stuff.="\" class=\"adminlink\">";

	# Only proceed if allowed... That means: If we're printing an "abridged" menu, and the guy logged in owns the current object, or is a default admin and is logged in, or the admin function is being used.
	if ($isadmin)
	{
		debug("We're authorized to display the admin menu (\$isadmin=$isadmin)...",2,__LINE__,$::admin_module);

		# Print the short menu. The one that goes under the thumbnails.
		if ($style)
		{
			$admin_menu.="<br /><small>";

			# Edit
			if (($::allow_edit && $isadmin eq 2) || ($isadmin eq 1))
			{
				$admin_menu.="<a href=\"$::albumprog?";
				if ($::slide_timer)
				{
					$admin_menu.="slideshow=-1&";
				}
				$admin_menu.="editobject=";
				$admin_menu.="$stuff";
				if ($::textmenu)
				{
					$admin_menu.=$::S{43};
				}
				else
				{
					$admin_menu.="<img class=\"button\" src=\"$::edit_button\" alt=\"$::S{43}\" />";
				}
				$admin_menu.="</a> ";
			}

			if ($::textmenu && (($::allow_edit && $::allow_edit && $isadmin eq 2) || ($isadmin eq 1)))
			{
				$admin_menu.=" $::S{98} ";
			}

			# Delete
			if (($::allow_delete && $isadmin eq 2) || ($isadmin eq 1))
			{
				$admin_menu.="<a href=\"$::albumprog?deleteobject=";
				if ($::link_relpath)
				{
					$admin_menu.="$link_stuff";
				}
				else
				{
					$admin_menu.="$stuff";
				}
				if ($::textmenu)
				{
					$admin_menu.=$::S{44};
				}
				else
				{
					$admin_menu.="<img class=\"button\" src=\"$::delete_button\" alt=\"$::S{44}\" />";
				}
				$admin_menu.="</a> ";
			}

			if ($::textmenu && $isadmin)
			{
				$admin_menu.=" $::S{98} ";
			}

			# Move
			if (($::allow_move && $isadmin eq 2) || ($isadmin eq 1))
			{
				$admin_menu.="<a href=\"$::albumprog?moveobject=";
				if ($::link_relpath)
				{
					$admin_menu.="$link_stuff";
				}
				else
				{
					$admin_menu.="$stuff";
				}
				if ($::textmenu)
				{
					$admin_menu.=$::S{45};
				}
				else
				{
					$admin_menu.="<img class=\"button\" src=\"$::move_button\" alt=\"$::S{45}\" />";
				}
				$admin_menu.="</a> ";
			}

			if ($::textmenu && isAPhotoOrJp2($::relpath) && $isadmin)
			{
				$admin_menu.=" $::S{98} ";
			}

			# Link
			if (($::allow_link && $isadmin eq 2) || ($isadmin eq 1))
			{
				$admin_menu.="<a href=\"$::albumprog?linkobject=";
				$admin_menu.="$stuff";
				if ($::textmenu)
				{
					$admin_menu.=$::S{308};
				}
				else
				{
					$admin_menu.="<img class=\"button\" src=\"$::link_button\" alt=\"$::S{308}\" />";
				}
				$admin_menu.="</a>";
			}

			$admin_menu.="</small>";
		}
		else
		# Print the extended menu. The one that goes at the top of a page.
		{
			$admin_menu.="<u><b>";

			if ($::photo)
			{
				$admin_menu.="$::S{46}";
			}
			if ($::album)
			{
				$admin_menu.="$::S{47}";
			}

			$admin_menu.=" $::S{48}</b></u><br />";

			# Album Admin Menu
			if ($::album)
			{
				# Create album
				$admin_menu.="<a href=\"$::albumprog?admincreate=1".$::webdelim."album=";
				if ($::goback)
				{
					$admin_menu.="$::goback/";
				}
				if ($::shortalbum ne $::rootalbumname)
				{
					$admin_menu.="$::shortalbum";
				}
				$admin_menu.=passVars(0);
				$admin_menu.="\" class=\"adminlink\">";
				if ($::textmenu)
				{
					$admin_menu.=$::S{246};
				}
				else
				{
					$admin_menu.="<img class=\"button\" src=\"$::create_button\" alt=\"$::S{246}\" />";
				}
				$admin_menu.="</a> ";

				# For regular admins only
				if ($isadmin eq 1)
				{
					if ($::textmenu)
					{
						$admin_menu.=" $::S{98} ";
					}

					# Update titles and descriptions
					$admin_menu.="<a href=\"$::albumprog?album=";
					if ($::goback)
					{
						$admin_menu.="$::goback/";
					}
					if ($::shortalbum ne $::rootalbumname)
					{
						$admin_menu.="$::shortalbum";
					}
					$admin_menu.=$::webdelim."function=$::enter_desc";
					$admin_menu.=passVars(0);
					$admin_menu.="\" class=\"adminlink\">";
					if ($::textmenu)
					{
						$admin_menu.=$::S{247};
					}
					else
					{
						$admin_menu.="<img class=\"button\" src=\"$::titles_button\" alt=\"$::S{247}\" />";
					}
					$admin_menu.="</a>";
				}

				if ($::textmenu)
				{
					$admin_menu.=" $::S{98} ";
				}

				# Upload
				if ($::allow_uploads)
				{
					$admin_menu.=" <a href=\"$::albumprog?function=$::upload";
					$admin_menu.=passVars(0);
					$admin_menu.="\" class=\"adminlink\">";
					if ($::textmenu)
					{
						$admin_menu.=$::S{248};
					}
					else
					{
						$admin_menu.="<img class=\"button\" src=\"$::adminupload_button\" alt=\"$::S{248}\" />";
					}
					$admin_menu.="</a>";
				}

				# For regular admins only
				if ($isadmin eq 1)
				{
					if ($::textmenu)
					{
						$admin_menu.=" $::S{98} ";
					}

					# Configuration management
					$admin_menu.=" <a href=\"$::albumprog?function=$::config";
					$admin_menu.=passVars(0);
					$admin_menu.="\" class=\"adminlink\">";
					if ($::textmenu)
					{
						$admin_menu.=$::S{249};
					}
					else
					{
						$admin_menu.="<img class=\"button\" src=\"$::config_button\" alt=\"$::S{249}\" />";
					}
					$admin_menu.="</a>";

					if ($::textmenu)
					{
						$admin_menu.=" $::S{98} ";
					}

					# Check for updates
					$admin_menu.=" <a href=\"$::albumprog?function=$::checkupdate";
					$admin_menu.=passVars(0);
					$admin_menu.="\" class=\"adminlink\">";
					if ($::textmenu)
					{
						$admin_menu.=$::S{250};
					}
					else
					{
						$admin_menu.="<img class=\"button\" src=\"$::updates_button\" alt=\"$::S{250}\" />";
					}
					$admin_menu.="</a>";
				}

				# Set Album Thumbnail
				if ($::album ne $::album_dir)
				{

					if ($::textmenu)
					{
						$admin_menu.=" $::S{98} ";
					}

					$admin_menu.=" <a href=\"$::albumprog?album=";
					if ($::goback)
					{
						$admin_menu.="$::goback/";
					}
					if ($::shortalbum ne $::rootalbumname)
					{
						$admin_menu.="$::shortalbum";
					}
					$admin_menu.=passVars(0);
					if ($::page)
					{
						$admin_menu.=$::webdelim."page=$::page";
					}
					$admin_menu.=$::webdelim."pickthumb=1\" class=\"adminlink\">";
					if ($::textmenu)
					{
						$admin_menu.=$::S{251};
					}
					else
					{
						$admin_menu.="<img class=\"button\" src=\"$::thumb_button\" alt=\"$::S{251}\" />";
					}
					$admin_menu.="</a>";
				}
			}

			# Photo Admin Menu
			if ($::photo)
			{
				# Edit
				$admin_menu.="<a href=\"$::albumprog?";
				if ($::slide_timer)
				{
					$admin_menu.="slideshow=-1".$::webdelim;
				}
				$admin_menu.="editobject=".webifyLinks($::photo).$::webdelim."photo=".webifyLinks($::photo);
				$admin_menu.=passVars(0);
				$admin_menu.="\" class=\"adminlink\">";
				if ($::textmenu)
				{
					$admin_menu.=$::S{43};
				}
				else
				{
					$admin_menu.="<img class=\"button\" src=\"$::edit_button\" alt=\"$::S{43}\" />";
				}
				$admin_menu.="</a>";

				if ($::textmenu)
				{
					$admin_menu.=" $::S{98} ";
				}

				# Delete
				$admin_menu.=" <a href=\"$::albumprog?deleteobject=".webifyLinks($::photo).$::webdelim."album=".webifyLinks($::goback);
				$admin_menu.=passVars(0);
				$admin_menu.="\" class=\"adminlink\">";
				if ($::textmenu)
				{
					$admin_menu.=$::S{44};
				}
				else
				{
					$admin_menu.="<img class=\"button\" src=\"$::delete_button\" alt=\"$::S{44}\" />";
				}
				$admin_menu.="</a>";

				if ($::textmenu)
				{
					$admin_menu.=" $::S{98} ";
				}

				# Move
				if (($::allow_move && $isadmin eq 2) || ($isadmin eq 1))
				{
					# Move
					$admin_menu.=" <a href=\"$::albumprog?moveobject=".webifyLinks($::photo).$::webdelim."album=".webifyLinks($::goback);
					$admin_menu.=passVars(0);
					$admin_menu.="\" class=\"adminlink\">";
					if ($::textmenu)
					{
						$admin_menu.=$::S{45};
					}
					else
					{
						$admin_menu.="<img class=\"button\" src=\"$::move_button\" alt=\"$::S{45}\" />";
					}
					$admin_menu.="</a>";
				}

				if ($::textmenu)
				{
					$admin_menu.=" $::S{98} ";
				}

				# Link
				if (($::allow_link && $isadmin eq 2) || $isadmin eq 1)
				{
					# Link
					$admin_menu.=" <a href=\"$::albumprog?linkobject=".webifyLinks($::photo).$::webdelim."album=".webifyLinks($::goback);
					$admin_menu.=passVars(0);
					$admin_menu.="\" class=\"adminlink\">";
					if ($::textmenu)
					{
						$admin_menu.=$::S{308};
					}
					else
					{
						$admin_menu.="<img class=\"button\" src=\"$::link_button\" alt=\"$::S{308}\" />";
					}
					$admin_menu.="</a>";
				}
			}
		}
	}
	else
	{
		debug("NOT authorized to display admin menu.",2,__LINE__,$::admin_module);
	}


	debug("Leaving subroutine: showAdminMenu($style)",4,__LINE__,$::admin_module);

	return($admin_menu);
}


##########################################################################

=head3 deleteObject()

 $delete_form=deleteObject($some_object,$mode);

 $delete_form - The HTML of the confirmation form, returned if $mode=1.
 $some_object - Relative name (from album_dir on) of object to delete.
 $mode - 0 = do it; 1 = show confirmation

Deletes the selected object.

=cut
sub deleteObject
{
my $some_object=shift;
my $mode=shift;
my $some_thumb=$some_object;
my $fullpath;
my $temp;
my $imgext;
my $alb_thumb_ext;
my $movieext;
my @myfile_list;
my $newfile;
my $tempshortdesc;
my $templongdesc;
my $tempowner;
my $tempfunction;
my $delete_form;

	debug("Entering subroutine: deleteObject($some_object,$mode)",4,__LINE__,$::admin_module);

	# Get thumbnail name...

	# Change all \'s to /'s
	$some_thumb=~s/\\/\//g;

	# Drop the preceeding path
	$some_thumb=~s/(.*\/)(.*)/$2/;

	$fullpath=$1;

	$some_thumb=~s/(.*)\..*/$1/;
	$some_thumb="$fullpath$::thumbprefix$some_thumb";

	# Check for photo extensions
	foreach $imgext (@::imgexts)
	{
		# Check lower case extensions
		$imgext="\L$imgext";
		if (-e "$::album_dir/$some_thumb.$imgext")
		{
			$alb_thumb_ext=$imgext;
		}

		# Check upper case extensions
		$imgext="\U$imgext";
		if (-e "$::album_dir/$some_thumb.$imgext")
		{
			$alb_thumb_ext=$imgext;
		}
	}

	# Check for movie extensions
	foreach $movieext (@::movieexts)
	{
		# Check lower case extensions
		$movieext="\L$movieext";
		if (-e "$::album_dir/$some_thumb.$movieext")
		{
			$alb_thumb_ext=$movieext;
		}

		# Check upper case extensions
		$movieext="\U$movieext";
		if (-e "$::album_dir/$some_thumb.$movieext")
		{
			$alb_thumb_ext=$movieext;
		}
	}

	# If there wasn't an extension found, then wildcard it for deletion
	if (!$alb_thumb_ext)
	{
		$alb_thumb_ext="*";
	}

	# Add extension
	$some_thumb.=".$alb_thumb_ext";

	if ($mode)
	{
		# Print confirmation form

		# Set temp=1 if it's a photo
		$temp=isAPhotoOrJp2($some_object);

		# Set temp=2 if it's a movie
		if (!$temp)
		{
			$temp=isAMovie($some_object);
			if ($temp)
			{
				$temp++;
			}
		}

		$delete_form.="<p>$::S{184} $some_object?<br />\n";
		if ($temp)
		{
			$delete_form.="<small>$some_thumb $::S{199}</small><p>\n";
		}
		else
		{
			opendir(ENTRIES,"$::album_dir/$some_object") or error(__LINE__,"not_readable","$::album_dir/$some_object",$::admin_module);

			# Skip . and ..
			@myfile_list=grep !/^\.\.?$/,readdir ENTRIES;
			close(ENTRIES);

			$newfile=scalar(@myfile_list);
			debug("There are $newfile files in this directory.",2,__LINE__,$::admin_module);

			# Display list of files to be deleted, if there are any
			if ($newfile)
			{
				$delete_form.="<br />$::S{212}<br />\n";

				foreach $newfile (@myfile_list)
				{
					$delete_form.="$newfile<br />\n";
				}
			}
		}
		$delete_form.="<form method=\"post\" action=\"$::albumprog\">\n";

		$delete_form.="<input type=\"hidden\" name=\"confirmdeleteobject\" value=\"$some_object\" />\n";

		$delete_form.="<input type=\"hidden\" name=\"";
		$delete_form.="album\" value=\"$::goback\" />\n";

		$fullpath=passVars(1);
		$delete_form.=$fullpath;
		$delete_form.="<input type=\"submit\" value=\"$::S{224}\" name=\"yes\" class=\"button\" /> \n";
		$delete_form.="<input type=\"submit\" value=\"$::S{225}\" name=\"no\" class=\"button\" /></form>\n";

		# If it's a photo, show it.
		if ($temp eq 1)
		{
			$delete_form.="<img src=\"$::album_web/$some_object\" alt=\"\" />\n";
		}

		return($delete_form);
	}
	else
	{
		$some_object="$::album_dir/$some_object";
		$some_thumb="$::album_dir/$some_thumb";

		# Pull out just the object
		$newfile=$some_object;
		$newfile=~s/(.*\/)(.*)/$2/;

		# No change? Then this must be a Win32 machine...
		if ($newfile eq $some_object)
		{
			$newfile=~s/(.*\\)(.*)/$2/;
		}

		# Pull off the path to the object
		$temp=$some_object;
		$temp=~s/(.*\/)(.*)/$1/;

		# No change? Then this must be a Win32 machine...
		if ($temp eq $some_object)
		{
			$temp=~s/(.*\\)(.*)/$1/;
		}

		# Get owner
		openDescfile($temp);

		# Save off old descriptions info
		$tempshortdesc=$::shortdesc;
		$templongdesc=$::longdesc;
		$tempowner=$::owner;
		$tempfunction=$::function;
		getDescription($newfile);

		debug("Deleting [$some_object] and it's thumbnail [$some_thumb]",2,__LINE__,$::admin_module);

		debug("Currently logged in user is $::loggedin",2,__LINE__,$::admin_module);
		debug("User who owns the object is $::owner",2,__LINE__,$::admin_module);
		debug("List of default admins: $::default_admins",2,__LINE__,$::admin_module);

		# Only do this if you're in admin mode, or if you're the owner of the thing, or if you're a default admin...
		if ($::function eq $::admin || (($::owner eq $::loggedin || $::default_admins=~/.*,$::loggedin,.*/) && $::loggedin))
		{
			debug("Ok, we're going to delete this: $some_object",2,__LINE__,$::admin_module);

			if (-d $some_object)
			{
				opendir(ENTRIES,"$some_object") or error(__LINE__,"not_readable","$some_object",$::admin_module);

				# Skip . and ..
				@myfile_list=grep !/^\.\.?$/,readdir ENTRIES;
				close(ENTRIES);

				debug("$some_object is a directory.",2,__LINE__,$::admin_module);

				foreach $newfile (@myfile_list)
				{
					$newfile="$some_object/$newfile";
					debug("Deleting $newfile",2,__LINE__,$::admin_module);
					if (!unlink("$newfile"))
					{
						print "$::S{150} $newfile $::S{185} -- $!<br />";
					}
				}

				if (!rmdir($some_object))
				{
					print "$::S{150} $some_object $::S{185} -- $!<br />";
				}
			}
			else
			{
				debug("$some_object is a file.",2,__LINE__,$::admin_module);
				if (!unlink($some_object))
				{
					print "$::S{150} $some_object $::S{185}";
				}
			}

			# Delete Description
			debug("Deleting object $newfile in location $temp.",2,__LINE__,$::admin_module);
			require $::ratings_module;
			deleteDesc($newfile,$temp);

			# Delete thumbnail
			if (!unlink($some_thumb))
			{
				# We found a specific thumbnail, but it wasn't deleted.
				if ($alb_thumb_ext ne "*")
				{
					print "$::S{150} $some_thumb $::S{185}";
				}
			}

			# Kill the static HTML, if it's there
			unlink("$some_object.html");
			unlink("$some_object/$::static_html_filename");
		}
		else
		{
			print "$::S{150} $some_object $::S{186}";
		}

		# Restore descriptions info
		$::shortdesc=$tempshortdesc;
		$::longdesc=$templongdesc;
		$::owner=$tempowner;
		$::function=$tempfunction;
	}

	debug("Leaving subroutine: deleteObject($some_object,$mode)",4,__LINE__,$::admin_module);

}


##########################################################################

=head3 moveObject()

 $move_form=moveObject($some_object,$mode,$moveto,$new_object);

 $move_form - The HTML of the confirmation form, returned if $mode=1.
 $some_object - Relative name (from album_dir on) of object to move.
 $mode - 0 = do it; 1 = show confirmation
 $moveto - The location to move the object to.
 $new_object - The new filesystem name for the moved/renamed object.

Moves the selected object.

=cut
sub moveObject
{
my $some_object=shift;
my $mode=shift;
my $moveto=shift;
my $new_object=shift;
my $some_thumb=$some_object;
my $new_thumb=$new_object;
my $fullpath;
my $temp;
my $imgext;
my $alb_thumb_ext;
my $movieext;
my $newfile;
my $thumb_moveto;
my $short_thumb;
my $short_object;
my $short_new_thumb;
my $short_new_object;
my $movedir;
my $fromdir;
my $tempshortdesc;
my $templongdesc;
my $tempowner;
my $tempfunction;
my $templevel;
my $move_form;
my $view_moveto=$moveto;

	debug("Entering subroutine: moveObject($some_object,$mode,$moveto,$new_object)",4,__LINE__,$::admin_module);

	# Turn $moveto into a full path
	$moveto="$::album_dir/$moveto";

	# Get thumbnail name...

	# Change all \'s to /'s
	$some_thumb=~s/\\/\//g;
	$new_thumb=~s/\\/\//g;

	# Drop the preceeding path
	$some_thumb=~s/(.*\/)(.*)/$2/;
	$fullpath=$1;
        # To start with, the new filename is the smae as the old filename
        if (!$new_object)
        {
                $new_object=$some_thumb;
        }
	$new_thumb=~s/(.*\/)(.*)/$2/;


	$some_thumb=~s/(.*)\..*/$1/;
	$new_thumb=~s/(.*)\..*/$1/;
	$some_thumb="$fullpath$::thumbprefix$some_thumb";
	$new_thumb="$fullpath$::thumbprefix$new_thumb";

	# Check for photo extensions
	foreach $imgext (@::imgexts)
	{
		# Check lower case extensions
		$imgext="\L$imgext";
		if (-e "$::album_dir/$some_thumb.$imgext")
		{
			$alb_thumb_ext=$imgext;
		}

		# Check upper case extensions
		$imgext="\U$imgext";
		if (-e "$::album_dir/$some_thumb.$imgext")
		{
			$alb_thumb_ext=$imgext;
		}
	}

	# Check for movie extensions
	foreach $movieext (@::movieexts)
	{
		# Check lower case extensions
		$movieext="\L$movieext";
		if (-e "$::album_dir/$some_thumb.$movieext")
		{
			$alb_thumb_ext=$movieext;
		}

		# Check upper case extensions
		$movieext="\U$movieext";
		if (-e "$::album_dir/$some_thumb.$movieext")
		{
			$alb_thumb_ext=$movieext;
		}
	}

	# If there wasn't an extension found, then wildcard it for moving
	if (!$alb_thumb_ext)
	{
		$alb_thumb_ext="*";
	}

	# Add extension
	$some_thumb.=".$alb_thumb_ext";
	$new_thumb.=".$alb_thumb_ext";

	# Print confirmation form
	if ($mode)
	{
		# Set temp=1 if it's a photo
		$temp=isAPhotoOrJp2($some_object);

		# Set temp=2 if it's a movie
		if (!$temp)
		{
			$temp=isAMovie($some_object);
			if ($temp)
			{
				$temp++;
			}
		}

		$move_form.="<p>$::S{218} $some_object?<br />\n";
		if ($temp)
		{
			$move_form.="<small>$some_thumb $::S{222}</small><p>\n";
		}

		$move_form.="<form method=\"post\" action=\"$::albumprog\">\n";
		$move_form.="$::S{223}<select name=\"category\">\n";

		$::doing_upload=1;
		recursiveScan($::album_dir);
		$::doing_upload=0;
		$move_form.="$::object</select><br>\n";
		$move_form.="<input type=\"hidden\" name=\"confirmmoveobject\" value=\"$some_object\" />\n";
		$move_form.="$::S{347} <input type=\"text\" name=\"newobjectname\" value=\"$new_object\" /><p>\n";
		$move_form.="<input type=\"hidden\" name=\"";
		$move_form.="album\" value=\"$::goback\" />\n";

		$fullpath=passVars(1);
		$move_form.=$fullpath;
		$move_form.="<input type=\"submit\" value=\"$::S{215}\" name=\"yes\" class=\"button\" /> \n";
		$move_form.="<input type=\"submit\" value=\"$::S{228}\" name=\"no\" class=\"button\" /> \n";
		$move_form.="</form>\n";

		# If it's a photo, show it.
		if ($temp eq 1)
		{
			$move_form.="<img src=\"$::album_web/$some_object\" alt=\"\" />\n";
		}

		return($move_form);
	}
	else
	# Actually move the object
	{
		$movedir="$moveto";

		$short_thumb=$some_thumb;
		$short_new_thumb=$new_thumb;

		# Change all \'s to /'s
		$some_thumb=~s/\\/\//g;
		$new_thumb=~s/\\/\//g;

		# Drop the proceeding path
		$short_thumb=~s/(.*\/)(.*)/$2/;
		$short_new_thumb=~s/(.*\/)(.*)/$2/;

		$thumb_moveto="$moveto/$short_new_thumb";

		$short_object=$some_object;
		$short_new_object=$new_object;

		# Change all \'s to /'s
		$short_object=~s/\\/\//g;
		$short_new_object=~s/\\/\//g;

		# Drop the proceeding path
		$short_object=~s/(.*\/)(.*)/$2/;
		$fromdir=$1;
		$short_new_object=~s/(.*\/)(.*)/$2/;

		# Still no change? Then there was no path at all...
		if ($short_object eq $some_object)
		{
			$fromdir="";
		}

		$moveto.="/$short_new_object";

		# Read the description for the file about to be moved
		openDescfile("$::album_dir/$fromdir");

		# Save off old descriptions info
		$tempshortdesc=$::shortdesc;
		$templongdesc=$::longdesc;
		$tempowner=$::owner;
		$tempfunction=$::function;
		$templevel=$::this_level;
		getDescription($short_object);

		$some_object="$::album_dir/$some_object";
		$new_object="$::album_dir/$new_object";

		$some_thumb="$::album_dir/$some_thumb";
		$new_thumb="$::album_dir/$new_thumb";

		debug("Moving [$some_object] and it's thumbnail [$some_thumb] to [$moveto]",2,__LINE__,$::admin_module);

		debug("Currently logged in user is $::loggedin",2,__LINE__,$::admin_module);
		debug("User who owns the object is $::owner",2,__LINE__,$::admin_module);
		debug("List of default admins: $::default_admins",2,__LINE__,$::admin_module);

		# Only do this if you're in admin mode, or if you're the owner of the thing, or if you're a default admin...
		if ($::function eq $::admin || (($::owner eq $::loggedin || $::default_admins=~/.*,$::loggedin,.*/) && $::loggedin))
		{
			debug("Ok, we're going to move this: $some_object here: $moveto",2,__LINE__,$::admin_module);

			if (!rename($some_object,$moveto))
			{
				print "$::S{150} $some_object $::S{219}";
			}

			# Delete description
			# Pull out just the object
			$newfile=$some_object;
			$newfile=~s/(.*\/)(.*)/$2/;

			# No change? Then this must be a Win32 machine...
			if ($newfile eq $some_object)
			{
				$newfile=~s/(.*\\)(.*)/$2/;
			}

			# Pull off the path to the object
			$temp=$some_object;
			$temp=~s/(.*\/)(.*)/$1/;

			# No change? Then this must be a Win32 machine...
			if ($temp eq $some_object)
			{
				$temp=~s/(.*\\)(.*)/$1/;
			}

			# Update description in new location
			require $::ratings_module;
			updateDesc($short_new_object,"$movedir/",$::shortdesc,$::longdesc,$::owner,$::this_level);

			# Delete Description
			debug("Deleting object $newfile in location $temp.",2,__LINE__,$::admin_module);
			require $::ratings_module;
			deleteDesc($newfile,$temp);

			# Move thumbnail
			if (!rename($some_thumb,$thumb_moveto))
			{
				# We found a specific thumbnail, but it wasn't moved.
				if ($alb_thumb_ext ne "*")
				{
					print "$::S{150} $some_thumb $::S{219}";
				}
			}

			# Kill the static HTML, if it's there
			unlink("$some_object.html");
			unlink("$some_object/$::static_html_filename");

			# *** Move the image views too!
                        my $tempview;
                        my $tempgoback;
                        $tempgoback=$::goback;
                        $::goback=$fromdir;
                        $tempview=trackView($short_object,1);
                        $::goback=$view_moveto;
                        $tempview=trackView($short_new_object,3,$tempview);
                        $::goback=$fromdir;
                        $tempview=trackView($short_object,2);
                        $::goback=$tempgoback;
		}
		else
		{
			print "$::S{150} $some_object $::S{220}";
		}

		# Restore descriptions info
		$::shortdesc=$tempshortdesc;
		$::longdesc=$templongdesc;
		$::owner=$tempowner;
		$::function=$tempfunction;
		$::this_level=$templevel;
	}

	debug("Leaving subroutine: moveObject($some_object,$mode,$moveto,$new_object)",4,__LINE__,$::admin_module);

}


##########################################################################

=head3 linkObject()

 $link_form=linkObject($some_object,$mode,$linkto);

 $link_form - The HTML of the confirmation form, returned if $mode=1.
 $some_object - Relative name (from album_dir on) of object to link.
 $mode - 0 = do it; 1 = show confirmation
 $linkto - The location to link the object to, relative to album_dir.

links the selected object.

=cut
sub linkObject
{
my $some_object=shift;
my $mode=shift;
my $linkto=shift;
my $temp;
my $newfile;
my $short_object;
my $linkdir;
my $fromdir;
my $tempshortdesc;
my $templongdesc;
my $tempowner;
my $tempfunction;
my $link_form;

	debug("Entering subroutine: linkObject($some_object,$mode,$linkto)",4,__LINE__,$::admin_module);

	# Turn $linkto into a full path
	$linkto="$::album_dir/$linkto";

	# Print confirmation form
	if ($mode)
	{
		# Set temp=1 if it's a photo
		$temp=isAPhotoOrJp2($some_object);

		# Set temp=2 if it's a movie
		if (!$temp)
		{
			$temp=isAMovie($some_object);
			if ($temp)
			{
				$temp++;
			}
		}

		$link_form.="<p>$::S{310} $some_object?<br />\n";

		$link_form.="<form method=\"post\" action=\"$::albumprog\">\n";
		$link_form.="$::S{313}<select name=\"category\">\n";

		$::doing_upload=1;
		recursiveScan($::album_dir);
		$::doing_upload=0;
		$link_form.="$::object</select><p>\n";
		$link_form.="<input type=\"hidden\" name=\"confirmlinkobject\" value=\"$some_object\" />\n";

		$link_form.="<input type=\"hidden\" name=\"";
		$link_form.="album\" value=\"$::goback\" />\n";

		$link_form.=passVars(1);
		$link_form.="<input type=\"submit\" value=\"$::S{308}\" name=\"yes\" class=\"button\" /> \n";
		$link_form.="<input type=\"submit\" value=\"$::S{228}\" name=\"no\" class=\"button\" /> \n";
		$link_form.="</form>\n";

		# If it's a photo, show it.
		if ($temp eq 1)
		{
			$link_form.="<img src=\"$::album_web/$some_object\" alt=\"\" />\n";
		}

		return($link_form);
	}
	else
	# Actually link the object
	{
		$linkdir="$linkto";

		$short_object=$some_object;

		# Change all \'s to /'s
		$short_object=~s/\\/\//g;

		# Drop the proceeding path
		$short_object=~s/(.*\/)(.*)/$2/;
		$fromdir=$1;

		# Still no change? Then there was no path at all...
		if ($short_object eq $some_object)
		{
			$fromdir="";
		}

		$linkto.="/$short_object";

		debug("Linking [$some_object] to [$linkto]",2,__LINE__,$::admin_module);

		debug("Currently logged in user is $::loggedin",2,__LINE__,$::admin_module);
		debug("List of default admins: $::default_admins",2,__LINE__,$::admin_module);

		# Only do this if you're in admin mode, or if you're a default admin...
		if ($::function eq $::admin || ($::default_admins=~/.*,$::loggedin,.*/ && $::loggedin))
		{
			debug("Ok, we're going to link this: $some_object here: $linkto",2,__LINE__,$::admin_module);

			$linkto=~s/(.*)\..*/$1.$::linkext/;

			open(LINK,">$linkto") || print "$::S{150} $some_object $::S{311}";
			print LINK "URL=$some_object";
			close(LINK);
		}
		else
		{
			print "$::S{150} $some_object $::S{312}";
		}
	}

	debug("Leaving subroutine: linkObject($some_object,$mode,$linkto)",4,__LINE__,$::admin_module);

}


##########################################################################

=head3 createAlbumForm()

 $create_form=createAlbumForm($createalbum);

 $create_form - The HTML for the Create Album form.
 $createalbum - The filesystem directory to create the album in.

Displays the "create album" form.

=cut
sub createAlbumForm
{
my $data;
my $create_form;
my $createalbum=shift;

	if ($createalbum eq $::rootalbumname)
	{
		$createalbum="/";
	}

	$data=passVars(1);
	$create_form=<<HTML;
<p>
$::S{187} <b>$createalbum</b>.
<p>
<form method="post" action="$::albumprog">
$::S{188} <input type="text" name="albumname" />
$data
<p>
HTML
	$create_form.=buildDescFooter(1);
	$create_form.=<<HTML;
<input type="hidden" name="admincreate" value="1" />
<input type="hidden" name="album" value="$createalbum" />
<p>
<input type="submit" value="$::S{49}" class="button" />
</form>
HTML

	return($create_form);
}


##########################################################################

=head3 createAlbum()

$return_code=createAlbum($basedir,$directory,$newshortdesc,$newlongdesc,$newowner,$new_view_level,$mode);

 $return_code - Non-zero only if directory could not be created.
 $basedir - The location to create the new album, as an absolute filesystem path.
 $directory - The actual directory name for the album.
 $newshortdesc - Short description for new album.
 $newlongdesc - Long description for new album.
 $newowner - The owner of the album.
 $new_view_level - The membership level required to view this object
 $mode - 0 = No change; 1 = Force album creation, even if not an admin (for uploads)

Creates $directory in $basedir, and updates the description with $newshortdesc and $newlongdesc.

=cut
sub createAlbum
{
my $basedir=shift;
my $directory=shift;
my $newshortdesc=shift;
my $newlongdesc=shift;
my $newowner=shift;
my $new_view_level=shift;
my $new_view_level;
my $mode=shift;
my $dirtomk;
my $status;

	debug("Entering subroutine: createAlbum($basedir,$directory,$newshortdesc,$newlongdesc,$newowner,$new_view_level,$mode)",4,__LINE__,$::admin_module);

	# Check for tampering
	if ($basedir=~/^\\*\./ || $basedir=~/^\/*\./ || $directory=~/^\\*\./ || $directory=~/^\/*\./)
	{
		error(__LINE__,"sanity","$::S{84} $::S{14}.",$::admin_module);
	}

	# Prepend $::album_dir to $basedir for security reasons
	$basedir="$::album_dir/$basedir";

	# Strip things down
	$dirtomk=$basedir;
	# Drop the preceeding path
	$dirtomk=~s/(.*\/)(.*)/$2/;

	# Get owner info
	openDescfile("$1/");
	getDescription($2);

	# Force an authentication
	Authenticate();

	if (!isAdmin() && !$mode)
	{
		debug("Not authorized (mode: $mode)!",4,__LINE__,$::admin_module);
		display(javaAlert($::S{296}));
		return(1);
	}

	# Set owner if not already set
	if (!$newowner)
	{
		$newowner=$::loggedin;
	}

	chomp($directory);
	$dirtomk="$basedir/$directory";

	# If dir doesn't already exist, create it.
	if (!(-d $dirtomk))
	{
		if (!mkdir($dirtomk,777))
		{
			$status=1;
		}
		if (!chmod(0777,$dirtomk))
		{
			$status=2;
		}

		# Update the description for this new album
		if ($newshortdesc || $newowner)
		{
			require $::ratings_module;
			updateDesc($directory,"$basedir/",$newshortdesc,$newlongdesc,$newowner,$new_view_level);
		}
	}
	else
	{
		print "$::S{150} $dirtomk $::S{189}";
	}

	debug("Leaving subroutine: createAlbum($basedir,$directory,$newshortdesc,$newlongdesc,$newowner,$new_view_level,$mode)",4,__LINE__,$::admin_module);

	return($status);
}


##########################################################################

=head3 checkUpdate()

 checkUpdate();

Checks to see if there is a newer version of album.pl available.

=cut
sub checkUpdate
{
use IO::Socket;

my $Sock;
my $buf;
my $query;
my $remotever;
my $remotedate;
my $stripver;
my @allinfo;
my $revdate;
my $quit;
my $reghost="perl.Bobbitt.ca";

	debug("Entering subroutine: checkUpdate()",4,__LINE__,$::admin_module);

	$Sock=IO::Socket::INET->new(PeerAddr=>$reghost,PeerPort=>80,Proto=>'tcp');
	if (!$Sock)
	{
		display(javaAlert($::S{264}));
		return();
	}

	$query="GET /cgi-bin/album_update.pl HTTP/1.0";

	debug("Registration query: $query",3,__LINE__,$::admin_module);

	print $Sock "$query\n";

	print $Sock "Accept-Language: en-us\n";
	print $Sock "Content-Length: 0\n";
	print $Sock "Accept: */*\n";
	print $Sock "User-Agent: Mozilla/4.0 (compatible; Win32; WinHttp.WinHttpRequest.5)\n";
	print $Sock "Host: $reghost\n";
	print $Sock "Connection: Keep-Alive\n";
	print $Sock "\n";

	sleep(2);
	recv($Sock, $buf, 50000, 0);
	$buf=~s/\r//g;

	my @recs=split(/\n/, $buf);
	my $response;
	foreach (@recs)
	{
		$response=$_;
	}

	($remotever,$remotedate)=split("\t",$response);
	debug("Update response: $response",3,__LINE__,$::admin_module);
	debug("Remote Version: [$remotever]",3,__LINE__,$::admin_module);
	debug("Remote Date: [$remotedate] {@recs}",3,__LINE__,$::admin_module);

	$stripver=$::ver;
	$stripver=~s/\D//g;

	@allinfo=stat($0);
	$revdate=$allinfo[9];

	debug("Album Version: [$stripver] Available: [$remotever]",3,__LINE__,$::admin_module);
	debug("Album Date: [$revdate] Available: [$remotedate]",3,__LINE__,$::admin_module);

	$response="";

	# Version check
	if ($remotever <= $stripver)
	{
		debug("Version is up to date.",3,__LINE__,$::admin_module);
		$response="$::S{253}";
	}
	else
	{
		debug("Version is out of date.",3,__LINE__,$::admin_module);
	}

	# Date check
	if ($remotedate <= $revdate)
	{
		debug("Date is up to date.",3,__LINE__,$::admin_module);
		$response="$::S{253}";
	}
	else
	{
		debug("Date is out of date.",3,__LINE__,$::admin_module);
		$response="";
	}

	if (!$response)
	{
		$remotever=substr($remotever,0,1).".".substr($remotever,1,10);
		$stripver=substr($stripver,0,1).".".substr($stripver,1,10);
		$response="$::S{254}\\n\\n$::S{255} $stripver, $::S{256} ".localtime($revdate).".\\n$::S{257} $remotever, $::S{256} ".localtime($remotedate)."\\n\\n$::S{258} http://perl.Bobbitt.ca/album";
	}
	debug("To display: $response",3,__LINE__,$::admin_module);

	display(javaAlert($response));

	debug("Leaving subroutine: checkUpdate()",4,__LINE__,$::admin_module);
}


##########################################################################

=head3 showUserEdit()

 $html=showUserEdit();

 $html - HTML for displaying the "edit users" box

Returns the HTML used to display the "Edit Users" box

=cut
sub showUserEdit
{
my $html;
my $vars=passVars(1);
my $userlist;
my $num=5;
my $last;
my $data;

	if ($::authentication_type ne 1)
	{
		return();
	}

	# If auth_db doesn't already exist, create it.
	if (!(-e $::auth_db))
	{
		open(AUTH_DB,">$::auth_db") || error(__LINE__,"open_db","$::auth_db",$::admin_module);
		close(AUTH_DB);
	}

	# Open auth_db
	open(AUTH_DB,$::auth_db) || error(__LINE__,"open_db","$::auth_db",$::admin_module);

	# First check if user exists
	while ($data=<AUTH_DB>)
	{
		chomp($data);
		if ($data)
		{
			if ($last)
			{
				$userlist.="$last\n";
			}
			$last=$data;
			$num++;
		}
	}
	if ($last)
	{
		$userlist.="$last";
	}
	close(AUTH_DB);

	$html.=<<HTML;
<h2>$::S{300}</h2>
$::S{302}
<form method="post">
<table border=1 cellpadding="5" cellspacing="0" bordercolor="#111111">
<br />
</tr>
<tr><td>
$::S{300}</td><td>
<textarea rows=\"$num\" name=\"userlist\" cols=\"$::enterdesc_cols\">$userlist</textarea>
$vars
</td></table>

<p><center>
<input type="submit" value="$::S{301}" name="Apply" class="button" />
</center>
</form>
HTML

	return($html);
}


##########################################################################

=head3 updateUserList()

 updateUserList($userlist);

 $userlist - The list of users|passwords (in flatfile format) to update with

Updates the auth_db with the provided list of users.

=cut
sub updateUserList
{
my $userlist=shift;

	# Open auth_db
	open(AUTH_DB,">$::auth_db") || error(__LINE__,"open_db","$::auth_db",$::admin_module);
	print AUTH_DB "$userlist";
	close(AUTH_DB);
}


##########################################################################

=head3 getUserList()

 getUserList();

Reads the entire userlist as defined in the config, and returns it in an "HTML drop list" format

=cut
sub getUserList
{
use strict;
my $html;
my $myusername;
my $mydisplayname;
my $data;
my $storedpass;
my $dbi_fail;
my $memberslist;
my @userlist;

	# No auth type used
	if (!$::authentication_type)
	{
		return();
	}

	$html=<<HTML;
<SELECT name="owner">
HTML

	# Flatfile authentication
	if ($::authentication_type eq 1)
	{

		# Open the text database
		open(AUTH_DB,$::auth_db) || error(__LINE__,"open_db","$::auth_db",$::admin_module);

		# First check if user exists
		while (<AUTH_DB>)
		{
			chomp;
			($mydisplayname,$storedpass)=split('\|',$_);
			chomp($mydisplayname);
			chomp($storedpass);
			if ($mydisplayname)
			{
				$html.="<OPTION value=\"$mydisplayname\"";
				if ($mydisplayname eq $::owner)
				{
					$html.=" SELECTED";
				}
				$html.=">$mydisplayname</OPTION>\n";
			}
		}
		close(AUTH_DB);
		$mydisplayname=$myusername;
	}

	# UBB authentication
	if ($::authentication_type eq 2)
	{
		$memberslist="$::membersdir/memberslist.cgi";

		open (ENTRIES,"$memberslist") || error(__LINE__,"not_readable","$memberslist: $!",$::admin_module);
		while ($data=<ENTRIES>)
		{
			$myusername=$data;
			chomp($myusername);
			$myusername=~s/.*\|(.*)/$1/;

			# Only process if a user was found
			if ($myusername)
			{
				open (FILE,"$::membersdir/$myusername.cgi");
				$mydisplayname=<FILE>;
				$mydisplayname=<FILE>;
				$mydisplayname=<FILE>;
				$mydisplayname=<FILE>;
				$mydisplayname=<FILE>;
				$mydisplayname=<FILE>;
				$mydisplayname=<FILE>;
				$mydisplayname=<FILE>;
				$mydisplayname=<FILE>;
				$mydisplayname=<FILE>;
				$mydisplayname=<FILE>;
				$mydisplayname=<FILE>;
				$mydisplayname=<FILE>;
				$mydisplayname=<FILE>;
				$mydisplayname=<FILE>;
				$mydisplayname=<FILE>;
				close(FILE);

				chomp($mydisplayname);

				if (!$mydisplayname)
				{
					$mydisplayname=$myusername;
				}

				$html.="<OPTION value=\"$myusername\"";
				if ($myusername eq $::owner)
				{
					$html.=" SELECTED";
				}
				$html.=">$mydisplayname</OPTION>\n";
			}
		}
		close(ENTRIES);
	}

	# Load YaBB username/password
	if ($::authentication_type eq 3)
	{
		opendir(ENTRIES,"$::membersdir") or error(__LINE__,"not_readable","$::membersdir",$::admin_module);

		# Change Grep
		@userlist=readdir ENTRIES;
		close(ENTRIES);

		foreach $memberslist (@userlist)
		{
			if ($memberslist=~/\.dat$/)
			{
				open(FILE,"$::membersdir/$memberslist") or $::warning.="$::S{20} $::membersdir/$memberslist";
				$mydisplayname=<FILE>;
				$mydisplayname=<FILE>;
				close(FILE);
				$myusername=$memberslist;
				$myusername=~s/(.*)\.dat$/$1/;

				if ($mydisplayname)
				{
					$html.="<OPTION value=\"$myusername\"";
					if ($myusername eq $::owner)
					{
						$html.=" SELECTED";
					}
					$html.=">$mydisplayname</OPTION>\n";
				}
			}
		}
	}

	# Check for DBI package, include if present
	$dbi_fail=DBICheck();

	# Load database username/password
	if ($::authentication_type eq 4 && !$dbi_fail)
	{
	my $user_sql;
	my $dbh;
	my $sth;
	my $rv;
	my @row;

		# Connect to database
		$dbh=DBI->connect("DBI:$::db_driver:$::db_name:$::db_hostname:$::db_port",$::db_user,$::db_password) || die $DBI::errstr;

		# Build SQL command
		$user_sql="SELECT $::db_username FROM $::db_membertable";

		debug("SQL query: $user_sql",2,__LINE__,$::admin_module);

		if ($dbh)
		{
			# Check SQL command
			$sth=$dbh->prepare($user_sql);

			# Check for errors
			if (!$sth)
			{
				$::warning.="$::S{293}$::S{221} ";
				$::warning.=$sth->errstr."<br />";
			}

			# Run SQL command
			$rv=$sth->execute;
			debug("Query returned $rv rows.",2,__LINE__,$::admin_module);

			# Check for errors
			if (!$rv)
			{
				$::warning.="$::S{293}$::S{221} ";
				$::warning.=$sth->errstr."<br />";
			}

			# Fetch Rows
			while(@row=$sth->fetchrow_array)
			{
				$mydisplayname=$row[0];
				debug("\$row[0]=$mydisplayname",2,__LINE__,$::admin_module);

				if ($mydisplayname)
				{
					$html.="<OPTION value=\"$mydisplayname\"";
					if ($mydisplayname eq $::owner)
					{
						$html.=" SELECTED";
					}
					$html.=">$mydisplayname</OPTION>\n";
				}
			}

			# Disconnect from database
			$dbh->disconnect;
		}
		else
		{
			$::warning.="$::S{293}$::S{226}<br />";
		}

		debug("Warning is currently: $::warning",2,__LINE__,$::admin_module);
	}

	# AmLite authentication
	if ($::authentication_type eq 5)
	{
		debug("getting AmLite userlist (type $::authentication_type)",2,__LINE__,$::admin_module);

		my $lines;
		my @database_array;
		my @edit_array;

		$memberslist="$::membersdir/amdata.db";

		open (FILE,"$memberslist") || return(0);
		@database_array = <FILE>;
		close (FILE);
		debug("database array is : @database_array",4,__LINE__,$::admin_module);
		foreach $lines(@database_array)
		{
			@edit_array = split(/\:/,$lines);
			debug("edit array is : @edit_array",4,__LINE__,$::admin_module);
			$html.="<OPTION value=\"@edit_array[0]\"";
			if (@edit_array[0] eq $::owner)
			{
				$html.=" SELECTED";
			}
			$html.=">@edit_array[0]</OPTION>\n";
		}
		$lines = "";
		@edit_array = @database_array = "";
	}

	$html.="</SELECT>";

	return($html);
}


##########################################################################

=head3 regConnect()

 $response=regConnect($email,$url);

 $response - The response from the registration server
 $email - E-mail to register (product update notices ONLY will be sent to this address - and maybe not even those!)
 $url - URL of the album itself

Connects to registration server.

=cut
sub regConnect
{
use IO::Socket;

my $email=shift;
my $url=shift;
my $Sock;
my $buf;
my $query;
my $reghost="perl.Bobbitt.ca";

	$Sock=IO::Socket::INET->new(PeerAddr=>$reghost,PeerPort=>80,Proto=>'tcp') || return("Couldn't connect.");

	$query="GET /cgi-bin/album_register.pl?email=$email&url=$url HTTP/1.0";

	debug("Registration query: $query",3,__LINE__,$::admin_module);

	print $Sock "$query\n";

	print $Sock "Accept-Language: en-us\n";
	print $Sock "Content-Length: 0\n";
	print $Sock "Accept: */*\n";
	print $Sock "User-Agent: Mozilla/4.0 (compatible; Win32; WinHttp.WinHttpRequest.5)\n";
	print $Sock "Host: $reghost\n";
	print $Sock "Connection: Keep-Alive\n";
	print $Sock "\n";

	sleep(2);
	recv($Sock, $buf, 50000, 0);
	$buf=~s/\r//g;

	my @recs=split(/\n/, $buf);
	my $response;
	foreach (@recs)
	{
		$response.=$_;
	}

	debug("Registration response: $response",3,__LINE__,$::admin_module);

	return($response);
}


##########################################################################

=head3 showConfig()

 showConfig();

Displays the configuration items from $::configfile in a web submittable form, then exits.

=cut
sub showConfig
{
my $data;
my $section;
my $first_section;
my $paramsize;
my $prevline;
my $var;
my $value;
my $line;
my $help;
my $sect_header;
my $guessed;
my $notes;
my $configwarning;
my $readonly;
my $stopcol=$::S{122};
my $warncol=$::S{123};
my $configHTML;
my $configJump;
my $configSection=$form->param('configSection');
my $showSection;
my $secretCode="SecretCodeToShowNone";
my $output;

	# Set up config jump station
	$configJump.=<<HTML;
<script language="JavaScript">
function JumpNow()
{
	document.ConfigJump.submit();
}
</script>

<form name="ConfigJump" method="GET" action="$::albumprog">
HTML
	$configJump.=passVars(1);
	$configJump.=$::S{304};
	$configJump.=" <SELECT name=\"configSection\" onChange=\"JumpNow()\">\n";
	$configJump.="<OPTION value=\"SecretCodeToShowNone\"></OPTION>";
	$configJump.="<OPTION value=\"$::S{303}\">$::S{303}</OPTION>";

	printHTMLHeader();

	$configHTML="<head><title>album.pl - $::S{52}";

	# If configfile is not writable, then warn user
	if (!-w $::configfile)
	{
		$readonly=1;
		$configHTML.=" - $::S{124}";
	}

	$configHTML.="</title>\n";

	$data=printHeader();

	$configHTML.=<<HTML;
<META HTTP-EQUIV="pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" Content="Thu, 01 Jan 1970 00:00:01 GMT">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
$data
<h1>$::S{52}
HTML
	if ($readonly)
	{
		$configHTML.=" - $::S{124}";
	}

	$configHTML.=<<HTML;
</h1>
HTML

	if ($readonly)
	{
		$configHTML.="<p><font color=\"$stopcol\">$::S{125} $::S{126}$::configfile$::S{127}</font><p>";
	}

	$configHTML.="&#187; <a href=\"$::albumprog\">$::S{170}</a><br />\n";
	$configHTML.="&#187; <a href=\"http://perl.Bobbitt.ca/forums\">album.pl $::S{230}</a><br />\n";
	$configHTML.="&#187; <a href=\"album.pl?upgradecfg=true\">$::S{95} $::S{319}</a><br />\n";

	# Show link to album_test.pl if present
	if (-r "album_test.pl")
	{
		$configHTML.="&#187; <a href=\"album_test.pl\">$::S{95} $::S{252}</a><br />\n";
	}

	# Show link to album.html if present
	if (-e "album.html")
	{
		$configHTML.="&#187; <a href=\"album.html\">$::S{95} $::S{128}</a>\n";
	}


	# Insert config jump station here
	$configHTML.="<p>\n####CONFIGJUMP####\n";

	$configHTML.="<form method=\"post\">";

	# This is the first time the album has been used - initial config
	if ($::newconfig eq "true")
	{
		$configHTML.="<p>$::S{129} $0 $::S{130}<p>";
		debug("Configuring album.pl for the first time.",2,__LINE__,$::admin_module);

		# Don't hide sections, show it all
		$configSection="";
	}
	else
	{
		# Show no sections
		if (!$configSection)
		{
			$configSection=$secretCode;
		}

		if ($configSection eq $::S{303})
		{
			$configSection="";
		}
	}

	# Open the config file
	open(CONFIG,"$::configfile") || error(__LINE__,"no_config","$::configfile: $!",$::admin_module);

	$first_section=1;
	while ($data=<CONFIG>)
	{
		$line++;
		chomp($data);

		# Stript out trailing and leading whitespace
		$data=~s/^\s*(\S*)\s*$/$1/;

		# Read section blocks
		if ($prevline=~/^##+$/)
		{
		my $sect;
		my $sect2;

			$section=$data;
			$section=~s/^# (.*) #$/$1/;

			# Set upper first letter of each word
			$sect2="\L$section";
			$section="";
			foreach $sect (split(" ","$sect2"))
			{
				if ($section)
				{
					$section.=" ";
				}
				$section.="\u$sect";
			}

			# Show only configured section
			# Only change if we're hitting a section change
			if ($section)
			{
				if ($configSection && $configSection ne $section)
				{
					$showSection=0;
				}
				else
				{
					$showSection=1;
				}
			}

			if ($first_section)
			{
				$first_section=0;
			}
			elsif ($section && $showSection)
			{
				$configHTML.="</table>";
			}

			# Section was not defined, so we're about to start the "data" of the current section
			if (!$section)
			{
				if ($showSection)
				{
					$configHTML.=<<HTML;
<p>
<table border=1 cellpadding="5" cellspacing="0" bordercolor="#111111">
HTML
				}
			}
			else
			{
				# Section header
				if ($showSection)
				{
					$configHTML.=<<HTML;
<p>
<h2>$section</h2>
HTML
				}

				# Add the section headings to the config jump station
				$configJump.="<OPTION value=\"";
				$configJump.="$section\"";
				if ($configSection eq $section)
				{
					$configJump.=" SELECTED";
				}
				$configJump.=">";
				$configJump.="$section";
				$configJump.="</OPTION>\n";
			}
			$sect_header=1;
		}

		# Display comments as help
		if (($data!~/.*#$/) && ($data!~/^# \$[I]d: /) && ($data=~/^# (.*)/))
		{
			if ($help)
			{
				$help.="<br />";
			}
			$help.="$1";
		}

		# Print section header help, if any
		if ($sect_header && (!$data) && $help && $showSection)
		{
			$configHTML.=<<HTML;
$help
<p>
HTML
			$sect_header=0;
			$help="";
		}

		# skip comments and blank lines
		if (!(($data eq "") || ($data=~/^#.*/)))
		{

			$sect_header=0;

			if ($data!~/.+=.*/)
			{
				$::warning.="$::S{29} $line";
			}
			$data=~/(@*\w+)=(.*)/;
			$var=$1;
			$value=$2;
			debug("Var [$var] = [$value]",3,__LINE__,$::admin_module);

			# Skip special "newconfig" item
			if ($var ne "newconfig")
			{

				if ($showSection)
				{
					$configHTML.=<<HTML;
<tr><td>
<h3>$var</h3>
HTML
					if ($help)
					{
						$configHTML.=<<HTML;
$help
HTML
					}
				}

				$guessed=0;

				# For new configs, take "best guesses" at what some values should be
				if ($::newconfig eq "true")
				{
					if ($var eq "cgi_dir")
					{
						$value=cwd;
						$value=~s/\\/\//g;
						$guessed=1;
						$::cgi_dir=$value;
						debug("\$::cgi_dir is now [$value]",3,__LINE__,$::admin_module);
					}
					if ($var eq "album_dir")
					{
						$value=cwd;
						$value=~s/\\/\//g;
						$value=~s/(.*)\/.*/$1\/album/;
						$guessed=1;
						$::album_dir=$value;
						debug("\$::album_dir is now [$value]",3,__LINE__,$::admin_module);
					}
					if ($var eq "cgi_web")
					{
						$value="http://$ENV{HTTP_HOST}$ENV{SCRIPT_NAME}";
						$value=~s/(.*)\/.*/$1/;
						$guessed=1;
						$::cgi_web=$value;
						debug("\$::cgi_web is now [$value]",3,__LINE__,$::admin_module);
					}
					if ($var eq "album_web")
					{
						$value="http://$ENV{HTTP_HOST}/album";
						$guessed=1;
						$::album_web=$value;
						debug("\$::album_web is now [$value]",3,__LINE__,$::admin_module);
					}
					if ($var eq "module_path")
					{
						$value=cwd;
						$value=~s/\\/\//g;
						$guessed=1;
						$::module_path=$value."/Modules";
						debug("\$::module_path is now [$value]",3,__LINE__,$::admin_module);
					}
					if ($var eq "template_dir")
					{
						$value=cwd;
						$value=~s/\\/\//g;
						$guessed=1;
						$::template_dir=$value;
						debug("\$::template_dir is now [$value]",3,__LINE__,$::admin_module);
					}
					if ($var eq "jhead")
					{
						$value=`which jhead 2>&1`;
						if ($value!~/^\//)
						{
							$value="";
						}
						else
						{
							$guessed=1;
							$::jhead=$value;
							debug("\$::jhead is now [$value]",3,__LINE__,$::admin_module);
						}
					}
					if ($var eq "imagemagick")
					{
					my $system_call;

						$system_call="which convert";

						$output=`$system_call 2>&1`;
						if ($output=~s/\/convert//)
						{
							$value=$output;
							$guessed=1;
							$::imagemagick=$value;
							debug("\$::imagemagick is now [$value]",3,__LINE__,$::admin_module);
						}
						else
						{
							$value="";
						}
					}
				}

				# Display some status notes on certain config items

				# Check to see that directories exist
				if (($var eq "cgi_dir") && !(-d $value))
				{
					$notes=$::S{131};
				}

				if (($var eq "album_dir") && !(-d $value))
				{
					$notes=$::S{131};
				}

				if (($var eq "module_path") && !(-d $value))
				{
					$notes=$::S{131};
				}

				if (($var eq "template_dir") && !(-d $value))
				{
					$notes=$::S{131};
				}

				if (($var eq "membersdir") && !(-d $value))
				{
					$notes=$::S{137};
				}

				if (($var eq "img_dir") && !(-d $value))
				{
					$notes=$::S{131};
				}

				if (($var eq "imagemagick") && $value && !(-d $value))
				{
					$configwarning=$::S{198};
				}

				# Check to see that files are readable
				if (($var eq "album_template") && !(-r "$::template_dir/$value"))
				{
					$notes=$::S{133};
				}

				if (($var eq "photo_template") && !(-r "$::template_dir/$value"))
				{
					$notes=$::S{133};
				}

				if (($var eq "object_template") && !(-r "$::template_dir/$value"))
				{
					$notes=$::S{133};
				}

				if (($var eq "upload_template") && !(-r "$::template_dir/$value"))
				{
					$notes=$::S{133};
				}

				if (($var eq "login_template") && !(-r "$::template_dir/$value"))
				{
					$notes=$::S{133};
				}

				if (($var eq "auth_db") && !(-r $value))
				{
					$configwarning=$::S{140};
				}

				if (($var eq "photo_icon") && !(-r "$::img_dir/$value"))
				{
					$configwarning=$::S{147};
				}

				if (($var eq "movie_icon") && !(-r "$::img_dir/$value"))
				{
					$configwarning=$::S{148};
				}

				if (($var eq "album_icon") && !(-r "$::img_dir/$value"))
				{
					$configwarning=$::S{149};
				}

				if (($var eq "album_folder_icon") && !(-r "$::img_dir/$value"))
				{
					$configwarning=$::S{149};
				}

				if (($var eq "login_button") && !(-r "$::img_dir/$value"))
				{
					$configwarning=$::S{149};
				}

				if (($var eq "logout_button") && !(-r "$::img_dir/$value"))
				{
					$configwarning=$::S{149};
				}

				if (($var eq "home_button") && !(-r "$::img_dir/$value"))
				{
					$configwarning=$::S{149};
				}

				if (($var eq "search_button") && !(-r "$::img_dir/$value"))
				{
					$configwarning=$::S{149};
				}

				if (($var eq "random_button") && !(-r "$::img_dir/$value"))
				{
					$configwarning=$::S{149};
				}

				if (($var eq "upload_button") && !(-r "$::img_dir/$value"))
				{
					$configwarning=$::S{149};
				}

				if (($var eq "recent_button") && !(-r "$::img_dir/$value"))
				{
					$configwarning=$::S{149};
				}

				if (($var eq "rate_button") && !(-r "$::img_dir/$value"))
				{
					$configwarning=$::S{149};
				}

				if (($var eq "email_button") && !(-r "$::img_dir/$value"))
				{
					$configwarning=$::S{149};
				}

				if (($var eq "small_button") && !(-r "$::img_dir/$value"))
				{
					$configwarning=$::S{149};
				}

				if (($var eq "medium_button") && !(-r "$::img_dir/$value"))
				{
					$configwarning=$::S{149};
				}

				if (($var eq "large_button") && !(-r "$::img_dir/$value"))
				{
					$configwarning=$::S{149};
				}

				if (($var eq "fullsize_button") && !(-r "$::img_dir/$value"))
				{
					$configwarning=$::S{149};
				}

				if (($var eq "fullscreen_button") && !(-r "$::img_dir/$value"))
				{
					$configwarning=$::S{149};
				}

				if (($var eq "edit_button") && !(-r "$::img_dir/$value"))
				{
					$configwarning=$::S{149};
				}

				if (($var eq "delete_button") && !(-r "$::img_dir/$value"))
				{
					$configwarning=$::S{149};
				}

				if (($var eq "move_button") && !(-r "$::img_dir/$value"))
				{
					$configwarning=$::S{149};
				}

				if (($var eq "link_button") && !(-r "$::img_dir/$value"))
				{
					$configwarning=$::S{149};
				}

				if (($var eq "config_button") && !(-r "$::img_dir/$value"))
				{
					$configwarning=$::S{149};
				}

				if (($var eq "create_button") && !(-r "$::img_dir/$value"))
				{
					$configwarning=$::S{149};
				}

				if (($var eq "titles_button") && !(-r "$::img_dir/$value"))
				{
					$configwarning=$::S{149};
				}

				if (($var eq "updates_button") && !(-r "$::img_dir/$value"))
				{
					$configwarning=$::S{149};
				}

				if (($var eq "adminupload_button") && !(-r "$::img_dir/$value"))
				{
					$configwarning=$::S{149};
				}

				if (($var eq "thumb_button") && !(-r "$::img_dir/$value"))
				{
					$configwarning=$::S{149};
				}

				if (($var eq "popular_button") && !(-r "$::img_dir/$value"))
				{
					$configwarning=$::S{149};
				}

				# Check to see that files are writable
				if (($var eq "notify_file") && !(-w $value))
				{
					$configwarning=$::S{134};
				}

				if (($var eq "album_dir") && !(-w $value))
				{
					$configwarning=$::S{132};
				}

				if (($var eq "upload_logfile") && !(-w $value))
				{
					$notes=$::S{135};
				}

				# Check to see that "required" vars have a value
				if (($var eq "upload_logfile") && !$value)
				{
					$configwarning=$::S{136};
				}

				if (($var eq "\@::imgexts") && !$value)
				{
					$configwarning=$::S{141};
				}

				if (($var eq "\@::movieexts") && !$value)
				{
					$configwarning=$::S{142};
				}

				if (($var eq "\thumbprefix") && !$value)
				{
					$notes=$::S{290};
				}

				# Check to see that programs are executable
				if (($var eq "jhead") && $value && !(-x $value))
				{
					$configwarning=$::S{138};
				}

				# Ensure that function codes are not set to the default
				if (($var eq "admin") && ($value eq "admin"))
				{
					$notes=$::S{143};
				}

				if (($var eq "config") && ($value eq "config"))
				{
					$notes=$::S{143};
				}

				if (($var eq "updateconfig") && ($value eq "updateconfig"))
				{
					$configwarning=$::S{143};
				}

				if (($var eq "update_desc") && ($value eq "update_desc"))
				{
					$configwarning=$::S{144};
				}

				if (($var eq "update_rating") && ($value eq "update_rating"))
				{
					$configwarning=$::S{145};
				}

				if (($var eq "enter_desc") && ($value eq "enter_desc"))
				{
					$notes=$::S{146};
				}

				if (($var eq "debug_code") && ($value eq "debug"))
				{
					$notes=$::S{143};
				}

				# Make sure none of the function codes are null
				if (($var eq "admin" || $var eq "config" || $var eq "updateconfig" || $var eq "enter_desc" || $var eq "update_desc" || $var eq "upload" || $var eq "update_rating" || $var eq "rating_form" || $var eq "debug_code" || $var eq "login_code") && !$value)
				{
					$notes=$::S{227};
				}

				# Set field size
				$paramsize=length($value)+5;

				if ($showSection)
				{
					$configHTML.=<<HTML;
</td><td>
HTML
				}

				if ($guessed)
				{
					$configHTML.="* ";
				}
				if ($readonly)
				{
					$configHTML.="$value";
				}
				else
				{
				my $qutoedvalue=$value;

					# Convert quotes to &quot;
					$qutoedvalue=~s/"/&quot;/g;

					$configHTML.="<input type=\"";
					if ($showSection)
					{
						$configHTML.="text";
					}
					else
					{
						$configHTML.="hidden";
					}
					$configHTML.="\" name=\"$var\" size=\"$paramsize\" value=\"$qutoedvalue\" />\n";
				}

				if ($showSection)
				{
					if ($notes)
					{
						$configHTML.="<br /><font color=\"$stopcol\">$::S{125} $notes</font>";
					}
					if ($configwarning)
					{
						$configHTML.="<br /><font color=\"$warncol\">$::S{150} $configwarning</font>";
					}
					$configHTML.=<<HTML;
	</td>
</tr><p>
HTML
				}

				# Reset warnings and errors
				$notes="";
				$configwarning="";
			}
			$help="";
		}

		$prevline=$data;
	}

	close(CONFIG);

	# Add static options
	$configJump.="<OPTION value=\"$::S{152}\">$::S{152}</OPTION>";
	if ($::authentication_type eq 1)
	{
		$configJump.="<OPTION value=\"$::S{300}\">$::S{300}</OPTION>";
	}

	# Close config jump station
	$configJump.="</SELECT>";
	$configJump.="</form>\n";

	$::function=$::updateconfig;
	$data=passVars(1);
	$configHTML.=<<HTML;
</table>
$data
<p>
HTML

	# If configfile is not writable, then warn user
	if ($readonly)
	{
		$configHTML.="$::S{125} $::configfile $::S{151}";
	}
	else
	{
		if ($configSection eq $::S{152} || !$configSection)
		{
			$configHTML.=<<HTML;
<h2>$::S{152}</h2>
$::S{153}
<table border=1 cellpadding="5" cellspacing="0" bordercolor="#111111">
<br />
<tr><td>$::S{154}</td><td>$::S{155}</td><td>$::S{156}</td><td>$::S{157}<br />
</td>
</tr>
<tr><td>
$::S{158}</td><td>$::S{159}</td><td>$::S{160}</td><td>$::S{161}
<br />
</td>
</tr>
<tr><td>
$::S{162}</td><td>
<input type="text" name="newconfigcomments" size=75 />
</td><td>
<input type="text" name="newconfigitem" />
</td><td>
<input type="text" name="newconfigvalue" />
</td></table>
HTML
		}

		# Show registration form
		if ($::newconfig eq "true")
		{
			$configHTML.=<<HTML;
<h2>$::S{163}</h2>
<p>
$::S{164}
<p>
$::S{165}
<p>
<table border=1 cellpadding="5" cellspacing="0" bordercolor="#111111">
<br />
<tr><td>$::S{166}</td><td><input type="text" name="regemail" /></td>
</tr>
</table>
HTML
		}

		# Only show apply buttons if we're not editing the user list (it has it's own apply button)
		if ($::S{300} ne $configSection && $configSection ne $secretCode)
		{
			$configHTML.=<<HTML;
<p><center>
<input type="submit" value="$::S{167}" name="Apply" class="button" />
<input type="submit" value="$::S{168}" name="ReloadRequested" class="button" />
</center>
</form>
HTML
		}
	}

	# Show the "Edit users" box (for flatfile authentication)
	if ($configSection eq $::S{300} || !$configSection)
	{
		$configHTML.=showUserEdit();
	}

	$configHTML.=showFooter(0);

	$configHTML=~s/####CONFIGJUMP####/$configJump/g;

	print $configHTML;

	exit(0);
}


##########################################################################

=head3 updateConfig()

 updateConfig();

Updates the settings in $configfile, when the form displayed in showConfig is submitted.

=cut
sub updateConfig
{
my $data;
my $var;
my $value;
my $response;
my $temp;
my $virtualfile="";

	if ($form->param('ReloadRequested'))
	{
		# Refresh config
		print showConfig();
		exit(0);
	}

	# Register
	if ($::newconfig eq "true")
	{
		$temp=$0;

		# Change all \'s to /'s
		$temp=~s/\\/\//g;

		# Drop the preceeding path
		$temp=~s/.*\/(.*)/$1/;

		$response=$form->param('cgi_web');

		$temp="$response/$temp";

		$response=regConnect($form->param('regemail'),$temp);
	}

	# Ensure we have some data to write out
	if (!$form->param('cgi_dir'))
	{
		$::warning.="$::S{306}";
	}
	else
	{
		# Open the configfile
		open(CONFIG,"$::configfile") || error(__LINE__,"no_config","$::configfile: $!",$::admin_module);

		while ($data=<CONFIG>)
		{
			chomp($data);
			if ($data=~/(@*\w+)=(.*)/ && $data!~/^#/)
			{
				$var=$1;
				$value=$form->param($var);
				$virtualfile.="$var=$value\n";
				debug("Writing updated line: [$var=$value]",3,__LINE__,$::admin_module);
			}
			else
			{
				$virtualfile.="$data\n";
				debug("Writing line: [$data]",4,__LINE__,$::admin_module);
			}
		}

		# Add new config item, if there is one...
		if ($form->param('newconfigitem'))
		{
			$::comments=$form->param('newconfigcomments');
			$var=$form->param('newconfigitem');
			$value=$form->param('newconfigvalue');
			$virtualfile.="\n# $::comments\n$var=$value\n";
		}

		close(CONFIG);

		# Re-open config file and write out new contents
		open(CONFIG,">$::configfile") || error(__LINE__,"not_writable","$::configfile",$::admin_module);
		print CONFIG $virtualfile;
		close(CONFIG);
	}

	# Re-read config to get newly written values...
	readConfig($::configfile);

	# Display menu after config is updated
	print "<head><title>album.pl - $::S{52}</title>";

	$data=printHeader();

	# Clear function and get any vars
	$::function="";
	$temp=passVars(0);

	print <<HTML;
$data
<h1>$::S{52}</h1>
<p>
$::S{169}
<ul>
<li><a href=\"$::albumprog?full=1$temp\">$::S{170}</a>
<li><a href=\"$::albumprog?function=$::enter_desc$temp\">$::S{50}</a>
<li><a href=\"$::albumprog?function=$::admin$temp\">$::S{171}</a>
<li><a href=\"$::albumprog?function=$::upload$temp\">$::S{172}</a>
<li><a href=\"$::albumprog?function=$::config$temp\">$::S{173}</a>
</ul>
HTML

	showFooter(1);

	# Now exit
	exit(0);
}


######################## END OF SUBROUTINES ########################

######################## END OF FILE ########################

1;