#!/usr/bin/perl --
# $Id: album_recent.pm,v 1.2 2004/09/13 15:28:10 bobbitt Exp $

######################## START OF POD ########################

=head1 NAME

recent.pm - recent upload, random photo and popular functions for album.pl.

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

=head3 recentUploads()

 $recent_html=recentUploads();

 $recent_html - Contains the HTML for the recent uploads table.

Returns HTML for the last $::recent_uploads number of uploads, as read from $::upload_logfile.

=cut
sub recentUploads
{
my $count=$::recent_uploads;
my $data;
my $filetemp;
my $photoinf;
my $temp;
my $allphotos;
my @photoarray;
my @timearray;
my @userarray;
my $recent_html;
my $allusers;
my $alltimes;
my $tempalbum;
my $tempmiddle;
my $tempgoback;
my $realcount;
my $showall=$form->param('showall');

	# Do a sanity check first...
	if (!$::upload_logfile || !$::recent_uploads || !-r $::upload_logfile)
	{
		return($::S{194});
	}

	$tempalbum=$::album;
	$tempmiddle=$::middle;
	$tempgoback=$::goback;
	$::album=$::middle=$::goback="";
	$::isimage=1;

	if ($::ssi)
	{
		$count=$::ssi;
	}

	open(UPLOADLOG,"$::upload_logfile") || error(__LINE__,"not_readable","$::upload_logfile: $!",$::recent_module);
	while ($data=<UPLOADLOG>)
	{
		$realcount++;
		chomp($data);
		debug("\$data=$data",3,__LINE__,$::recent_module);

		# Get Photo Info
		$photoinf=$data;
		$photoinf=~s/.+\t[^\t]+\t[^\t]+\t([^\t]+)/$1/;
		debug("\$photoinf(photo)=$photoinf",3,__LINE__,$::recent_module);

		if ($allphotos)
		{
			$allphotos="$photoinf\t$allphotos";
		}
		else
		{
			$allphotos=$photoinf;
		}

		# Get User Info
		$photoinf=$data;
		$photoinf=~s/.+\t[^\t]+\t([^\t]+)\t[^\t]+/$1/;
		debug("\$photoinf(user)=$photoinf",3,__LINE__,$::recent_module);

		if ($allusers)
		{
			$allusers="$photoinf\t$allusers";
		}
		else
		{
			$allusers=$photoinf;
		}

		# Get Time Info
		$photoinf=$data;
		$photoinf=~s/(.+)\t[^\t]+\t[^\t]+\t[^\t]+/$1/;
		debug("\$photoinf(times)=$photoinf",3,__LINE__,$::recent_module);

		if ($alltimes)
		{
			$alltimes="$photoinf\t$alltimes";
		}
		else
		{
			$alltimes=$photoinf;
		}
	}
	close(UPLOADLOG);

	debug("Loaded the upload log file entries.",2,__LINE__,$::recent_module);
	debug("\$allphotos=$allphotos",4,__LINE__,$::recent_module);

	@photoarray=split("\t",$allphotos);
	@photoarray=reverse @photoarray;
	@timearray=split("\t",$alltimes);
	@timearray=reverse @timearray;
	@userarray=split("\t",$allusers);
	@userarray=reverse @userarray;

	# Use "showall=x" to show x photos
	if ($showall gt 1)
	{
		$count=$showall;
		$showall=0;
	}

	while ($realcount gt 0)
	{
		$photoinf=pop @photoarray;
		$alltimes=pop @timearray;
		$allusers=pop @userarray;

		debug("\$photoinf=$photoinf ($::thumbprefix)",3,__LINE__,$::recent_module);
		debug("\$allusers=$allusers",3,__LINE__,$::recent_module);
		debug("\$alltimes=$alltimes",3,__LINE__,$::recent_module);

		$temp=showObject($photoinf,1,$allusers,$alltimes);

		# Decrement counter if something was returned
		if ($temp)
		{
			$count--;
			$recent_html.=$temp;
		}

		# If we've displayed all the "most recent" uploads, stop reading from the log
		if (!$count)
		{
			$realcount=0;
		}

		# Increment counter back up if we're showing all recent uploads
		if ($showall)
		{
			$count++;
		}

		$realcount--;

		debug("\$count=$count",3,__LINE__,$::recent_module);
		debug("\$photoinf=$photoinf",3,__LINE__,$::recent_module);
	}

	if (!$showall && !$::ssi)
	{
		# Show More link
		$recent_html.="<br /><br />\n<a href=\"$::albumprog?album=$::recent_upload_album";
		$recent_html.=passVars(0);
		$recent_html.=$::webdelim."showall=30\" class=\"optionslink\">$::S{291}</a>";
	}

	$::album=$tempalbum;
	$::middle=$tempmiddle;
	$::goback=$tempgoback;

	return($recent_html);
}


