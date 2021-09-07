#!/usr/bin/perl --
# $Id: album_ratings.pm,v 1.3 2004/09/13 15:28:10 bobbitt Exp $

######################## START OF POD ########################

=head1 NAME

upd_rating.pm - update ratings, update descriptions and delete descriptions functions for album.pl.

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

=head3 updateRating()

 updateRating($myobject,$rating_file_loc,$rating,$comments);

 $myobject - Object to add a rating to
 $rating_file_loc - Location of the ratings file
 $rating - The numerical rating
 $comments - Comments (optional)

Updates the ratings for the object supplied, using the rating and comments supplied.

=cut
sub updateRating
{
my $myobject=shift;
my $rating_file_loc=shift;
my $rating=shift;
my $new_comments=shift;
my $updated_ratings;
my $data;
my $current_rating;
my $current_photo;
my $tempfilename;
my $comments;
my $virtualfile="";
my $filename="";
my $current_ratingfile="$::album_dir/$rating_file_loc/$::ratingfile";

	if ($rating_file_loc eq $::rootalbumname)
	{
		$current_ratingfile="$::album_dir/$::ratingfile";
	}

	debug("Updating ratings for $myobject in $current_ratingfile",2,__LINE__,$::ratings_module);

	if ($new_comments)
	{
		# Strip out HTML from comments
		$new_comments=~s/<([^>]|\n)*>//g;

		# Stip line breaks out of comments.
		$new_comments=~s/[\n\r]/<br \/>/g;
	}

	# Does it already exist?
	if (-e $current_ratingfile)
	{
	my $searchmyobject=quotemeta($myobject);
		# Open $::viewfile for reading
		open(RATINGS,"$current_ratingfile") || error(__LINE__,"not_readable","$current_ratingfile",$::ratings_module);

		# have not updated views
		$updated_ratings=0;

		while ($data=<RATINGS>)
		{
			# Check to see if this is the one we want
			if ($data=~/^$searchmyobject\t.*/)
			{
				chomp($data);
				debug("Found match: $data",3,__LINE__,$::ratings_module);
				($filename,$::num_ratings,$current_rating,$comments)=split("\t",$data);
				debug("Data: [$data] --> Ratings:[$::num_ratings] Rating:[$current_rating] Comments:[$comments]",4,__LINE__,$::ratings_module);
				$comments="$comments<br />$new_comments";

				# Calculate new average rating
				$current_rating=floor((($current_rating*$::num_ratings+$rating)/($::num_ratings+1))*100)/100;
				$::num_ratings++;
				$virtualfile.="$myobject\t$::num_ratings\t$current_rating\t$comments\n";
				$updated_ratings=1;
			}
			else
			{
				debug("Wrote: $data",4,__LINE__,$::ratings_module);
				$virtualfile.=$data;
			}
		}

		# If the photo didn't already hav an entry, add it now.
		if (!$updated_ratings)
		{
			debug("No entry found, adding one.",2,__LINE__,$::ratings_module);
			$virtualfile.="$myobject\t1\t$rating\t$new_comments\n";
		}

		close(RATINGS);

		# Re-open ratings file and write out new contents
		open(RATINGS,">$current_ratingfile") || error(__LINE__,"not_writable","$current_ratingfile",$::ratings_module);
		print RATINGS $virtualfile;
		close(RATINGS);

	}
	else
	{
		debug("$current_ratingfile does not exist, creating...",2,__LINE__,$::ratings_module);
		open(RATINGS,">$current_ratingfile") || error(__LINE__,"not_writable","$current_ratingfile",$::ratings_module);
		print RATINGS "$myobject\t1\t$rating\t$new_comments\n";
		close(RATINGS);
	}

	# Return to photo/album
	if (isAPhotoOrJp2($myobject))
	{
		$::album="";
		$::photo="$rating_file_loc/$myobject";
	}
	else
	{
		$::album="$::album_dir/$rating_file_loc";
		if ($rating_file_loc eq $::rootalbumname)
		{
			$::album=$::album_dir;
		}
	}
	$::function="";
}


##########################################################################

=head3 updateDesc()

 updateDesc($myobject,$desc_file_loc,$title,$description,$myowner,$view_level);

 $myobject - The object whose description is being updated
 $desc_file_loc - The location of the descfile to update
 $title - The new title to apply to the object
 $description - The new long description to apply to the object
 $myowner - The new owner of the object
 $view_level - The membership level required to view this object

Updates the $::descfile located in $desc_file_loc for the item $myobject, with the information passed in through the web form.

=cut
sub updateDesc
{
my $added_desc;
my $data;
my $skip;
my $oldowner;
my $old_view_level;
my $olddata;
my $virtualfile;
my $myobject=shift;
my $desc_file_loc=shift;
my $title=shift;
my $description=shift;
my $myowner=shift;
my $view_level=shift;

	debug("Entering subroutine: updateDesc($myobject,$desc_file_loc,$title,$description,$myowner,$viewlevel)",4,__LINE__,$::ratings_module);

	# If there's no title, make it the filename
	if (!$title)
	{
		$title=$myobject;
	}

	# Yep, so update the description file, and then display everything normally
	debug("Updating description for $myobject in $desc_file_loc. Title is [$title], description is [$description].",2,__LINE__,$::ratings_module);

	if (!$myobject || !$desc_file_loc)
	{
		error(__LINE__,"sanity","Not enough info to update description.",$::ratings_module);
	}

	# Open the description file specified
	openDescfile($desc_file_loc);

	# have not added desc
	$added_desc=0;

	# am not skipping
	$skip=0;

	# Clear "virtual file"
	$virtualfile="";

	while ($data=<DESC>)
	{
		chomp($data);
		debug("Data: [$data]; \$skip=$skip",4,__LINE__,$::ratings_module);

		$olddata=$data;

		# Pull out owner and view level
		($data,$oldowner,$old_view_level)=split(":",$data);
#		if($oldowner && !$old_view_level)
#		{
#			$old_view_level=$oldowner;
#			$oldowner="";
#		}

		debug("$oldowner owns $data",2,__LINE__,$::ratings_module);
		debug("obect level is $old_view_level",2,__LINE__,$::ratings_module);

		# Check to see if this is the one we want
		if ($data eq $myobject && !$skip)
		{
			debug("Found match: $data",3,__LINE__,$::ratings_module);

			# Make sure we can do this...
			if ($::function eq $::update_desc || $::function eq $::admin || (($myowner eq $::loggedin || $::default_admins=~/(.*,)*$::loggedin(,.*)*/) && $::loggedin))
			{

				debug("Updating Description...",3,__LINE__,$::ratings_module);

				# If nobody is taking control of this, and someone already owned it, then don't clear the owner
				if (!$myowner && $oldowner)
				{
					$myowner=$oldowner;
				}
#				# If no level specified, keep old level
#				if (!$view_level && $old_view_level)
#				{
#					$view_level=$old_view_level;
#				}

				$virtualfile.=$myobject;
				if ($myowner)
				{
					debug("Writing Owner: $myowner",3,__LINE__,$::ratings_module);
					$virtualfile.=":$myowner";
				}
				else
				{
					debug("No owner provided",3,__LINE__,$::ratings_module);
				}
				if ($view_level)
				{
					if (!$myowner)
					{
						$virtualfile.=":";
					}
					debug("Writing View Level: $view_level",3,__LINE__,$::ratings_module);
					$virtualfile.=":$view_level";
				}
				else
				{
					debug("No view level provided",3,__LINE__,$::ratings_module);
				}
				$virtualfile.="\n";
				$virtualfile.=$title;
				$virtualfile.="\n";
				if ($description)
				{
					$virtualfile.=$description;
					$virtualfile.="\n";
				}

				# skip reading until the next $::desc_delim
				$skip=1;
			}

			# don't re-add the desc at the end
			$added_desc=1;
		}

		# we found the next entry, stop skipping
		if ($skip && ($data eq $::desc_delim))
		{
			debug("Stopped skipping.",4,__LINE__,$::ratings_module);
			$skip=0;
		}

		# Only write if we're not skipping
		if (!$skip)
		{
			debug("Wrote: $olddata",4,__LINE__,$::ratings_module);
			$virtualfile.="$olddata\n";
		}
	}

	# If the description wasn't added, do it now.
	if (!$added_desc)
	{
		debug("No description found, adding one.",4,__LINE__,$::ratings_module);
		$virtualfile.="$::desc_delim\n";
		$virtualfile.=$myobject;
		if ($myowner)
		{
			debug("Writing Owner: $myowner",3,__LINE__,$::ratings_module);
			$virtualfile.=":$myowner";
		}
		else
		{
			debug("No owner provided",3,__LINE__,$::ratings_module);
		}
		if ($view_level)
		{
			if (!$myowner)
			{
				$virtualfile.=":";
			}
			debug("Writing View Level: $view_level",3,__LINE__,$::ratings_module);
			$virtualfile.=":$view_level";
		}
		else
		{
			debug("No view level provided",3,__LINE__,$::ratings_module);
		}
		$virtualfile.="\n";
		$virtualfile.=$title;
		$virtualfile.="\n";
		if ($description)
		{
			$virtualfile.=$description;
			$virtualfile.="\n";
		}
	}

	close(DESC);

	# Re-open descfile and write out new contents
	open(DESC,">$desc_file_loc/$::descname") || error(__LINE__,"not_writable","$desc_file_loc/$::descname",$::ratings_module);
	print DESC $virtualfile;
	close(DESC);

	# Keep on updating
	$::function=$::enter_desc;

	debug("Leaving subroutine: updateDesc($myobject,$desc_file_loc,$title,$description,$myowner,$view_level)",4,__LINE__,$::ratings_module);
}