##########################################################################

=head3 randomizer()

 $photo=randomizer();

 $photo - Returned path (from album root) to a random photo.

Returns the path to a random image in the album.

=cut
sub randomizer
{
my $randpic;
my $rnd;
my $doing_upload_temp;

	debug("Entering subroutine: randomizer()",4,__LINE__,$::recent_module);

	$doing_upload_temp=$::doing_upload;
	$::doing_upload=2;
	recursiveScan($::album_dir);

	# Count total number of objects
	$rnd=($#::total_photo_list)+1;

	debug("Objects ($rnd total): [@::total_photo_list]",2,__LINE__,$::recent_module);

	$rnd=int rand($rnd);

	$randpic=@::total_photo_list[$rnd];

	debug("Picked dir #$rnd [$randpic]",2,__LINE__,$::recent_module);

	$::doing_upload=$doing_upload_temp;

	debug("Leaving subroutine: randomizer()",4,__LINE__,$::recent_module);

	return($randpic);
}


##########################################################################

=head3 searchForm()

 $html=searchForm();

 $html - The search results, formatted in HTML.

Returns the search web form.

=cut
sub searchForm
{
my $html;

	$html=<<HTML;
<br /><br />
<form method="POST" action="$::albumprog">
$::S{281}
<input type="text" name="searchstring" size="20"><br />
<div class="subtext">$::S{282}
<input type="checkbox" name="searchfilenames" value="searchfilenames" checked class="checkbox" />$::S{283}&nbsp;
<input type="checkbox" name="searchdescriptions" value="searchdescriptions" checked class="checkbox" />$::S{284}&nbsp;
<input type="checkbox" name="searchcomments" value="searchcomments" checked class="checkbox" />$::S{285}
<input type="checkbox" name="searchowners" value="searchowners" checked class="checkbox" />$::S{289}</div><br />
<br /><input type="submit" value="$::S{280}" name="submit" class=\"button\" />
HTML

	$html.=passVars(1);

	$html.=<<HTML;
</form>
HTML

	return ($html);
}


##########################################################################

=head3 search()

 $html=search();

 $html - The search results, formatted in HTML.
 $searchstring - The search string to look for.
 $searchfilenames - Search photo filenames for a match, if non-zero.
 $searchdescriptions - Search descriptions.txt for a match, if non-zero.
 $searchcomments - Search ratings.txt (user comments for a match, if non-zero.
 $searchowners -Search descriptions.txt for matching users, if non-zero.

Searches for $newsearchstring in the locations defined by the combination of $searchxxx arguments, and returns all matching photos as formatted $html.

=cut
sub search
{
my $html;
my $result;
my $last_item;

	debug("Entering subroutine: search($::searchstring,$::searchfilenames,$::searchdescriptions,$::searchcomments,$::searchowners)",4,__LINE__,$::recent_module);

	debug("searchstring: $::searchstring",2,__LINE__,$::recent_module);
	debug("searchfilenames: $::searchfilenames",2,__LINE__,$::recent_module);
	debug("searchdescriptions: $::searchdescriptions",2,__LINE__,$::recent_module);
	debug("searchcomments: $::searchcomments",2,__LINE__,$::recent_module);
	debug("searchowners: $::searchowners",2,__LINE__,$::recent_module);

	$::doing_upload=1;
	recursiveScan($::album_dir);
	#doing_upload=0;

	# Sort search results
	sort(@::searchresults);

	# Show each item
	$tbcount=0;
	$html.="<table><tr>";

	foreach $result (@::searchresults)
	{
		if ($result ne $last_item)
		{
			debug("Displaying search result: $result",2,__LINE__,$::recent_module);
			$html.="<td>";	
			$html.=showObject($result);
			if ($tbcount==5)
  		{
				$html.="</td></td></td></td></td></tr><tr>";
				$tbcount=0;         
			}
  			$tbcount++;
		}
		$last_item=$result;
	}

	if (!$::searchresults)
	{
		$::searchresults=0;
	}
	$html.="</td></tr></table><br />$::searchresults $::S{288}\n<br clear=\"all\">\n";

	$::shortdesc=$::S{280};
	$::photo=$::album=$::longdesc="";

	debug("Leaving subroutine: search($::searchstring,$::searchfilenames,$::searchdescriptions,$::searchcomments,$::searchowners)",4,__LINE__,$::recent_module);

	return($html);
}


##########################################################################

=head3 popular()

 $html=popular();

 $html - The "Most Popular" results, formatted in HTML.

Searches for the $::most_popular number of Most popular photos, and returns the HTML for them.

=cut
sub popular
{
my $html;
my $temphtml;
my $key;
my $current_count;
my $num_ratings;
my $current_rating;
my $filename;
my @keys;
my @popsortlist;
my $score;
my $overall_popularity;

	debug("Entering subroutine: popular()",4,__LINE__,$::recent_module);

	$html="";

	$::doing_upload=1;
	recursiveScan($::album_dir);
	#doing_upload=0;

	@keys=keys %::poplist;
	debug("*** Start PopList Contents",3,__LINE__,$::recent_module);
	foreach $key (@keys)
	{
		# Clear re-used vars
		$score=$num_ratings=$current_rating=$current_count=0;

		($num_ratings,$current_rating,$current_count)=split("\t",$::poplist{$key});

		# Adjust for albums
		if ($::popular_flag eq 2)
		{
		my $total;
			$total=$::popcount{$key};
			$num_ratings=int($num_ratings/$total);
			$current_rating=int($current_rating/$total*100)/100;
			$current_count=int($current_count/$total);
		}

		$score=popularityContest($num_ratings,$current_rating,$current_count);

		# Put it into the popular array
		push @popsortlist,"$score\t$key\t$num_ratings\t$current_rating\t$current_count";

		debug("$key: [$num_ratings,$current_rating,$current_count]: $score",3,__LINE__,$::recent_module);
	}
	debug("*** End PopList Contents",3,__LINE__,$::recent_module);

	# Sort
	@keys=sort(@popsortlist);

	for($key=0;$key <= $::most_popular;$key++)
	{
		if ($key)
		{
			# Clear re-used vars
			$score=$num_ratings=$current_rating=$current_count=0;

			($score,$filename,$num_ratings,$current_rating,$current_count)=split("\t",pop(@keys));
			debug("Pulling out of 'Most Popular List': $score,$filename,$num_ratings,$current_rating,$current_count",3,__LINE__,$::recent_module);
			debug("$key/$::most_popular",3,__LINE__,$::recent_module);

			if ($filename)
			{

				# Get object HTML
				$html.=showObject($filename,2);

				# Add rating/views info
				$temphtml="<p class=\"popular\">";

				# Add popularity
				$overall_popularity++;
				$temphtml.="$::S{274}$::S{221} $overall_popularity<br />\n";

				if ($current_rating || $num_ratings)
				{
					$temphtml.="$::S{175} ";
				}
				if ($current_rating)
				{
					$temphtml.="$current_rating";
				}
				if ($current_rating && $num_ratings)
				{
					$temphtml.=" (";
				}
				if ($num_ratings)
				{
					$temphtml.="$num_ratings";
				}
				if ($current_rating || $num_ratings)
				{
					$temphtml.=" $::S{202}";
				}
				if ($current_rating && $num_ratings)
				{
					$temphtml.=")";
				}
				if ($current_count && ($current_rating || $num_ratings))
				{
					$temphtml.=" - ";
				}
				if ($current_count)
				{
					$temphtml.="$::S{94} $current_count $::S{202}";
				}
				if ($current_count || $current_rating || $num_ratings)
				{
					$temphtml.=".";
				}
				$temphtml.="</p>";

				if (!$::ssi && $html)
				{
					$html.=$temphtml."<p />\n";
				}
			}
		}
	}

	$::shortdesc="$::most_popular $::S{271}";
	$::photo=$::album=$::longdesc="";

	debug("Leaving subroutine: popular()",4,__LINE__,$::recent_module);

	return($html);
}


##########################################################################

=head3 getPopularViews()

 getPopularViews($directory);

 $directory - Directory to check views information for.

Reads all views information from $directory, and populats @poplist (the list of popular files).

=cut
sub getPopularViews
{
my $directory=shift;
my $data;
my $current_count;
my $filename;
my $read_date;
my $fulldirectory;
my $poppic;
my $poplistkey;
my $temp1;
my $temp2;
my $temp3;
my @poppics;
my $keep_this_one;

	debug("Entering subroutine: getViews($directory);",4,__LINE__,$::recent_module);

	# Add full path
	$fulldirectory="$::album_dir/$directory";

	# Reset vars
	$temp1=$temp2=$temp3=0;

	open(VIEWS,"$fulldirectory/$::viewfile") || return();

	while ($data=<VIEWS>)
	{
		($filename,$current_count,$read_date)=split("\t",$data);

		# Are we using galleries or photos?
		if ($::popular_flag eq 2)
		{
			$poplistkey="$directory";
		}
		else
		{
			$poplistkey="$directory/$filename";
		}

		# Check to see that it still exists before adding it to the list
		if (-e "$::album_dir/$directory/$filename")
		{

			# Clear existing vars
			$temp1=$temp2=$temp3=$keep_this_one=0;

			#Only add it if we have permission
			if(isViewable("$::album_dir/$directory",$filename,"1"))
			{
				# Add existing values to get a total for the gallery
				if ($::poplist{"$poplistkey"})
				{
					($temp1,$temp2,$temp3)=split("\t",$::poplist{"$poplistkey"});
					$current_count+=$temp3;
				}

				$::popcount{"$poplistkey"}++;

				$::poplist{"$poplistkey"}="$temp1\t$temp2\t$current_count";
			}
		}
		debug("TrackDebug: $filename,$current_count,$read_date",3,__LINE__,$::recent_module);

	}

	close(VIEWS);

	debug("Leaving subroutine: getViews($directory);",4,__LINE__,$::recent_module);
}


##########################################################################

=head3 popularityContest()

 $score=popularityContest($num_ratings,$current_rating,$current_count);

 $html - The "Most Popular" results, formatted in HTML.
 $num_ratings - Number of ratings for this object.
 $current_rating - Object's current ratings.
 $current_count - Number of times this object has been viewed.

Takes as input the ratings and views info, and makes a popularity score out of it. The current formula is:

	(($current_rating-2.5) * $num_ratings) + ($current_count / 20)

If you don't like that formula, modify it here.

=cut
sub popularityContest
{
my $num_ratings=shift;
my $current_rating=shift;
my $current_count=shift;
my $padlimit=6;
my $score;

	$score=(($current_rating-2.5)*$num_ratings)*20+$current_count;

	# Pad scores so they sort properly
	while (length($score) lt $padlimit)
	{
		$score="0".$score;
	}

	debug("Popularity Score is: <b>$score</b>",4,__LINE__,$::recent_module);
	return($score);
}

##########################################################################
######################## END OF SUBROUTINES ########################

######################## END OF FILE ########################

1;