##########################################################################

=head3 deleteDesc()

 deleteDesc($myobject,$desc_file_loc);

 $myobject - The object whose description is being deleted
 $desc_file_loc - The location of the descfile to modify

Deletes the entry for $myobject from the $::descfile located in $desc_file_loc.

=cut
sub deleteDesc
{
my $data;
my $skip;
my $oldowner;
my $old_view_level;
my $olddata;
my $virtualfile="";
my $myobject=shift;
my $desc_file_loc=shift;

	# Yep, so update the description file, and then display everything normally
	debug("Deleting description for $myobject in $desc_file_loc.",2,__LINE__,$::ratings_module);

	if (!$myobject || !$desc_file_loc)
	{
		error(__LINE__,"sanity","Not enough info to delete description.",$::ratings_module);
	}

	# Open the description file specified
	openDescfile($desc_file_loc);

	# am not skipping
	$skip=0;

	while ($data=<DESC>)
	{
		chomp($data);
		debug("Data: [$data]; \$skip=$skip",4,__LINE__,$::ratings_module);

		$olddata=$data;

		# Pull out owner, view_level
		($data,$oldowner,$old_view_level)=split(":",$data);
#		if($oldowner && !$old_view_level)
#		{
#			$old_view_level=$oldowner;
#			$oldowner="";
#		}

		debug("$oldowner owns $data",2,__LINE__,$::ratings_module);
		debug("object level is $old_view_level",2,__LINE__,$::ratings_module);

		# Check to see if this is the one we want
		if ($data eq $myobject && !$skip)
		{
			debug("Found match: $data",3,__LINE__,$::ratings_module);

			# Make sure we can do this...
			if ($::function eq $::update_desc || $::function eq $::admin || (($::owner eq $::loggedin || $::default_admins=~/(.*,)*$::loggedin(,.*)*/) && $::loggedin))
			{

				debug("Deleting Description...",3,__LINE__,$::ratings_module);

				# skip reading until the next $::desc_delim
				$skip=1;
			}
		}

		# Only write if we're not skipping
		if (!$skip)
		{
			debug("Wrote: $olddata",4,__LINE__,$::ratings_module);
			$virtualfile.="$olddata\n";
		}

		# we found the next entry, stop skipping
		if ($skip && ($data eq $::desc_delim))
		{
			debug("Stopped skipping.",4,__LINE__,$::ratings_module);
			$skip=0;
		}
	}

	close(DESC);

	# Re-open descfile and write out new contents
	open(DESC,">$desc_file_loc/$::descname") || error(__LINE__,"not_writable","$desc_file_loc/$::descname",$::ratings_module);
	print DESC $virtualfile;
	close(DESC);

}


##########################################################################
######################## END OF SUBROUTINES ########################

######################## END OF FILE ########################

1;