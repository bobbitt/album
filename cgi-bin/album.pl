#!/usr/bin/perl --
# $Id: album.pl,v 1.9 2005/03/17 23:44:39 bobbitt Exp $

# Location of config file
###### CHANGE THIS ######
$::configfile="album.cfg";
###### CHANGE THIS ######
# Make sure the config file is readable to the web server

# Program Version
$::ver="6.5";

# NOTE: The doucmentation shown below in the POD (Plain Old Documentation)
# section is meant to be read through !readme.html.

######################## START OF POD ########################

=begin html
<br />Please visit the <a href="http://dev.bobbitt.ca/forums">Support Forums</a> for online support, installation instructions, file formats, tips and more.

=end html

=head1 NAME

album.pl - A dynamically generated web based photo album.

=head1 SYNOPSIS

There are many ways to invoke album.pl:

Normal:
 http://dev.bobbitt.ca/cgi-bin/album.pl

Go to a specific album:
 http://dev.bobbitt.ca/cgi-bin/album.pl?album=albumname

Go to a specific photo:
 http://dev.bobbitt.ca/cgi-bin/album.pl?photo=photoname

Go to the Configuration Management screen:
 http://dev.bobbitt.ca/cgi-bin/album.pl?function=config

Update titles and descriptions:
 http://dev.bobbitt.ca/cgi-bin/album.pl?function=enter_desc

Upload photos or movies:
 http://dev.bobbitt.ca/cgi-bin/album.pl?function=upload

Show the Administration Menu:
 http://dev.bobbitt.ca/cgi-bin/album.pl?function=admin

View photos as part of a slideshow (5 second delay):
 http://dev.bobbitt.ca/cgi-bin/album.pl?slideshow=5

View photos as a full screen slideshow:
 http://dev.bobbitt.ca/cgi-bin/album.pl?slideshow=5;fullscreen=1

Turn on debugging (highest level):
 http://dev.bobbitt.ca/cgi-bin/album.pl?debug=4

Generate static HTML files for each album and photo:
 http://dev.bobbitt.ca/cgi-bin/album.pl?static=1

View recent uploads:
 http://dev.bobbitt.ca/cgi-bin/album.pl?album=:recent

View 15 most recent uploads:
 http://dev.bobbitt.ca/cgi-bin/album.pl?album=:recent;showall=15

View the 10 most recent uploads, formatted for inclusion in other pages:
 http://dev.bobbitt.ca/cgi-bin/album.pl?album=:recent;ssi=10

View a randomly selected photo from the album:
 http://dev.bobbitt.ca/cgi-bin/album.pl?random=1

View a randomly selected photo, formatted for inclusion in other pages:
 http://dev.bobbitt.ca/cgi-bin/album.pl?random=1;ssi=2

View the thumbnail of a randomly selected photo, formatted for inclusion in other pages:
 http://dev.bobbitt.ca/cgi-bin/album.pl?random=1;ssi=1

View randomly selected photos in a slideshow (5 second delay), formatted for inclusion in other pages:
 http://dev.bobbitt.ca/cgi-bin/album.pl?random=1;ssi=2;slideshow=5

View the thumbnails of randomly selected photos in a slideshow (5 second delay), formatted for inclusion in other pages:
 http://dev.bobbitt.ca/cgi-bin/album.pl?random=1;ssi=1;slideshow=5

View a specific photo, formatted for inclusion in other pages:
 http://dev.bobbitt.ca/cgi-bin/album.pl?photo=photoname;ssi=1

View photos in a slideshow (5 second delay), formatted for inclusion in other pages:
 http://dev.bobbitt.ca/cgi-bin/album.pl?photo=photoname;slideshow=5;ssi=1

View randomly selected photo directly (no HTML, just the image itself):
 http://dev.bobbitt.ca/cgi-bin/album.pl?image=random

View randomly selected thumbnail directly (no HTML, just the thumbnail itself):
 http://dev.bobbitt.ca/cgi-bin/album.pl?image=randthumb

View most popular photos:
 http://dev.bobbitt.ca/cgi-bin/album.pl?popular=1

View most popular albums:
 http://dev.bobbitt.ca/cgi-bin/album.pl?popular=2

View thumbnails of 10 most popular photos, formatted for inclusion in other pages:
 http://dev.bobbitt.ca/cgi-bin/album.pl?popular=1;ssi=10

View thumbnails of 10 most popular albums, formatted for inclusion in other pages:
 http://dev.bobbitt.ca/cgi-bin/album.pl?popular=2;ssi=10

Use an alternate configuration file:
 http://dev.bobbitt.ca/cgi-bin/album.pl?configfile=/home/user/www/album.cfg

Give them a try, some are undocumented features! :)

=head1 DESCRIPTION

album.pl is a simple web based program that allows you to simply drop new photo files into a directory, and they will automatically be accessible via the web. It does this by building the photo album on the fly. album.pl uses a simple administration menu to allow you to move or delete photos and albums, as well as adding titles and long descriptions.

Users may upload photos directly into your album, if you permit it.

It can also be used to create static HTML files for certain situations. (This mode is not updated automatically, but is useful for creating a photo CD or viewing pictures without a web server.

To get a feel for all the features and functions, you should see CHANGES.txt.

=head1 INFORMATION

Author: Mike Bobbitt (Mike@Bobbitt.ca), Cipher Logic Canada Inc.

For updates, instructions and examples see http://dev.bobbitt.ca/forums on the web.

=head1 SUPPORT

There is a support forum set up for discussion of album.pl matters. I would recommend that anyone with a support question try searching the forums first. Your question may have already been answered! Otherwise, try posting your question to the forums, where you have the best chance of having it answered. That way, if I am unable to respond right away, it's entirely likely that a peer user will be able to help out. The forums are located at:

http://dev.bobbitt.ca/forums

Once registered with the forums, user are also invited to use the test album, located at http://dev.bobbitt.ca/cgi-bin/album.pl to "test drive" the software. Support questions sent to me by e-mail tend to get a slower response.

Please also note that this is a personal project. I work on it in my spare time, on weekends and evenings, so I'm not always able to respond questions or comments in a timely manner. Expect delays, try to be patient, and remember it's free. ;)

=head1 FAQ

For an up to date list of Frequently Asked Questions and common problems, please see the FAQ section of the support forums:

http://dev.bobbitt.ca/forums/index.php?board=3.0

=head1 TO DO

There are still bugs in this code, so please bear with me, and report any that you find. The complete list of all the things I still want to do with album.pl is located here:

http://dev.bobbitt.ca/forums/index.php?topic=352.0

Any place in the code that I've started (but not finished) a feature, I tried to mark it with a ***.

=head1 LICENSE

This program is © 1999-2004 Cipher Logic Canada Inc. All Rights Reserved.

As long as you leave this POD section and my contact info above in tact, feel free to use this as you see fit. You can pretty much do anything with this script except resell it. :)

If you come up with any good modifications to it, please let me know. I'd love to fold your mod into the public version (with credit, of course).

Good luck!

=head1 APOLOGIES

Here goes:

=over 2

=item *
Sorry for the bugs. Hope they don't ruin your day.

=item *
Sorry that it's so hard to install. It was hard to write, if that helps. :)

=item *
Sorry for the state of the code. Hope you don't learn any of my bad habits!

=item *
Sorry you felt the need to read all of this.

=back

=head1 SUBROUTINES

=cut
######################## END OF POD ########################

######################## START OF SETUP ########################

# Show all script errors to the browser, for easier debugging
use CGI::Carp qw(fatalsToBrowser);

#use strict;
use CGI;

use POSIX qw(ceil floor);
use Cwd;

if (!$::debug)
{
# Set debug level:
#	0 = None
#	1 = Special - Nothing has this code, so you can add a ,1 to any debug statement to make it stand out on it's own
#	2 = Standard - No recursive info or detailed file info. Usually just startup info.
#	3 = Detailed - Some recursive and detailed info.
#	4 = Overwhelming - Everything that ever had a debug turned on.
$::debug=0;
}

# Module names
$::admin_module="album_admin.pm";
$::login_module="album_login.pm";
$::upload_module="album_upload.pm";
$::ratings_module="album_ratings.pm";
$::display_module="album_display.pm";
$::recent_module="album_recent.pm";

# Write output immediately
$|=1;

$form=new CGI;

$::html_header=<<HTML;
Content-Type: text/html


<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">
<html>
HTML

# Get current working directory
$::cwd=cwd;

# Adjust Perl Include Path
if (!-e $::module_path)
{
	$::module_path=$::cwd."/Modules";

	# Still not found... do the unsafe thing...
	if (!-e $::module_path)
	{
		$::module_path="./Modules";
	}
}
unshift(@INC, $::module_path);

# Print HTML Page Header when debugging
if ($::debug)
{
	printHTMLHeader();
}

debug("Home directory is $::cwd",3,__LINE__);
debug("Adding $::module_path to the Perl \@INC path.",2,__LINE__);

# Display Images direcly (for shrouding)
if ($form->param('image'))
{
	readConfig($::configfile);
	print shroudPic($form->param('image'));
	exit(0);
}

# Get browser cookie info
getCookie();

# Check to see if a configfile override was passed in
if ($form->param('configfile'))
{
	$::configfile=$form->param('configfile');

	if ($::configfile=~/[\/\\ @]/ || $::configfile=~/%20/ || $::configfile=~/%2f/ || $::configfile=~/%5c/)
	{
		error(__LINE__,"sanity","Invalid configuration file...");
	}

	if (!-e $::configfile)
	{
		error(__LINE__,"sanity","Invalid configuration file...");
	}

	$::configfilepassed=1;
}

# Load this down into a variable, so we can modify it
$::function=$form->param('function');

debug("\$::function=$::function",2,__LINE__);

# Read configuration file settings
readConfig($::configfile);

# Add config'd module path to Perl include path, or if that's not there, add "Modules" off the current dir
if (!-e $::module_path || !$::module_path)
{
	$::module_path=$::cgi_dir."/Modules";
}
debug("Adding $::module_path to the Perl \@INC path.",2,__LINE__);
unshift(@INC, $::module_path);

# Was a debug value passed in from the web?
if (!$::debug)
{
	$::debug=$form->param($::debug_code);
}

# Print HTML Page Header when debugging
if ($::debug)
{
	printHTMLHeader();
}

### Some items that were removed from the config file are defined here now.

# Set to 1 to skip MD5 checking. (Best for flatfile authentication, when MD5 include errors pop up...)
if (!$::skip_md5)
{
	$::skip_md5=0;
}

# Set to 1 to skip MD5 checking. (Best for flatfile authentication, when MD5 include errors pop up...)
if (!$::skip_hmac)
{
	$::skip_hmac=0;
}

# Set to 1 to strip out comments from the final HTML. Saves bandwidth, but makes debugging a pain.
if (!$::strip_comments)
{
	$::strip_comments=0;
}

# Set to the default link directory to create new photo links in (relative to album_dir)
if (!$::default_linkdir)
{
	$::default_linkdir="";
}

# Use jhead to insert the title/description into the EXIF header of each photo as it's viewed.
if (!$::jhead_comments)
{
	$::jhead_comments=0;
}

# Name for the root album in the descriptions file. This allows the "root" album to be given a title and description.
$::rootalbumname="Root";

# Descriptions file delimiter. Used to separate description entries in $::descname.
$::desc_delim="~";

# Code used to initiate an update check
$::checkupdate="checkupdate";

# Code used to display the user login screen. No need to change this.
$::login_code="login";

# Code used to log the user out. No need to change this.
$::logout_code="logout";

# Display the photo upload page, or the "uploads not allowed" page, as per your settings. No need to change this one, as it's not a threat - you *want* people to get to your upload page, right?
$::upload="upload";

# Code to display the rating form. No need to change this.
$::rating_form="rating_form";

# Code to delete cookies
$::delcookie="delcookie";

# Set the size of the "enter description" box
if (!$::enterdesc_rows)
{
	$::enterdesc_rows=5;
}
if (!$::enterdesc_cols)
{
	$::enterdesc_cols=80;
}

# Set the extension used for links
if (!$::linkext)
{
	$::linkext="url";
}

# If using ImageMagick, GD must not be used...
if ($::imagemagick)
{
	$::perl_gd="";
}

# Protect only photos?
if (!$::public_albums)
{
	$::public_albums=0;
}

# *** Temporary measure to fix usebuttons problem/bug
$::usebuttons=1;

# File path to photo icon
$::file_photo_icon="../$::img_dir/$::photo_icon";

# File path to movie icon
$::file_movie_icon="../.$::img_dir/$::movie_icon";

# File path to album icon
$::file_album_icon="../$::img_dir/$::album_icon";

# Web delimiter - should be ; for standardization, but might have to be & on some systems
if (!$::webdelim)
{
	$::webdelim=";";
}

# Release "name" - not really used for anything, just wanted to add it
$::release="Barbaric";

# Native Cookie field names
$::albumcookieusername="albumusername";
$::albumcookiepassword="albumpassword";

# Hide ratings in album view, if also hiding titles
if ($::descloc eq 2)
{
	$::rating_location=0;
}

debug("Starting execution, debugging is on ($::debug)...",2,__LINE__);

# Pull off web vars for lcoal use
$::localconfig=$form->param('album');
$::photo_width=$form->param('photo_width');
$::photo_height=$form->param('photo_height');

# Pull off more web vars
$::searchstring=$form->param('searchstring');
$::searchfilenames=$form->param('searchfilenames');
$::searchdescriptions=$form->param('searchdescriptions');
$::searchcomments=$form->param('searchcomments');
$::searchowners=$form->param('searchowners');


if (!$::localconfig)
{
	$::localconfig=$form->param('photo');

	# Change all \'s to /'s
	$::localconfig=~s/\\/\//g;

	# Drop the filename
	$::localconfig=~s/(.*\/).*/$1/;
}

# Read localized configuration file settings for this album
readConfig("$::album_dir/$::localconfig/album.cfg",1);

debug("Photo default size: \$::default_size",3,__LINE__);

# Use default_size (esp when told to), unless a size has been specified
if ($::photo_width || $::photo_height || $::photo_width eq -1 || $::photo_height eq -1)
{
	$::default_size=0;
	debug("Resetting \$::default_size to zero because a photo dimension was passed in ($::photo_width / $::photo_height)",3,__LINE__);
}

# Set default photo size (small)
if ($::default_size eq 1)
{
	$::photo_width=$::small_width;
	$::photo_height=$::small_height;
}

# Set default photo size (medium)
if ($::default_size eq 2)
{
	$::photo_width=$::medium_width;
	$::photo_height=$::medium_height;
}

# Set default photo size (large)
if ($::default_size eq 3)
{
	$::photo_width=$::large_width;
	$::photo_height=$::large_height;
}

# Set default photo size (fit to window)
if ($::default_size eq 4)
{
	$::photo_width="auto";
	$::photo_height="auto";
}

debug("Final photo dimensions: $::photo_width / $::photo_height",3,__LINE__);

# Dump contents of cookie
showCookie();

# Add full path to the stringtable, depending on if this is the first startup or not...
if ($::newconfig eq "true")
{
	$::cgi_dir=$::cwd;
}

$::stringtable="$::cgi_dir/$::stringtable";

debug("\$::stringtable is now $::stringtable",3,__LINE__);

# Check some basic stuff to make sure the environment is safe
sanityTest();

# Upgrade the album.cfg file from album.cfg.clean
if ($form->param('upgradecfg'))
{
	upgradeCfg();
}

# Check for command-line parameter to set static mode
if ($ARGV[0] eq "static")
{
	$::create_html_flag=10;
}

# Check for command-line parameter to set debug mode
if ($ARGV[0] eq "debug")
{
	$::debug=$ARGV[1];

	# If none passed as 2nd paramater, set debug level 4
	if (!$::debug)
	{
		$::debug=4;
	}
}

# Was static mode passed from the web?
if ($form->param('static'))
{
	$::create_html_flag=1;
}

# $::create_html_flag has the following values:
# 0 - No static HTML
# 1 - Build static HTML for current album/photo only (called from the web)
# 2 - Build static HTML, don't display results using HTML (called from the command line)

# Explicitly turn off buttons, jump station, icons, legend, notify and multi-paging if creating static HTML
if ($::create_html_flag)
{
	$::usebuttons=$::jump_to=$::icons=$::legend=$::notify=$::photos_per_page=0;
	# **** Hack to get images to work right
	$::img_dir="/img/";

}

# Set up default admins with comma seperators at either end
$::default_admins=",$::default_admins,";

# Ditto for guests
$::default_guests=",$::default_guests,";

if (!$::authentication_type)
{
	$::protect_album=0;
}

# Show at least one upload field
if (!$::concurrent_uploads)
{
	$::concurrent_uploads=1;
}

# Don't constrain thumbnails if we're using Image Magick - create them!
if ($::imagemagick || $::perl_gd)
{
	$::constrain_thumbs=0;
}

# Load these down into a variable, so we can modify them
$::username=$form->param('username');
$::password=$form->param('password');
$::fullscreen=$form->param('fullscreen');
$::randompic=$form->param('random');
$::ssi=$form->param('ssi');
$::popular_flag=$form->param('popular');
$::linkobject=$form->param('linkobject');

debug("\$::popular_flag is set to: [$::popular_flag], to show $::most_popular max",4,__LINE__);

# Logout
if ($::function eq $::logout_code || $function eq $::delcookie)
{
	require $::login_module;
	delCookie($::albumcookieusername,$::albumcookiepassword);
}

# If we're entering descriptions, turn off the slideshow!
if ($::function eq $::enter_desc)
{
	$::slide_timer=0;
	$::slide_timer_passed=1;
}

# Was a slideshow timer value passed in from the web?
if ($form->param('slideshow'))
{
	# Were we asked to turn off the slide show?
	if ($form->param('slideshow') eq -1 && $::fullscreen ne $::S{263})
	{
		$::slide_timer=$::fullscreen=0;
	}
	else
	{
		$::slide_timer=$form->param('slideshow');
	}

	# Set flag to keep the slide timer in the URL...
	$::slide_timer_passed=1;
}

# Load this down into a variable, so we can modify it
$::page=$form->param('page');

# Set default page
if (!$::page)
{
	$::page=1;
}

# Show "all"
if ($::page eq "all")
{
	$::page=1;
	$::photos_per_page=99999;
}

# Are we displaying the config screen?
if ($::function eq $::config)
{
	require $::admin_module;
	printHTMLHeader();
	print showConfig();
}

# Are we actually updating the configuration?
if ($::function eq $::updateconfig)
{
	printHTMLHeader();

	# Are we updating the flatfile userlist
	if ($form->param('userlist'))
	{
		require $::admin_module;
		updateUserList($form->param('userlist'));
	}
	# Or updating the config?
	else
	{
		require $::admin_module;
		updateConfig();
	}
}

# Add full path to icon/button files
$::photo_icon="$::img_dir/$::photo_icon";
$::movie_icon="$::img_dir/$::movie_icon";
$::album_icon="$::img_dir/$::album_icon";
$::album_folder_icon="$::img_dir/$::album_folder_icon";
$::login_button="$::img_dir/$::login_button";
$::logout_button="$::img_dir/$::logout_button";
$::home_button="$::img_dir/$::home_button";
$::search_button="$::img_dir/$::search_button";
$::random_button="$::img_dir/$::random_button";
$::upload_button="$::img_dir/$::upload_button";
$::recent_button="$::img_dir/$::recent_button";
$::rate_button="$::img_dir/$::rate_button";
$::email_button="$::img_dir/$::email_button";
$::small_button="$::img_dir/$::small_button";
$::medium_button="$::img_dir/$::medium_button";
$::large_button="$::img_dir/$::large_button";
$::fullsize_button="$::img_dir/$::fullsize_button";
$::fullscreen_button="$::img_dir/$::fullscreen_button";
$::edit_button="$::img_dir/$::edit_button";
$::delete_button="$::img_dir/$::delete_button";
$::move_button="$::img_dir/$::move_button";
$::config_button="$::img_dir/$::config_button";
$::create_button="$::img_dir/$::create_button";
$::titles_button="$::img_dir/$::titles_button";
$::updates_button="$::img_dir/$::updates_button";
$::adminupload_button="$::img_dir/$::adminupload_button";
$::thumb_button="$::img_dir/$::thumb_button";
$::popular_button="$::img_dir/$::popular_button";
$::link_button="$::img_dir/$::link_button";
$::auto_button="$::img_dir/$::auto_button";

# Save off templates
$::original_album_template=$::album_template;
$::original_photo_template=$::photo_template;
$::original_object_template=$::object_template;
$::original_upload_template=$::upload_template;
$::original_login_template=$::login_template;


# If album_web is not set, then we are performing image shrouding
if (!$::album_web)
{
	$::album_web=$::albumprog."?image=";
}

# Set recent upload tag to be used as the album
$::recent_upload_album=":recent";

# Check to see we're creating static HTML files
if ($::create_html_flag gt 1)
{

	$::static_time=time();

	# *** Copy CSS into root photo album and reference it from there
#	copy(x,"$::album_dir$::style_sheet");

	if ($::create_html_flag le 1)
	{
		print "<head><title>";
	}
	print "album.pl - ";
	print $::S{1};
	if ($::create_html_flag le 1)
	{
		print "</title>";
	}

	if ($::create_html_flag le 1)
	{
		$::object=printHeader();
		print <<HTML;
$::object
<h1>
HTML
	}
	print $::S{2};
	print "\n\n";
	if ($::create_html_flag le 1)
	{
		print "</h1><br /><br />";
	}
	print $::S{3};
	print "\n\n";
	if ($::create_html_flag le 1)
	{
		print "<br /><br />";
	}
	print $::S{4};
	print "\n\n";
	if ($::create_html_flag le 1)
	{
		print "<br /><br />";
	}

	print $::S{5};
	print "\n\n";
	if ($::create_html_flag le 1)
	{
		print "<br /><br />";
	}
	print "$::album_dir...\n";
	if ($::create_html_flag le 1)
	{
		print "<br />";
	}

	debug("Calling photoAlbum($::album_dir)",4,__LINE__);
	photoAlbum($::album_dir);
	debug("Back from photoAlbum($::album_dir) call",4,__LINE__);
	debug("Calling recursiveScan($::album_dir)",4,__LINE__);
	recursiveScan($::album_dir);
	debug("Back from recursiveScan($::album_dir) call",4,__LINE__);

	$::static_time_taken=time()-$::static_time;

	if ($::create_html_flag le 1)
	{
		print "<br /><br />";
	}
	print $::S{6};
	print " $::static_photos_done ";
	print $::S{7};

	# Any movies?
	if ($::static_movies_done)
	{
		print " ";
		print $::S{8};
		print " $::static_movies_done ";
		print $::S{9};
	}

	# Add 1 to account for the root album
	$::static_albums_done++;

	print " ";
	print $::S{10};
	print " $::static_albums_done ";
	print $::S{11};
	print "\n";

	# Count thumbnails
	if ($::static_photos_thumb)
	{
		if ($::create_html_flag le 1)
		{
			print "<br /><br />";
		}
		print "$::static_photos_thumb ";
		print $::S{12};
		print " ";
		print $::S{15};
		print "\n";
	}
	if ($::static_movies_thumb)
	{
		if ($::create_html_flag le 1)
		{
			print "<br /><br />";
		}
		print "$::static_movies_thumb ";
		print $::S{13};
		print " ";
		print $::S{15};
		print "\n";
	}
	if ($::static_albums_thumb)
	{
		if ($::create_html_flag le 1)
		{
			print "<br /><br />";
		}
		print "$::static_albums_thumb ";
		print $::S{14};
		print " ";
		print $::S{15};
		print "\n";
	}

	# Count descriptions
	if ($::totalphotodesc)
	{
		if ($::create_html_flag le 1)
		{
			print "<br /><br />";
		}
		print "$::totalphotodesc ";
		print $::S{12};
		print " ";
		print $::S{205};
		print "\n";
	}
	if ($::totalmoviedesc)
	{
		if ($::create_html_flag le 1)
		{
			print "<br /><br />";
		}
		print "$::totalmoviedesc ";
		print $::S{13};
		print " ";
		print $::S{205};
		print "\n";
	}
	if ($::totalalbumdesc)
	{
		if ($::create_html_flag le 1)
		{
			print "<br /><br />";
		}
		print "$::totalalbumdesc ";
		print $::S{14};
		print " ";
		print $::S{205};

		# Average
		print "\n$::S{269} ".int($::static_photos_done/$::static_albums_done)." $::S{270}";

		print "\n\n";
	}
	if ($::create_html_flag le 1)
	{
		print "<br /><br /><br /><br />";
	}
	print $::S{265};
	$::static_minutes=int($::static_time_taken/60);
	$::static_hours=int($::static_minutes/60);
	$::static_seconds=$::static_time_taken-($::static_minutes*60);
	$::static_minutes=$::static_minutes-($::static_hours*60);
	if ($::static_hours)
	{
		print " $::static_hours $::S{268}";
	}
	if ($::static_minutes)
	{
		print " $::static_minutes $::S{267}";
	}
	print " $::static_seconds $::S{266}\n";

}
else
{

	# Authenticate user
	$::authenticated=Authenticate();

	if (!$::debug)
	{
		printHTMLHeader();
	}

	# Clear manual override
	$::manual_override="";

	# Are we creating an album?
	if ($form->param('admincreate') && $form->param('album')!~/$::recent_upload_album$/)
	{
		printHTMLHeader();

		# Actually create the album
		if ($form->param('albumname'))
		{
			require $::admin_module;
			if (createAlbum($form->param('album'),$form->param('albumname'),$form->param('title'),$form->param('description'),$::owner))
			{
				error(__LINE__,"upload_dir",$form->param('albumname'))
			}
			else
			{
				$::album=$::album_dir."/".$form->param('album')."/".$form->param('albumname');
				$::function="";
			}
		}
		else
		# Just display the form
		{
			$::shortdesc=$::S{49};
			require $::display_module;
			display(buildTemplate());
			exit(0);
		}
	}

	# Are we doing random pics?
	if ($::randompic)
	{
		require $::recent_module;
		$::manual_override=randomizer();

		# SSI Random Pic
		if ($::ssi)
		{
			$::album=$::manual_override;
			$::album=~s/(.*)\/.*/$1/;
			require $::display_module;
			display(showObject($::manual_override));
			exit(0);
		}
	}

	# Bypass login form for function=about
	if ($::function eq "about")
	{
		$::authenticated=1;
	}

	# Do we have public albums?
	if ($::public_albums && !$form->param('photo'))
	{
		$::authenticated=1;
	}

	# Show Login Screen if not already logged in
	if ((($::album_password && !$::authenticated) && ($::password ne $::album_password)) || ($::protect_album && !$::authenticated))
	{
		debug("\$::function=$::login_code for one of the following reasons:",2,__LINE__);
		debug("\	1. \$::album_password required ($::album_password). (\$::password = $::password)",2,__LINE__);
		debug("\	2. \$::protect_album required ($::protect_album). (\$::authenticated = $::authenticated)",2,__LINE__);
		debug("\	3. Not logged in (\$::loggedin = $::loggedin)",2,__LINE__);
		$::function=$::login_code;

		# Manually reset the album to the root album, to avoid users passing in sub albums or photos
		$::manual_override=$::album_dir;
	}

	photoAlbum($::manual_override);
}

######################## END OF MAIN ########################

################### START OF SUBROUTINES ####################


##############################################################

=head3 photoAlbum()

 photoAlbum($manual_override);

 $manual_override - Start in this album or with this photo (optional)

Does the majority of the processing for the photo album

=cut
sub photoAlbum
{
my $manual_override=shift;
   $::keep_this="1";

	debug("Entering subroutine: photoAlbum($manual_override)",4,__LINE__);

	if ($manual_override)
	{
		debug("\$manual_override=$manual_override",2,__LINE__);
	}

	# Localize some vars
	{
	my $key;
	my @keys;
		# Read web environment variables
		@keys=keys %ENV;
		debug("---- BEGIN Web environment variables ----",3,__LINE__);
		foreach $key (@keys)
		{
			debug("$key: $ENV{$key}",3,__LINE__);
		}
		debug("---- END Web environment variables ----",3,__LINE__);
	}

	# Check to see if we're being called with function=$::upload
	if ($::function eq "$::upload")
	{
		require $::upload_module;
		uploadPhoto();
		exit(0);
	}

	# Check to see if the user is updating a description
	if ($::function eq $::update_desc)
	{
		require $::ratings_module;
		updateDesc($form->param('object'),$form->param('desc_file_loc'),$form->param('title'),$form->param('description'),$form->param('owner'),translateLevel($form->param('view_level')));
		if (!$form->param('advance'))
		{
			$manual_override=$form->param('photo2');
		}
	}

	# Check to see if the user is adding a rating
	if ($::function eq $::rating_form)
	{
	my $temp=$form->param('rating_file_loc');
		if(!$::loggedin && $::authentication_type)
		{
			require $::display_module;
			display(javaAlert("Must be logged in to add ratings!"));
			$::function="";
		}
		elsif (isGuest() && $::authentication_type)
		{
			require $::display_module;
			display(javaAlert("Guests can not add ratings!"));
			$::function="";
		}
		else
		{
			openDescfile("$::album_dir/$temp/");
			getDescription($form->param('object'));
			$::shortdesc="$::S{229} ".$::shortdesc;
			require $::display_module;
			display(buildTemplate());
			exit(0);
		}
	}

	# Check to see if the user is adding a rating
	if ($::function eq "$::update_rating")
	{
		if ($form->param('comments'))
		{
			$::object="$::S{203} ";
			if ($form->param('name'))
			{
				$::object.=$form->param('name');
			}
			else
			{
				$::object.="$::S{204}";
			}
			$::object.=": ".$form->param('comments');
		}

		require $::ratings_module;
		updateRating($form->param('object'),$form->param('rating_file_loc'),$form->param('rating'),$::object);
	}

	# Have we been told to stop adding descriptions?
	if ($form->param('stop_add_desc') eq "stop")
	{
		$::function="";
	}

	# Translate into shorter variable names
	if ($form->param('album') && !$::album)
	{
		$::album=$::album_dir."/".$form->param('album');
		debug("\$::album has been set to $::album (from the web form var)",2,__LINE__);
	}

	if ($form->param('photo'))
	{
		$::photo=$form->param('photo');

		# Change all \'s to /'s
		$::photo=~s/\\/\//g;

		debug("\$::photo has been set to $::photo (from the web form var)",2,__LINE__);

		# Is it a link? If so, just turn it into a direct link to the photo...
		if (isAPhotoOrJp2($::photo) eq 2)
		{
			debug("\$::photo is a link...",4,__LINE__);
			$::photo=getLinkURL("$::album_dir/$::photo");
			debug("\$::photo has been set to $::photo (from the link url)",4,__LINE__);
		}
	}

	if ($::album)
	{
		# Change all \'s to /'s
		$::album=~s/\\/\//g;
	}

	# Are we checking for updates?
	if ($::function eq $::checkupdate)
	{
		require $::admin_module;
		checkUpdate();
	}

	# Override album (for creating static HTML)
	if ($manual_override || $::create_html_flag)
	{
		debug("Manual Override is [$manual_override]",2,__LINE__);
		if (isAPhotoOrJp2($manual_override))
		{
			$::photo=$manual_override;
			debug("Setting photo to [$::photo]",2,__LINE__);
			$::static_filename_to_use="$::full_directory.html";
			$::album="";
		}
		else
		{
			if (isAMovie($manual_override))
			{
				$::album=$manual_override;

				# Change all \'s to /'s
				$::album=~s/\\/\//g;

				$::album=~s/(.*)\/(.*)/$1/;

				$::album="$::album_dir/$::album";
			}
			else
			{
				$::album=$manual_override;
			}
			debug("Setting album to [$::album]",2,__LINE__);
			if ($::full_directory)
			{
				# For photo albums to be scanned
				$::static_filename_to_use="$::full_directory/$::static_html_filename";
			}
			else
			{
				# For root photo album
				$::static_filename_to_use="$::album_dir/$::static_html_filename";
			}
			$::photo="";
		}
	}

	# Is this the top level?
	if (!($::photo || $::album))
	{
		$::album="$::album_dir";
	}

	if ($::album)
	{
		$::middle=$::album;
	}

	if ($::photo)
	{
		$::middle=$::photo;
	}

	if ($::middle=~/^$::album_dir$/i)
	{
		$::middle="";
	}
	else
	{
		# Change all \'s to /'s
		$::middle=~s/\\/\//g;
		$::middle=~s/$::album_dir\/(.*)/$1/;
	}

	# Open static HTML file...
	if ($::create_html_flag)
	{
		# Open the static HTML file
		open(STATIC,">$::static_filename_to_use") || error(__LINE__,"not_writable","$::static_filename_to_use");
		debug("Creating static HTML file at [$::static_filename_to_use]",2,__LINE__);
	}

	debug("The album is: $::album",2,__LINE__);
	debug("The middle bit is: $::middle",2,__LINE__);

	$::goback=$::middle;

	# Change all \'s to /'s
	$::goback=~s/\\/\//g;

	# Drop the filename
	$::goback=~s/(.*)\/.*/$1/;

	if ($::goback eq $::middle)
	{
		$::goback="";
	}

	# Keep a copy, so you don't have all the funny web stuff when you do a compare
	$::realgoback=$::goback;

	debug("GoBack: $::goback",2,__LINE__);

	if ($::photo)
	{
		$::descfile=$::album_dir."/";
		if ($::goback)
		{
			$::descfile.=$::goback."/";
		}
	}

	if ($::album)
	{
		#$::shortalbum=$::album_dir."/".$::album;
		$::shortalbum=$::album;
		if ($::realgoback)
		{
			$::shortalbum=~s/(.*\/).*/$1/;
		}
		else
		{
			$::shortalbum=$::album_dir;
		}
		$::shortalbum=$::shortalbum."/";

		debug("ShortAlbum: $::shortalbum",2,__LINE__);

		# If you're updating descriptions, this is the file you want.
		$::desc_to_update="$::shortalbum";

		openDescfile($::shortalbum);

		if ($::album=~/^$::album_dir$/i)
		{
			$::shortalbum="$::rootalbumname";
		}
		else
		{
			if ($::realgoback)
			{
				$::shortalbum=$::middle;
				$::shortalbum=~s/(.*)$::realgoback\//$1/;
			}
			else
			{
				$::shortalbum=$::middle;
			}
		}

		debug("ShortAlbum: $::shortalbum",2,__LINE__);

		$::shortobject=$::shortalbum;

		getDescription($::shortalbum);

		# Set album thumbnail
		if ($form->param('setthumb'))
		{
		use File::Copy;
		my $ext;
		my $temp2;
		my $temp;

			$::shortalbum=$form->param('album');
			$ext=$form->param('setthumb');

			$temp="$::album_dir/$::shortalbum/$ext";

			# Change all \'s to /'s
			$::shortalbum=~s/\\/\//g;

			# Pull out path
			$::shortalbum=~s/.*\/(.*)/$1/;

			$ext=~s/.*\.(.*)/$1/;

			$temp2="$::album_dir/".$form->param('album')."/../$::thumbprefix$::shortalbum.$ext";
			debug("Copying album thimbnail: $temp --> $temp2",2,__LINE__);

			# Make sure source thumb is readable, and that we are authorized to do this
			if (-r $temp && ($::function eq $::admin || (($::owner eq $::loggedin || $::default_admins=~/(.*,)*$::loggedin(,.*)*/) && $::loggedin)))
			{
				unlink($temp2);
				copy($temp,$temp2);
			}
		}


		# Keep count for static
		if ($::founddesc)
		{
			$::totalalbumdesc++;
		}

		close(DESC);

		# Set the description to pass as a default for editing
		$::existing_shortdesc=$::shortdesc;

		if (!$::shortdesc)
		{
			if ($::shortalbum eq $::rootalbumname)
			{
				$::shortdesc="$::S{87}";
			}
			else
			{
				$::shortdesc=$::shortalbum;
			}
		}

		$::descfile="$::album_dir/$::middle/";

		if (!isViewable("$::album_dir/$::goback",$::shortalbum,1))
		{
			$::keep_this="";
		}
	}

	# Select directory to read all entries from
	if ($::album)
	{
		$::dir_to_read="$::album_dir/$::goback";
	}

	# *** This is the spot that causes the bug.
	if (!$::usebuttons)
	{
	my $temp=passVars(0);
		if ($temp)
		{
			$::goback.="?".$temp;
		}
	}

	if ($::photo)
	{
		$::dir_to_read="$::descfile";
		$::shortphoto=$::photo;
		$::shortphoto=~s/.*\/(.*)/$1/;
		debug("\$::shortphoto = $::shortphoto",3,__LINE__);
		if (!isViewable($::goback,$::shortphoto,3))
		{
			$::keep_this="";
		}
	}

	# Are we deleting an object? If so, confirm.
	if ($form->param('deleteobject'))
	{
		$::shortdesc=$::S{183};
		$::longdesc="";
		require $::display_module;
		display(buildTemplate());
		exit(0);
	}

	# Have we confirmed the delete?
	if ($form->param('confirmdeleteobject') && $form->param('yes'))
	{
		require $::admin_module;
		debug("Calling deleteObject(confirmdeleteobject)",3,__LINE__);
		deleteObject($form->param('confirmdeleteobject'));
	}

	# Are we moving an object? If so, confirm.
	if ($form->param('moveobject'))
	{
		require $::display_module;
		display(buildTemplate());
		exit(0);
	}

	# Have we confirmed the move?
	if ($form->param('confirmmoveobject') && $form->param('yes'))
	{
		require $::admin_module;
		debug("Calling moveObject(confirmmoveobject)",3,__LINE__);
		moveObject($form->param('confirmmoveobject'),0,$form->param('category'),$form->param('newobjectname'));
	}

	# Are we linking an object? If so, confirm.
	if ($::linkobject)
	{
		# ...unless you're using a default_linkdir setting...
		if ($::default_linkdir)
		{
			require $::admin_module;
			linkObject($::linkobject,0,$::default_linkdir);
			$::linkobject="";
		}
		else
		{
			require $::display_module;
			display(buildTemplate());
			exit(0);
		}
	}

	# Have we confirmed the link?
	if ($form->param('confirmlinkobject') && $form->param('yes') && !$::default_linkdir)
	{
		require $::admin_module;
		debug("Calling linkObject(confirmlinkobject)",3,__LINE__);
		linkObject($form->param('confirmlinkobject'),0,$form->param('category'));
	}

	# Show Recent Uploads
	if ($form->param('album')=~/$::recent_upload_album$/)
	{
		$::album=$::recent_upload_album;
		require $::display_module;
		display(buildTemplate());
		exit(0);
	}

	# Show search screen, or the search results
	if ($form->param('searchstart') || $::searchstring)
	{
		$::shortdesc=$::S{280};
		$::longdesc="";
		require $::display_module;
		display(buildTemplate());
		exit(0);
	}


	# Show Most Popular screen
	if ($::popular_flag && $::most_popular)
	{
		$::shortdesc="$::most_popular $::S{271}";
		$::longdesc="";

		# Set the number to show by the number passed in via SSI
		if ($::ssi)
		{
			$::most_popular=$::ssi;
		}

		require $::display_module;
		display(buildTemplate());
		exit(0);
	}

	# Find next and previous pictures/albums as appropriate
	debug("Looking for next and previous objects in [$::dir_to_read]...",2,__LINE__);

	@::file_list=readDirectory($::dir_to_read);

	debug("Done Directory Scan, comparing for $::shortphoto or $::shortalbum...",3,__LINE__);

	# clear re-used vars
	$::prev_obj_desc="";
	$::next_obj_desc="";

	$::next_obj="";

	# Prep the "jump station" for the footer
	if ($::jump_to && $::middle && $::album && $::contains_dir)
	{
		# Add JS for auto submitting
		$::jump_station.=<<HTML;
<script language="JavaScript">
function JumpNow()
{
	document.JumpStation.submit();
}
</script>

<form name="JumpStation" method="GET" action="$::albumprog">
HTML
		$::jump_station.=passVars(1);
		$::jump_station.=$::S{16};
		$::jump_station.=" <SELECT name=\"album\" onChange=\"JumpNow()\">\n";
		# Save vars
		$::temp_shortdesc=$::shortdesc;
		$::temp_longdesc=$::longdesc;
		openDescfile($::desc_to_update);
	}

	@::file_list=sortObjects(1);

	my $this_is_it=0;

	foreach $::object (@::file_list)
	{
		my $justtemp;

		debug("Current object is [$::object]",4,__LINE__);
		if ($this_is_it)
		{
			$justtemp="$::album_dir/";
			if ($::goback)
			{
				$justtemp.="$::goback/";
			}
			$justtemp.=$::object;

			debug("Is this an album: $justtemp",4,__LINE__);
			debug("\$::photo: $::photo",4,__LINE__);
			debug("\$::album: $::album",4,__LINE__);

			# Set next object
			if (isAPhotoOrJp2($::object) || -d $justtemp ||isAMovie($::object))
			{
				$::next_obj=$::object;
				debug("Setting \$::next_obj to $::next_obj...",3,__LINE__);
			}
		}
		$this_is_it=0;

		debug("\$::photo: $::photo - \$::object: $::object - \$::shortphoto: $::shortphoto - \$::album: $::album - \$::shortalbum: $::shortalbum",4,__LINE__);

		if (($::photo && ($::object eq $::shortphoto)) || ($::album && ($::object eq $::shortalbum)))
		{
			$::prev_obj=$::prev_object;
			$this_is_it=1;
			debug("Setting \$::prev_obj to $::prev_obj...",3,__LINE__);
		}
		$::prev_object=$::object;

		# Prep the "jump station" for the footer
		if ($::jump_to && $::middle && $::album && $::contains_dir && (-d "$::album_dir/$::goback/$::object"))
		{
			$::founddesc=0;
			getDescription($::object);
			$::jump_station.="<OPTION value=\"";
			if ($::goback)
			{
				$::jump_station.="$::goback/";
			}
			$::jump_station.="$::object\"";
			if ($::object eq $::shortalbum)
			{
				$::jump_station.=" SELECTED";
			}
			$::jump_station.=">";
			if ($::usedesc && $::shortdesc)
			{
				$::jump_station.="$::shortdesc";
			}
			else
			{
				$::jump_station.="$::object";
			}
			$::jump_station.="</OPTION>\n";
		}
	}

	# Prep the "jump station" for the footer
	if ($::jump_to && $::middle && $::album && $::contains_dir)
	{
		# Restore vars
		$::shortdesc=$::temp_shortdesc;
		$::longdesc=$::temp_longdesc;
		close(DESC);
		$::jump_station.="</SELECT>";
		$::jump_station.="</form>\n";
	}

	# Cache descriptions, to be restored later
	$::temp_shortdesc=$::shortdesc;
	$::temp_longdesc=$::longdesc;

	$::shortdesc=$::longdesc="";

	# strip off last album, to get descriptions for the current album, next album and previous album
	$::back_descfile=$::descfile;
	$::back_descfile=~s/(.*\/).*\/.*/$1/;

	if ($::album)
	{
		openDescfile($::back_descfile);
	}

	if ($::photo)
	{
		openDescfile($::descfile);
	}

	# Get description for the next object
	if ($::next_obj)
	{
		getDescription($::next_obj);
		if ($::founddesc)
		{
			$::next_obj_desc=$::shortdesc;
		}
	}

	# Get description for the previous object
	if ($::prev_obj)
	{
		getDescription($::prev_obj);
		if ($::founddesc)
		{
			$::prev_obj_desc=$::shortdesc;
		}
	}
	close(DESC);

	# Restore original descriptions
	$::shortdesc=$::temp_shortdesc;
	$::longdesc=$::temp_longdesc;

	debug("Next Object: $::next_obj [$::next_obj_desc]",3,__LINE__);
	debug("Previous Object: $::prev_obj [$::prev_obj_desc]",3,__LINE__);

	# clear array of photos, to save a lot of work later
	@::file_list="";

	if ($::album)
	{
		# Re-load the list of files from the current album directory
		@::file_list=readDirectory($::album);
		debug("Found objects in this album: @::file_list",3,__LINE__);
	}

	debug("Finished looking for next and previous objects...",2,__LINE__);

	# If the current object is an album, you have to go up one more
	if ($::album && ($::middle=~/\//))
	{
		$::back_descfile=~s/(.*\/).*\/.*/$1/;
	}

	# Get description of current object's album
	openDescfile($::back_descfile);
	$::temp_shortdesc=$::shortdesc;
	$::temp_longdesc=$::longdesc;
	$::shortdesc=$::longdesc="";
	if (!$::realgoback)
	{
		$::object=$::rootalbumname;
	}
	else
	{
		$::object=$::realgoback;
		if ($::object=~/\//)
		{
			$::object=~s/.*\/(.*)/$1/;
		}
	}
	getDescription($::object);
	$::back_desc=$::shortdesc;
	$::shortdesc=$::temp_shortdesc;
	$::longdesc=$::temp_longdesc;
	debug("Desc for object's parent album is: $::back_desc",4,__LINE__);
	close(DESC);

	# clear re-used vars
	$::prev_object="";

	# Remove any web variables, if present
	$::descfile=~s/(.*)\&.*/$1\//;

	openDescfile($::descfile);

	if ($::photo)
	{

		debug("ShortPhoto: $::shortphoto",2,__LINE__);

		$::shortobject=$::shortphoto;

		$::shortdesc="";
		$::longdesc="";
		getDescription($::shortphoto);

		if (isAMovie($::shortphoto))
		{
			$::totalmoviedesc+=$::founddesc;
		}
		else
		{
			$::totalphotodesc+=$::founddesc;
		}

		# Set the description to pass as a default for editing
		$::existing_shortdesc=$::shortdesc;

		if (!$::shortdesc)
		{
			$::shortdesc=$::shortphoto;
		}

		# If you're updating descriptions, this is the file you want.
		$::desc_to_update="$::descfile";
	}

	debug("ShortObject: $::shortobject",2,__LINE__);

	# Make a "text" (not html) version of the long description
	$::textlongdesc=$::longdesc;
	$::textlongdesc=~s/<br \/>//g;
	$::textlongdesc=~s/<br>//g;
	$::textlongdesc=~s/[\n\r]//g;

	# Build the "next photo" url
	if ($::create_html_flag)
	{
		$::next_photo_link="$::next_obj.html";
	}
	else
	{
		$::next_photo_link="$::albumprog?photo=$::realgoback/$::next_obj";
	}

	$::next_photo_link.=passVars(0);

	if (!$::keep_this)
	{
		$::shortdesc=$::S{337};
		$::longdesc="";
	}

	# When a photo is displayed, it is in an HTML page, with a reference to the actual photo.
	# The short description is the photo's title, and the long description is displayed below it.
	# Description information is read out of $::descfile file, in the photo album.

	# Save off descriptions
	$::temp_shortdesc=$::shortdesc;
	$::temp_longdesc=$::longdesc;

	# Only build object if it's real.
	if (($::photo && -e "$::album_dir/$::photo") || ($::album && -e "$::album"))
	{
		if ($::keep_this)
		{
			$::actual_object=buildObject();
		}
		else
		{
			$::actual_object=$::S{338};
		}
	}
	else
	{
		$::actual_object=$::S{294};
	}

	# Restoredescriptions
	$::shortdesc=$::temp_shortdesc;
	$::longdesc=$::temp_longdesc;

	$::template=buildTemplate();

	# Translate funny web chars like spaces --> %20 (not if static though)
	if (!$::create_html_flag)
	{
		$::template=parseLinks($::template);
	}

	debug("Object template is built! [$::template]",4,__LINE__);

	# Remove comments
	if ($::strip_comments)
	{
		$::template=~s/\n*<!--([^>]|\n)*>\n*//g;
	}

	require $::display_module;
	display("$::template");

	# Scan for files and directories under the root directory. Each directory is considered an album.
	# Each photo file (.bmp, .gif or .jpg) is considered an photo.

	# Display an HTML page listing all albums and photos in given directory.

	# Each album's link will call album.pl with the name of the album as an environment variable.
	# (album=01 - The Beginning)

	# Each picture's link will call album.pl with the name of the photo file as an environment variable.
	# Each picture's short description is displayed as the link text.
	# (photo=001.jpg)

	if ($::usedesc)
	{
		close(DESC);
	}

	if ($::create_html_flag)
	{
		close(STATIC);
	}

	debug("Leaving subroutine: photoAlbum($manual_override)",4,__LINE__);
}


##########################################################################

=head3 error()

 error($line,$error,$extra_info,$module);

 $line - Line number, where error occurred.
 $error - Pre-defined error code that prints a canned message.
 $extra_info - Additional information that can be passed in
 $module - Module that threw the error

Displayes the error message associated with $error along with the $extra_info. Then halts execution.

=cut
sub error
{
my $line=shift;
my $error=shift;
my $extra_info=shift;
my $module=shift;

	require $::display_module;
	error_sub($line,$error,$extra_info,$module);
}


##########################################################################

=head3 debug()

 debug($debug_message,$debug_level,$line);

 $debug_message - String to print if debugging is on
 $debug_level - Only pring string if current debug level is $debug_level or higher (current debug level is set by $debug)
 $line - The line number of the debug statement.
 $module - Module name (optional).

Prints a message, if $::debug has a value.

=cut
sub debug
{
my $debug_message=shift;
my $debug_level=shift;
my $line=shift;
my $module=shift;

	if ($::debug gt 0)
	{
		require $::display_module;
		debug_sub($debug_message,$debug_level,$line,$module);
	}
}


##########################################################################

=head3 setDate()

 $datestr=setDate($convtime,$return_seconds);

 $datestr        - date and time
 $convtime       - unixtime value which is used to set $datestr (optional)
 $return_seconds - 1=YYYY/MM/DD HH:MM:SS, 0=YYYY/MM/DD HH:MM

Converts $convtime into a human readable format and returns it as $datestring.
If $convtime is not provided, the current time is returned. If $return_seconds
has a value, then the time includes seconds.

=cut
sub setDate
{
my $convtime=shift;
my $return_seconds=shift;
my $year;
my $mon;
my $hour;
my $min;
my $sec;
my $sysdate;
my $mday;
my $wday;
my $yday;
my $isdst;

	$convtime=time if (!$convtime);

	debug("Convtime: [$convtime]",2,__LINE__);

	($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=localtime($convtime);
	$year+=1900;
	$mon++;
	$mday = "0$mday" if ($mday < 10);
	$mon  = "0$mon"  if ($mon < 10);
	$hour = "0$hour" if ($hour < 10);
	$min  = "0$min"  if ($min < 10);
	$sec  = "0$sec"  if ($sec < 10);
	$sysdate="$year/$mon/$mday $hour:$min";

	$sysdate.=":$sec" if ($return_seconds);

	debug("Sysdate: [$sysdate]",2,__LINE__);
	return($sysdate);
}


##########################################################################

=head3 sanityTest()

 sanityTest();

Runs some basic tests to make sure the environment is clean and secure before the script starts.

=cut
sub sanityTest
{
my $data;
my $errstr="";
my $count=1;
my $stuff;
my $confopen;
my @funccodes;
my $funccode;
my $prevcode;
my $couldbe=$0;

	debug("Loading string table from $::stringtable...",2,__LINE__);

	# Trying to open the provided config file
	if (open(STRINGTABLE,"$::stringtable"))
	{
		debug("Opened string table at $::stringtable",2,__LINE__);
		$confopen=1;
	}
	else
	{
		$confopen=0;
	}

	# Nope. Try just album_strings.txt
	if (!$confopen)
	{
		debug("Trying to read string table information from album_strings.txt...",2,__LINE__);
		if (open(STRINGTABLE,"album_strings.txt"))
		{
			debug("Opened string table at album_strings.txt",2,__LINE__);
			$confopen=1;
			$::stringtable="album_strings.txt";
		}
		else
		{
			$confopen=0;
		}
	}

	# Nope. Try the same directory as album.pl explicitly
	if (!$confopen)
	{
		# Change all \'s to /'s
		$couldbe=~s/\\/\//g;

		# Drop the filename
		$couldbe=~s/(.*\/).*/$1/;

		$couldbe.="album_strings.txt";
		debug("Trying to read string table information from $couldbe...",2,__LINE__);
		if (open(STRINGTABLE,"$couldbe"))
		{
			debug("Opened string table file at $couldbe",2,__LINE__);
			$confopen=1;
			$::stringtable=$couldbe;
		}
		else
		{
			$confopen=0;
		}
	}

	# Just couldn't find the bloody thing!
	if (!$confopen)
	{
		error(__LINE__,"stringtable","$::stringtable: $!");
	}

	# Read all values from stringtable
	while ($data=<STRINGTABLE>)
	{
		chomp($data);
		$data=~s/[\n\r]//g;
		# Use just @S because I'm going to type this variable name a million times, and I'm lazy.
		$::S{$count}=$data;
		$stuff=$::S{$count};
#		debug("\$::S{$count} = [$::S{$count}]",4,__LINE__);
		$count++;
	}
	close(STRINGTABLE);

	# Check for security holes

	# Relative paths
	if ($form->param('album')=~/^\\*\./)
	{
		$errstr="$::S{84} $::S{14}.";
	}
	if ($form->param('photo')=~/^\\*\./)
	{
		$errstr="$::S{84} $::S{12}.";
	}
	if ($form->param('album')=~/^\/*\./)
	{
		$errstr="$::S{84} $::S{14}.";
	}
	if ($form->param('photo')=~/^\/*\./)
	{
		$errstr="$::S{84} $::S{12}.";
	}

	# Special chars
	if ($form->param('album')=~/[|><]/)
	{
		$errstr="$::S{85} $::S{14} $::S{86}.";
	}
	if ($form->param('photo')=~/[|><]/)
	{
		$errstr="$::S{85} $::S{12} $::S{86}.";
	}

	# Check for function codes that are the same...
	push @funccodes,$::admin;
	push @funccodes,$::config;
	push @funccodes,$::updateconfig;
	push @funccodes,$::enter_desc;
	push @funccodes,$::update_desc;
	push @funccodes,$::update_rating;
	push @funccodes,$::debug_code;

	@funccodes=sort @funccodes;

	$prevcode="";

	foreach $funccode (@funccodes)
	{
		if ($funccode eq $prevcode)
		{
			$::warning.=$::S{292}."<br />";
		}
		$prevcode=$funccode;
	}
	@funccodes="";

	if ($errstr)
	{
		error(__LINE__,"sanity","$errstr");
	}
}


##########################################################################

=head3 readDirectory()

 @myfile_list=readDirectory($scan_directory);

 @myfile_list - Returned list of files in this directory
 $scan_directory - Directory to read all values from

Reads all entries in specified directory, returns as list

=cut
sub readDirectory
{
my @myfile_list;
my @final_file_list;
my $scan_directory=shift;
my $shortfile;
my $keep_this_one;

	debug("Entering subroutine: readDirectory($scan_directory)",4,__LINE__);

	# Clear arrays, because otherwise they appear to have a null element, which really buggers things up
	while (@final_file_list)
	{
		shift @final_file_list;
	}
	while (@myfile_list)
	{
		shift @myfile_list;
	}
	while (@::album_list)
	{
		shift @::album_list;
	}
	while (@::photo_list)
	{
		shift @::photo_list;
	}
	while (@::movie_list)
	{
		shift @::movie_list;
	}

	debug("Attempting to read entries in [$scan_directory]",2,__LINE__);
	opendir(ENTRIES,"$scan_directory") or error(__LINE__,"not_readable","$scan_directory");

	# Change Grep
	@myfile_list=grep !/^\.\.?$/,readdir ENTRIES;
	close(ENTRIES);

	# clear directory flag
	$::contains_dir=$::temp_quota_total=$::numfiles=$::filenum=0;

	foreach $shortfile (@myfile_list)
	{
		# Check to see if it's a movie, picture or album
		debug("Checking to see if $scan_directory/$shortfile is a photo/movie/album...",4,__LINE__);
		if (isAPhotoOrJp2($shortfile) || isAMovie($shortfile) || (-d "$scan_directory/$shortfile") || ($::doing_upload eq 2 && $form->param('image') eq "randthumb") && isAThumb($shortfile))
		{
			# Load photo, movie and album arrays
			if (isAPhotoOrJp2($shortfile) && isViewable($scan_directory,$shortfile,"1") || ($::doing_upload eq 2 && $form->param('image') eq "randthumb" && isAThumb($shortfile)))
			{
				debug("It's a photo ($shortfile)...",4,__LINE__);
				$keep_this_one="1";
				push @::photo_list,$shortfile;

				# For pic randomizer
				if (($::doing_upload eq 2 && $form->param('image') eq "randthumb" && isAThumb($shortfile)) || $form->param('image') ne "randthumb")
				{
				my $tempstuff="$scan_directory/$shortfile";
					$tempstuff=~s/^$::album_dir\///;
					push @::total_photo_list,$tempstuff;
					debug("Randomization: Adding $tempstuff list of random objects",4,__LINE__);
				}
			}
			if (isAMovie($shortfile) && isViewable($scan_directory,$shortfile,"1"))
			{
				debug("It's a movie...",4,__LINE__);
				$keep_this_one="1";
				push @::movie_list,$shortfile;
			}
			if ((-d "$scan_directory/$shortfile") && isViewable($scan_directory,$shortfile,"1"))
			{
				debug("It's an album ($shortfile)...",4,__LINE__);

				# Ignore directories on exclude list
				if ($shortfile!~/$::skipalbums/)
				{
					$keep_this_one="1";
					push @::album_list,$shortfile;
				}
			}

			# Ignore directories on exclude list
			if (($shortfile!~/$::skipalbums/) && $keep_this_one)
			{
				push @final_file_list,$shortfile;
			}

			# Set the flag if we've seen at least one dir
			if (!$::contains_dir && (-d "$scan_directory/$shortfile"))
			{
				$::contains_dir=1;
				debug("We've seen at least one directory: \$::contains_dir=$::contains_dir - ($scan_directory/$shortfile)",3,__LINE__);
			}
			$keep_this_one="";

			# Update quota information
			if ($::quota && $::per_member_upload)
			{
				@::allinfo=stat("$scan_directory/$shortfile");
				$::temp_quota_total+=$::allinfo[7];
				debug("New quota total: $::temp_quota_total",3,__LINE__);
			}
		}
	}

	debug("Final quota total: $::temp_quota_total bytes from $::numfiles files.",3,__LINE__);

	# Here's where to add in different sorting options
	@final_file_list=sort(@final_file_list);

	foreach $shortfile (@final_file_list)
	{
		if ((isAPhoto($shortfile) || isAMovie($shortfile)) && isViewable($scan_directory,$shortfile,"1"))

		{
			# Keep count
			$::numfiles++;

			debug("\$::numfiles increment: $::numfiles ($shortfile)",3,__LINE__);

			if ($shortfile eq $::shortphoto && $shortfile)
			{
				$::filenum=$::numfiles;
				debug("$shortfile == $::shortphoto, so we're setting \$::filenum = $::numfiles",3,__LINE__);
			}
		}
	}

	debug("All Entries:<br /><br />@final_file_list",4,__LINE__);

	debug("Leaving subroutine: readDirectory($scan_directory)",4,__LINE__);

	return (wantarray) ? @final_file_list : shift(@final_file_list);

}


##########################################################################

=head3 recursiveScan()

 recursiveScan($scan_directory,$already_scanned);

 $scan_directory - Directory to search recursively
 $already_scanned - Path of directories above this one (optional)

Walks the directory tree recursively

=cut
sub recursiveScan
{
my @all_dirs;
my $single_directory;
my $photo_filename;
my $directory_only;
my $filename_only;
my $scan_directory=shift;
my $already_scanned=shift;

	debug("Entering subroutine: recursiveScan($scan_directory,$already_scanned)",4,__LINE__);

	debug("Performing recursive scan of $scan_directory...",2,__LINE__);
	debug("\$already_scanned=$already_scanned",2,__LINE__);

	@all_dirs=readDirectory($scan_directory);

	# Add root directory
	if ($::doing_upload eq 1 && !$already_scanned)
	{
		# Get description
		openDescfile("$::album_dir/");
		getDescription($::rootalbumname);
		close(DESC);

		debug("Checking for existance of $::album_dir/no_upload.txt",4,__LINE__);

		# If no_upload.txt file is present in this dir, don't show it on the upload menu
		if (!-e "$::album_dir/no_upload.txt" || isAdmin() eq 1 || (($::owner eq $::loggedin) && $::loggedin))
		{
			$::object.="<option value=\"\">";

			if (!$::shortdesc)
			{
				$::object.="$::S{87}";
			}
			else
			{
				$::object.="$::shortdesc";
			}

			$::object.="</option>\n";
		}
		else
		{
			debug("Skipping $::album_dir because no_upload.txt was found.",3,__LINE__);
		}

		# Search
		if ($::searchstring)
		{
			# Description/owner search
			if ($::searchdescriptions || $::searchowners)
			{
				debug("Searching descriptions/owners in $single_directory for $::searchstring",4,__LINE__);
				openDescfile("$::album_dir/");

				# Pass in object of parent dir as parameter
				getDescription("./",1);
			}

			# Ratings serch
			if ($::searchcomments)
			{
				debug("Searching ratings in $single_directory for $::searchstring",4,__LINE__);
				getRatings(2,$single_directory);
			}
		}

		# Find most popular
		if ($::popular_flag)
		{
			getRatings(4,$single_directory);
			require $::recent_module;
			getPopularViews($single_directory);
		}
	}

	foreach $single_directory (@all_dirs)
	{
		$::full_directory="$::album_dir/";
		if ($already_scanned)
		{
			debug("Concatenating \$already_scanned ($already_scanned) to \$::full_directory ($::full_directory) because \$already_scanned has a value.",2,__LINE__);
			$::full_directory.="$already_scanned/";
		}
		$::full_directory.=$single_directory;
		debug("\$::full_directory=$::full_directory",2,__LINE__);
		if (-d "$::full_directory")
		{
			# Increment "scan depth" counter
			$::scan_depth++;

			debug("$single_directory is a directory.",2,__LINE__);
			$directory_only=$single_directory;

			$::static_albums_done++;

			if ($already_scanned)
			{
				debug("Prepending $already_scanned to $single_directory because \$already_scanned has a value.",2,__LINE__);
				$single_directory="$already_scanned/$single_directory";
			}

			# Do any per directory processing here

			# Search
			if ($::searchstring)
			{
				# Filename (directory) search
				if ($::searchfilenames)
				{
					debug("Searchimg $directory_only for $::searchstring",4,__LINE__);
					if ($directory_only=~/$::searchstring/i)
					{
						debug("Found a MATCH (directory): $directory_only - storing $single_directory",4,__LINE__);
						if(isViewable($single_directory,$single_directory,"1"))
						{
							push @::searchresults,"$single_directory";
						}
					}
				}

				# Description/owner search
				if ($::searchdescriptions || $::searchowners)
				{
					debug("Searching descriptions/owners in $single_directory for $::searchstring",4,__LINE__);
					openDescfile("$::album_dir/$single_directory/");

					# Pass in object of parent dir as parameter
					getDescription("$single_directory/",1);
				}

				# Ratings serch
				if ($::searchcomments)
				{
					debug("Searching ratings in $single_directory for $::searchstring",4,__LINE__);
					getRatings(2,$single_directory);
				}
			}

			# Find most popular
			if ($::popular_flag)
			{
				getRatings(4,$single_directory);
				require $::recent_module;
				getPopularViews($single_directory);
			}

			# We're building the list of directories to display for the upload form here...
			if ($::doing_upload eq 1)
			{
				debug("Building upload category list [$single_directory] - size: $::temp_quota_total...",3,__LINE__);

				# Get description
				openDescfile("$::album_dir/$already_scanned/");
				getDescription($directory_only);
				close(DESC);

				debug("Checking for existance of $::album_dir/$single_directory/no_upload.txt",4,__LINE__);

				# If no_upload.txt file is present in this dir, don't show it on the upload menu
				if (!-e "$::album_dir/$single_directory/no_upload.txt" || isAdmin() eq 1 || (($::owner eq $::loggedin) && $::loggedin))
				{
					$::object.="<option value=\"$single_directory\"";

					# Code to set default upload dir to current album provided by Systematic
					if ($form->param('album') eq $single_directory)
					{
						$::object.=" selected"
					}
					$::object.=">";

					# Indent sub albums
					$::temp=$::scan_depth;
					while ($::temp)
					{
						$::object.=$::S{272};
						$::temp--;
					}
	#				if ($already_scanned)
	#				{
						$::object.=$::S{273};
	#				}

					if ($::shortdesc)
					{
						$::object.="$::shortdesc";
					}
					else
					{
						$::object.="$single_directory";
					}
					$::object.="</option>\n";
				}
				else
				{
					debug("Skipping $::album_dir/$already_scanned/$single_directory because no_upload.txt was found.",3,__LINE__);
				}
			}
			elsif (!$::doing_upload)
			{
			my $tempstatic=$::create_html_flag;

				print "$::full_directory...";
				if ($::create_html_flag le 1)
				{
					print "<br /><ul>";
				}
				print "\n\n";

				# Re-Read configuration file settings
				readConfig($::configfile);

				# Read localized configuration file settings for this album
				readConfig("$::album_dir/$::full_directory/album.cfg",1);

				# Restore static setting, in case it was zero'd out here
				$::create_html_flag=$tempstatic;

				if ($::create_html_flag)
				{
					# *** Temporary action to remove icons, jump menu, buttons and legend for static html... (notify is OK)
					$::usebuttons=$::jump_to=$::icons=$::legend=$::notify=$::photos_per_page=0;
				}

				# Generate static HTML for $::full_directory
				debug("Calling photoAlbum($::full_directory)",4,__LINE__);

				photoAlbum($::full_directory);
				debug("Back from photoAlbum($::full_directory) call.",4,__LINE__);
			}

			$::debug_num_recurses++;

# Un comment to stop recursing (added when testing started to run away)
#if ($::debug_num_recurses lt 3)
#{
			debug("Calling recursiveScan($::full_directory,$single_directory)",4,__LINE__);
			recursiveScan($::full_directory,$single_directory);
			debug("Back from recursiveScan($::full_directory,$single_directory) call.",4,__LINE__);
			debug("Recursion $::debug_num_recurses...",2,__LINE__);
#}
#else
#{
	debug("Recursion Stopped.",2,__LINE__);
#}

			# Pop back up a level
			$::scan_depth--;
		}

		# Generate HTML for pictures too
		elsif (!$::doing_upload && (-s "$::full_directory") && (isAPhotoOrJp2($::full_directory)) || $::searchstring)
		{
			$photo_filename=$::full_directory;
			# strip off all but the filename
			$photo_filename=~s/.*\/(.*)/$1/;
			$filename_only=$photo_filename;

			$::photo_and_path=$::full_directory;
			# strip off the album_dir
			$::photo_and_path=~s/$::album_dir\/(.*)/$1/;

			if ($already_scanned)
			{
				# This used to be a typo so $photo_filename wasn't being set, and everything seemed to work. If something is broken, take this out. (I haven't tested it)
#				$photo_filename="Picture: $already_scanned/$photo_filename";
				# Maybe this is what I meant:
				$photo_filename="$already_scanned/$photo_filename";
			}

			# Do any per file processing here

			# Search (filename)
			if ($::searchstring)
			{
				if ($::searchfilenames)
				{
					debug("Searchimg $filename_only for $::searchstring",4,__LINE__);
					if ($filename_only=~/$::searchstring/i)
					{
						debug("Found a MATCH (file): $filename_only - Storing $photo_filename",4,__LINE__);
						if(isViewable($::full_directory,$photo_filename,"1"))
						{
							push @::searchresults,"$photo_filename";
						}
					}
				}
			}
			else
			{
				debug("Generating photo HTML for $photo_filename",2,__LINE__);
				if ($::create_html_flag le 1)
				{
					print "<li>";
				}
				print "$photo_filename\n";
				if ($::create_html_flag le 1)
				{
					print "<br />";
				}
				$::static_photos_done++;
				debug("Calling photoAlbum($::photo_and_path)",4,__LINE__);
				photoAlbum("$::photo_and_path");
				debug("Back from photoAlbum($::photo_and_path) call.",4,__LINE__);
			}
		}
	}
	debug("Done with $scan_directory...",2,__LINE__);
	if (!$::doing_upload)
	{
		if ($::create_html_flag le 1)
		{
			print "</ul>";
		}
		print "\n";
	}

	debug("Leaving subroutine: recursiveScan($scan_directory,$already_scanned)",4,__LINE__);
}


##########################################################################

=head3 isAPhoto()

 isAPhoto($photo_name);

 $photo_name - name of picture file

Returns 1 if the filename passed in is that of a valid "photo", 2 if it is a link to a photo, or 0 otherwise.

=cut
sub isAPhoto
{
my $flag=0;
my $photo_name=shift;
my $imgext;

	debug("Checking to see if $photo_name is a photo...",4,__LINE__);

	if ($photo_name=~/^$::thumbprefix/i)
	{
		$flag=0;
	}
	else
	{
		foreach $imgext (@::imgexts)
		{
			if ($photo_name=~/.*\.$imgext$/i)
			{
				$flag=1;
				debug("Yep, it's a photo.",4,__LINE__);
			}
		}

		# Check for link files
		if ($photo_name=~/.*\.$::linkext$/i)
		{
			$flag=2;
			debug("Yep, it's a photo (actually, a link to a photo).",4,__LINE__);
		}

	}
	return($flag);
}


##########################################################################

=head3 isAThumb()

 isAThumb($photo_name);

 $photo_name - name of picture file

Returns 1 if the filename passed in is a thumbnail, or 0 otherwise.

=cut
sub isAThumb
{
my $photo_name=shift;

	debug("Checking to see if $photo_name is a thumbnail...",4,__LINE__);

	if ($photo_name=~/^$::thumbprefix/i)
	{
		return(1);
	}
	else
	{
		return(0);
	}
}


##########################################################################

=head3 isAMovie()

 isAMovie($movie_name);

 $movie_name - name of movie file

Returns 1 if the filename passed in is that of a valid "movie", 0 otherwise.

=cut
sub isAMovie
{
my $flag=0;
my $movie_name=shift;
my $movieext;

	debug("Checking to see if $movie_name is a movie...",4,__LINE__);

	# *** I may want to add a test to see if $movie_name is a readable file as well, but that might cause problems for relative paths, if they're used

	if ($movie_name=~/^$::thumbprefix/i)
	{
		$flag=0;
	}
	else
	{
		foreach $movieext (@::movieexts)
		{
			if ($movie_name=~/.*\.$movieext$/i)
			{
				$flag=1;
				debug("Yep, it's a movie.",4,__LINE__);
			}
		}
	}
	return($flag);
}



##########################################################################

=head3 getLinkURL()

 $linkurl=getLinkURL($linkfile);

 $linkurl - Returns the actual location of the photo (relative to $::album_dir) given it's link file location.
 $linkfile - Location of the link file, either absolite file path or relative to $::album_dir.

Opens the specified link file and extracts the actual location of the image, which is returned.

=cut
sub getLinkURL
{
use strict;

my $linkfile=shift;
my $linkurl;
my $data;

	debug("Entering subroutine: getLinkURL($linkfile)",4,__LINE__);

	if (!-r $linkfile)
	{
		if (!-r "$::album_dir/$linkfile")
		{
			$::warning.="$::S{20} $linkfile";
			return();
		}
		else
		{
			$linkfile="$::album_dir/$linkfile";
		}
	}

	open(LINKFILE,"$linkfile") or die "$!";
	while ($data=<LINKFILE>)
	{
		debug("Data: [$data]",4,__LINE__);
		if ($data=~/^URL=(.*)/)
		{
			$linkurl=$1;

			# Change all \'s to /'s
			$linkurl=~s/\\/\//g;
		}
	}
	close(LINKFILE);

	debug("URL to photo: $linkurl",4,__LINE__);
	debug("Leaving subroutine: getLinkURL($linkfile)",4,__LINE__);

	return($linkurl);
}


##########################################################################

=head3 Authenticate()

 $authenticated=Authenticate($mode);

 $authenticated - Returns 1 if the user was successfully authenticated, otherwise zero.
 $mode - Alternate authentication mode. For UBB, this means Junior Members are not permitted, and will always return zero. (Used to prohibit junior members from uploading).

Authenticates the global variables $::username and $::password, using the specified method. Returns 1 for a successful authentication, otherwise 0. Populates $::mem_level, the membership level assigned when authentication type is 5

=cut
sub Authenticate
{
my $data="";
my $auth=0;
my $storedpass="";
my $pwseed;
my $member_status;
my $dbi_fail;
my $mode=shift;
my $memberslist;

# Hard coded value for a UBB Junior Member
my $junior="Junior Member";

	debug("Entering subroutine: Authenticate",4,__LINE__);

	$::usernumber="";

	# Load cookie login information, if present
	if (!$::password)
	{
		$::cookielogin=cookieLogin();
	}

	# UBB authentication
	if ($::authentication_type eq 2)
	{
		debug("Using UBB Authentication (type $::authentication_type)",2,__LINE__);

		$memberslist="$::membersdir/memberslist.cgi";

		open (FILE,"$memberslist") || error(__LINE__,"not_readable","$memberslist: $!");
		while ($data=<FILE>)
		{
			if ($data=~/^$::username\|/i)
			{
				$::usernumber=$data;
				chomp($::usernumber);
				$::usernumber=~s/.*\|(.*)/$1/;
			}
		}
		close(FILE);

		# Only process if a user was found
		if ($::usernumber)
		{
			# Set "logged in" user
			$::loggedin=$::usernumber;

			# Return 0 if not found, to stop username guesses
			open (FILE,"$::membersdir/$::usernumber.cgi") || return(0);
			$storedpass=<FILE>;
			$storedpass=<FILE>;
			$::displayname=<FILE>;
			$::displayname=<FILE>;
			$::displayname=<FILE>;
			$::displayname=<FILE>;
			$::displayname=<FILE>;
			$::displayname=<FILE>;
			$member_status=<FILE>;
			$::displayname=<FILE>;
			$::displayname=<FILE>;
			$::displayname=<FILE>;
			$::displayname=<FILE>;
			$::displayname=<FILE>;
			$::displayname=<FILE>;
			$::displayname=<FILE>;
			chomp($storedpass);
			chomp($member_status);
			close(FILE);

			if (!$::displayname)
			{
				$::displayname=$::username;
			}

			# If using alternate authentication, and the member is a junior member, stop now
			if (($member_status eq $junior) && $mode)
			{
				$::mem_level=0;
				debug("Authentication set to fail: User was a $member_status",3,__LINE__);
				require $::display_module;
				print javaAlert("$::S{42} $::displayname $::S{278} $member_status $::S{279}");
				exit(1);

			}
			if ($member_status eq $junior)
			{
				$::mem_level=1;
			}
			else
			{
				$::mem_level=2;
			}
		}
	}

	# Load YaBB username/password
	if ($::authentication_type eq 3)
	{
		debug("Using YaBB Authentication (type $::authentication_type)",2,__LINE__);

		# Set "logged in" user
		$::loggedin=$::username;

		# Try YaBB 2
		debug("Looking for YaBB 2 file: [$::membersdir/$::username.vars]",2,__LINE__);
		if (-e "$::membersdir/$::username.vars")
		{
			$memberslist="$::membersdir/$::username.vars";

			debug("Found YaBB 2 file: $memberslist",2,__LINE__);

			# Return 0 if not found, to stop username guesses
			open(FILE,"$memberslist") || return(0);
			$keepgoing=1;
			while ($keepgoing) {
				$storedpass=<FILE>;
				debug("$memberslist: $storedpass",4,__LINE__);
				if ($storedpass=~/^'password'/)
				{
					$keepgoing=0;
				}
			}

			$::displayname=<FILE>;
			close(FILE);

			debug("Found YaBB 2 file: $memberslist with data ($storedpass|$::displayname)",2,__LINE__);

			$storedpass =~ s/\'(.*?)\'\,\"(.*?)\"/$2/ig;
			$::displayname =~ s/\'(.*?)\'\,\"(.*?)\"/$2/ig;

			chomp($storedpass);

			debug("Reformatted to: ($storedpass|$::displayname)",2,__LINE__);
		}
		else
		{
			$memberslist="$::membersdir/$::username.dat";

			debug("Looking for YaBB file: $memberslist",2,__LINE__);

			# Return 0 if not found, to stop username guesses
			open(FILE,"$memberslist") || return(0);
			$storedpass=<FILE>;
			$::displayname=<FILE>;
			close(FILE);
		}

		chomp($storedpass);
		chomp($::displayname);

		debug("Password / Displayname: [$storedpass] [$::displayname]",2,__LINE__);

		if ($::loggedin)
		{
			$::mem_level=2;
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
	my $maybedisplayname;

		debug("Using database Authentication (type $::authentication_type)",2,__LINE__);

		if ($::username)
		{
			# Set "logged in" user
			$::loggedin=$::username;

			# Connect to database
			$dbh=DBI->connect("DBI:$::db_driver:$::db_name:$::db_hostname:$::db_port",$::db_user,$::db_password) || die $DBI::errstr;

			# Build SQL command
			$user_sql="SELECT $::db_passwdfield";

			if ($::db_displaynamefield)
			{
				$user_sql.=",$::db_displaynamefield";
			}

			if ($::db_passwordSaltfield)
			{
				$user_sql.=",$::db_passwordSaltfield";
			}

			$user_sql.=" FROM $::db_membertable WHERE $::db_username = '$::username'";

			debug("SQL query: $user_sql",2,__LINE__);

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
				debug("Query returned $rv rows.",2,__LINE__);

				# Check for errors
				if (!$rv)
				{
					$::warning.="$::S{293}$::S{221} ";
					$::warning.=$sth->errstr."<br />";
				}

				# Fetch Rows
				while(@row=$sth->fetchrow_array)
				{
					$storedpass=$row[0];
					debug("\$row[0]=$storedpass",2,__LINE__);

					$maybedisplayname=$row[1];
					debug("\$row[1]=$maybedisplayname",2,__LINE__);

					if ($maybedisplayname)
					{
						$::displayname=$maybedisplayname;
					}

					$maybepasswordSalt=$row[2];
					debug("\$row[1]=$maybepasswordSalt",2,__LINE__);

					if ($maybepasswordSalt)
					{
						$::passwordSalt=$maybepasswordSalt;
					}

					$::mem_level=2;
				}
				# Finish and disconnect from database
				$sth->finish();
				$dbh->disconnect;
			}
			else
			{
				$::warning.="$::S{293}$::S{226}<br />";
			}

			debug("Warning is currently: $::warning",2,__LINE__);
			debug("Stored password is: $storedpass",2,__LINE__);
		}
		else
		{
			debug("No user logged in - DB check skipped.",2,__LINE__);
		}
	}

	# AmLite authentication
	if ($::authentication_type eq 5)
	{
		debug("Using AmLite Authentication (type $::authentication_type)",2,__LINE__);

		my $lines;
		my @database_array;
		my @edit_array;

		$memberslist="$::membersdir/jfmm_data.php";

		open (FILE,"$memberslist") || return(0);
		@database_array = <FILE>;
		close (FILE);
		debug("database array is : @database_array",4,__LINE__);
		foreach $lines(@database_array)
		{
			@edit_array = split(/\:/,$lines);
			debug("edit array is : @edit_array",4,__LINE__);
			$::username="\L$::username";
			if ($edit_array[0] eq $::username)
			{
				debug("--> It's a match!",3,__LINE__);
				$storedpass=$edit_array[1];
				$::displayname=$edit_array[3]." ".$edit_array[4];
				$::loggedin=$edit_array[0];
				$::mem_level=$edit_array[5];
				if ($::mem_level eq "Guest")
				{
					$::mem_level=0;
				}
				elsif ($::mem_level eq "Family")
				{
					$::mem_level=1;
				}
				elsif ($::mem_level eq "Friend")
				{
					$::mem_level=2;
				}
				debug("--> member level is $::mem_level",3,__LINE__);
			}
			else
			{
				debug("--> Does not match.",3,__LINE__);
			}
		}
		$lines = "";
		@edit_array = @database_array = "";
	}

	# Flatfile authentication
	if ($::authentication_type eq 1)
	{
		debug("Using Flatfile Authentication (type $::authentication_type)",2,__LINE__);

		# Open the text database
		open(AUTH_DB,$::auth_db) || error(__LINE__,"open_db","$::auth_db");

		# First check if user exists
		while (<AUTH_DB>)
		{
			chomp;
			($data,$storedpass)=split('\|',$_);
			chomp($data);
			$data=~s/[\n\r]//g;
			$storedpass=~s/[\n\r]//g;
			chomp($storedpass);
			if ($::username eq $data)
			{
				last;
			}
		}
		close(AUTH_DB);

		if ($::username eq $data)
		{
			$::displayname=$::username;

			# Set "logged in" user
			$::loggedin=$::username;
			$::mem_level=2;
		}
		else
		{
			$storedpass="";
		}
	}

	# Check for encrypted/hashed passwords stored in cookies
	$storedpass=checkPassword($::password,$storedpass);

	# Check for encrypted/hashed passwords stored on server
	$::password=checkPassword($storedpass,$::password);

	# If display name is not already set, then just use the username
	if (!$::displayname)
	{
		$::displayname=$::username;
	}

	chomp($::displayname);
	chomp($storedpass);

	# Anonymous, and no other controls are set
	if (!$::authentication_type && !$::protect_album && !$::album_password)
	{
		debug("Using Anonymous Authentication (type $::authentication_type)",2,__LINE__);

		$storedpass=$::password;
		$::displayname=$::username;
		$auth=1;
	}

	# Anonymous, with a password
	if (!$::authentication_type && $::album_password)
	{
		$storedpass=$::album_password;
	}

	# Check the password
	if ($::password eq $storedpass && $::password)
	{
		$auth=1;
	}
	else
	{
		# If not authenticated, blow away the username. Not doing this opens up a huge hole - users can get into the admin menu knowing only the username of the admins!
		$::loggedin="";
	}

	debug("Username: $::username",3,__LINE__);
	debug("Entered Password: $::password",3,__LINE__);
	debug("Stored Password: $storedpass",3,__LINE__);
	if ($::authentication_type eq 2)
	{
		debug("Member #: $::usernumber",3,__LINE__);
	}
	debug("Authenticated: $auth",3,__LINE__);

	# Reset cookie login to show if login was successful or not
	if ($::cookielogin)
	{
		$::cookielogin=$auth;
	}

	debug("Username: $::username : Password: $::password : Cookielogin: $::cookielogin : Auth: $auth : Header: $::header_printed",3,__LINE__);
#	print "Username: $::username : Password: $::password : Cookielogin: $::cookielogin : Auth: $auth : Header: $::header_printed";

	# Set album cookie
#	if (($::username && $::password) && !$::cookielogin && $auth && !$::header_printed)
	if (($::username && $::password) && !$::cookielogin && $auth)
	{

		use CGI qw(:standard);

		eval("use CGI::Cookie;");

		if ($@!~/^Can't locate/)
		{
		my $cookie1;
		my $cookie2;

			debug("\$auth=$auth",3,__LINE__);
			debug("\$::cookielogin=$::cookielogin",3,__LINE__);
			debug("Setting cookie ($::username/$::password)",3,__LINE__);
			if ($::authentication_type eq 5)
			{
				if ($function eq $::update_desc || $function eq $::update_rating || ($form->param('confirmdeleteobject') && $form->param('yes')) || ($form->param('confirmmoveobject') && $form->param('yes')) || ($form->param('confirmlinkobject') && $form->param('yes') && !$::default_linkdir))
				{
				}
				else
				{
					$pwseed='amlite';
					$::password=crypt($::password,$pwseed);
				}
			}

			debug("Remember logins via cookie:".$form->param('login_memory'),3,__LINE__);

			if($form->param('login_memory') eq "yes")
			{
				# Set cookies with a 5 year expiry
				debug("Setting cookie ($::username/$::password/five year)",3,__LINE__);
				eval("\$cookie1=new CGI::Cookie(-name=>\$::albumcookieusername,-value=>\$::username,-expires=>'+5y');");
				eval("\$cookie2=new CGI::Cookie(-name=>\$::albumcookiepassword,-value=>\$::password,-expires=>'+5y');");
			}
			else
			{
				# Set cookies to expire at session close
				debug("Setting cookie ($::username/$::password/session)",3,__LINE__);
				eval("\$cookie1=new CGI::Cookie(-name=>\$::albumcookieusername,-value=>\$::username);");
				eval("\$cookie2=new CGI::Cookie(-name=>\$::albumcookiepassword,-value=>\$::password);");
			}
			eval("print header(-cookie=>[\$cookie1,\$cookie2]);");

			# Now we have logged in via a cookie
			$::cookielogin=1;

			# Don't print the HTML header - we just did that
			$::header_printed=1;
		}
	}

	debug("Did authentication come from a cookie? (\$::cookielogin): $::cookielogin",3,__LINE__);

	debug("Leaving subroutine: Authenticate",4,__LINE__);

	return($auth);
}


##########################################################################

=head3 checkPassword()

 $goodpass=checkPassword($mypassword,$storedpass);

 $goodpass - The password that matched, if found. (Otherwise, the stored password ($storedpass) is returned).
 $mypassword - The password that the user has entered.
 $storedpass - The password on file for that user.

Checks $mypassword against $storedpass using all known encryption methods, and returns a copy of the "good" (clear) password, if found

=cut
sub checkPassword
{
my $mypassword=shift;
my $storedpass=shift;
my $passcheck;
my $pwseed;

	debug("Entering subroutine: checkPassword($mypassword,$storedpass);",4,__LINE__);

	# Check to ensure we have stuff to check
	if (!$mypassword || !$storedpass)
	{
		return($storedpass);
	}

	# Check plaintext
	if ($mypassword eq $storedpass)
	{
		return($mypassword);
	}

	# YaBB Security Mod
	# Code added from clubSTi.com (Gerlando)
	$pwseed ||= 'ya';
	$passcheck=crypt($mypassword,$pwseed);
	debug("Trying YaBB Security Mod encryption: $passcheck",3,__LINE__);
	if ($passcheck eq $storedpass)
	{
		debug("--> It's a match!",3,__LINE__);
		return($passcheck);
	}
	else
	{
		debug("--> Does not match.",3,__LINE__);
	}

	# Crypt
	$pwseed=$mypassword;
	$pwseed=~s/(..).*/$1/;
	$passcheck=crypt($storedpass,$pwseed);
	debug("Trying crypt() encrypted password: $passcheck",3,__LINE__);
	if ($passcheck eq $mypassword)
	{
		debug("--> It's a match!",3,__LINE__);
		return($passcheck);
	}
	else
	{
		debug("--> Does not match.",3,__LINE__);
	}

	$truncmypassword=substr($mypassword,0,13);
	debug("Trying truncated crypt() encrypted password: $truncmypassword ($passcheck)",3,__LINE__);
	if ($truncmypassword eq $passcheck)
	{
		debug("--> It's a match!",3,__LINE__);
		return($mypassword);
	}
	else
	{
		debug("--> Does not match.",3,__LINE__);
	}

#### If you're having MD5 "include" problems, delete everything from this line to the line like it below. ####

	if (!$::skip_md5)
	{
		# Check for MD5 package, include if present
		my $pkg="Digest";
		my $method="MD5";
		eval("use ".$pkg."::".$method."()");
#		eval("use ".$pkg.";\n".$pkg."::".$method."()");

		if ($@!~/^Can't locate/)
		{
			# MD5 (Hex)
			eval("use ".$pkg."::".$method."  qw(md5_hex);");

			# If not, throw a warning
			if ($@)
			{
				$::warning.="Could not import $pkg::$method (md5_hex) ($@). Continuing anyway...<br />";
			}

			eval { $passcheck=md5_hex($storedpass); };

			debug("Trying md5_hex hashed cookie password: $passcheck",3,__LINE__);
			if ($passcheck eq $mypassword)
			{
				debug("--> It's a match!",3,__LINE__);
				return($passcheck);
			}
			else
			{
				debug("--> Does not match.",3,__LINE__);
			}

			# Use the UBB.Threads way: hash username and password
			eval { $passcheck=md5_hex($::username.$storedpass); };

			debug("Trying md5_hex hashed cookie of username ($::username) and password: $passcheck",3,__LINE__);
			if ($passcheck eq $mypassword)
			{
				debug("--> It's a match!",3,__LINE__);
				return($passcheck);
			}
			else
			{
				debug("--> Does not match.",3,__LINE__);
			}

			# MD5 (Base 64)
			# Check to see if we can load the package
			eval("use ".$pkg."::".$method."  qw(md5_base64);");

			# If not, throw a warning
			if ($@)
			{
				$::warning.="Could not import md5_base64 ($@). Continuing anyway...<br />";
			}

			eval { $passcheck=md5_base64($storedpass); };

			debug("--> Trying $pkg::$method (md5_base64) hashed cookie password: $passcheck.",3,__LINE__);

			if ($passcheck eq $mypassword)
			{
				debug("--> It's a match!",3,__LINE__);
				return($passcheck);
			}
			else
			{
				debug("--> Does not match.",3,__LINE__);
			}

			# Plain MD5
			# Check to see if we can load the package
			eval("use ".$pkg."::".$method."  qw(md5);");

			# If not, throw a warning
			if ($@)
			{
				$::warning.="Could not import $pkg::$method (md5) ($@). Continuing anyway...<br />";
			}

			eval { $passcheck=md5($storedpass); };

			debug("--> Trying plain md5 hashed cookie password: $passcheck.",3,__LINE__);
			if ($passcheck eq $mypassword)
			{
				debug("--> It's a match!",3,__LINE__);
				return($passcheck);
			}
			else
			{
				debug("--> Does not match.",3,__LINE__);
			}
		}
		else
		{
				debug("Could not import $pkg::$method: ($@)",3,__LINE__);
		}

	}

#### If you're having MD5 "include" problems, delete everything from this line to the line like it above. ####

#### If you're having HMAC_MD5 "include" problems, delete everything from this line to the line like it below. ####

	if (!$::skip_hmac)
	{
		# Check for HMAC package, include if present
		my $pkg="Digest";
		my $method="HMAC_MD5";
		eval("use ".$pkg."::".$method."()");
#		eval("use ".$pkg.";\n".$pkg."::".$method."()");

		if ($@!~/^Can't locate/)
		{
			# YaBB SE "double" MD5 HMAC
			# Check to see if we can load the package
			eval("use ".$pkg."::".$method." qw(hmac_md5_hex);");

			# If not, throw a warning
			if ($@)
			{
				$::warning.="Could not import $pkg::$method (hmac_md5_hex) ($@). Continuing anyway...<br />";
			}

			eval { $passcheck=hmac_md5_hex($storedpass,$::username); };

			debug("--> Trying hmac_md5_hex hashed cookie password: $passcheck (key: $storedpass - $::username).",3,__LINE__);
			if ($passcheck eq $mypassword)
			{
				debug("--> It's a match!",3,__LINE__);
				return($passcheck);
			}
			else
			{
				debug("--> Does not match.",3,__LINE__);
			}

			# SMF 1.0 Authentication
			eval { $passcheck=hmac_md5_hex($storedpass,"ys"); };

			debug("--> Trying hmac_md5_hex hashed cookie password for SMF 1.0: $passcheck (key: $storedpass - \"ys\").",3,__LINE__);
			if ($passcheck eq $mypassword)
			{
				debug("--> It's a match!",3,__LINE__);
				return($passcheck);
			}
			else
			{
				debug("--> Does not match.",3,__LINE__);
			}

		}
		else
		{
				debug("Could not import $pkg::$method: ($@)",3,__LINE__);
		}
	}

#### If you're having HMAC_MD5 "include" problems, delete everything from this line to the line like it above. ####

	if (!$::skip_sha1)
	{
		# Check for SHA1 package, include if present
		my $pkg="Digest";
		my $method="SHA1";
		eval("use ".$pkg."::".$method."()");
#		eval("use ".$pkg.";\n".$pkg."::".$method."()");

		if ($@!~/^Can't locate/)
		{
			# Check to see if we can load the package
			eval("use ".$pkg."::".$method." qw(sha1_hex);");

			# If not, throw a warning
			if ($@)
			{
				$::warning.="Could not import $pkg::$method (sha1_hex) ($@). Continuing anyway...<br />";
			}

			# SMF 1.1+ Authentication
			eval { $passcheck=sha1_hex($storedpass.$::passwordSalt); };

			debug("--> Trying sha1 hashed cookie password for SMF 1.1+: $passcheck (using: $storedpass.$::passwordSalt).",3,__LINE__);
			if ($passcheck eq $mypassword)
			{
				debug("--> It's a match!",3,__LINE__);
				return($passcheck);
			}
			else
			{
				debug("--> Does not match.",3,__LINE__);
			}
		}
		else
		{
				debug("Could not import $pkg::$method: ($@)",3,__LINE__);
		}
	}


	debug("Leaving subroutine: checkPassword($mypassword,$storedpass);",4,__LINE__);

	return($storedpass);
}


##########################################################################

=head3 loginStatus()

 $login_html=loginStatus();

 $login_html = The user's login status, as HTML.

Returns the user's login status as either a URL to the login page (if the user is not logged in) or as as "Welcome [username]" message (if the user is logged in).

=cut
sub loginStatus
{
my @chips;
my $singlechip;
my $data;
my $lastchip;
my $albumref;

	if ($::authentication_type)
	{
		if ($::authenticated)
		{
			if ($::displayname)
			{
				$data="&nbsp;$::S{178} $::displayname";
			}
			else
			{
				$data="&nbsp;$::S{178} $::username";
			}
			if (($::authentication_type eq 1) || ($::authentication_type eq 5))
			{
				if ($::textmenu)
				{
					$data.=" $S{98} ";
				}
				$data.="&nbsp;<a href=\"$::albumprog?function=$::logout_code\" class=\"optionslink\">";
				if ($::textmenu)
				{
					$data.=$::S{305};
				}
				else
				{
					$data.="<img class=\"button\" src=\"$::logout_button\" title=\"$::S{305}\" />";
				}
				$data.="</a>";
				if ($::textmenu)
				{
					$data.=" $S{98} ";
				}
			}
		}
		else
		{
			if ($::shortalbum eq $::rootalbumname)
			{
				$albumref="";
			}
			else
			{
				$albumref=";album=".$::goback."/".$::shortalbum;
			}
			$data="<a href=\"$::albumprog?function=$::login_code$albumref\" class=\"optionslink\">";
			if ($::textmenu)
			{
				$data.=" $::S{237}";
			}
			else
			{
				$data.="<img class=\"button\" src=\"$::login_button\" title=\"$::S{237}\" />";
			}
			$data.="</a>";
			if ($::textmenu)
			{
				$data.=" $S{98} ";
			}
		}
	}
	else
	{
		$data="$::S{178}$::S{295}";
	}

	return($data);
}


##########################################################################

=head3 cookieLogin()

 $status=cookieLogin();

 $status - 1 if login info was found, otherwise 0

Retrieves login information from the cookie (if found) and passes it back as $::username, $::password, $::usernumber (UBB) and $::displayname.

=cut
sub cookieLogin
{
my $chip;
my @chips;
my $singlechip;
my $chipcount;
my $lastchip;
my $mypassword;
my $myusername;
my $retcode=0;

# Change these if you've customized your YaBB cookie names...
my $YaBBusername="YaBBusername";
my $YaBBpassword="YaBBpassword";

# SMF default cookie name
my $SMFCookie="SMFCookie";

# Iconboard default cookie names
my $iBMemberID="iBMemberID";
my $iBPassWord="iBPassWord";

	debug("Entering subroutine: cookieLogin",4,__LINE__);

	# Check to see if the user has a cookie, and log them in with that.
	foreach $chip (%::cookie)
	{
		# Handle special case for eblah setting $username in the cookie value
		if ($lastchip=~/eblah_Logout/i && $::cookie{$lastchip}=~/username/i)
		{
			next;
		}

		# Check YaBB logins (username)
		if ($lastchip=~/^$YaBBusername.*/ && !$myusername && $::authentication_type eq 3)
		{
			debug("Found YaBB username info: $lastchip",3,__LINE__);
			$myusername=$chip;
			debug("\$myusername set to $myusername",3,__LINE__);
		}

		# Check YaBB logins (password)
		if ($lastchip=~/^$YaBBpassword.*/ && !$mypassword && $::authentication_type eq 3)
		{
			debug("Found YaBB password info: $lastchip",3,__LINE__);
			$mypassword=$chip;
			debug("\$mypassword set to $mypassword",3,__LINE__);
		}

		# Check phpbb logins
		if ($chip=~/^(phpbb2mysql_data|phpbb_data)/i && !$mypassword && !$myusername) # && $::authentication_type eq 4)
		{
		my $junk;
		my $chipdata=$::cookie{$chip};
			debug("Found phpbb password info: $chip --> $chipdata",3,__LINE__);

			# Crappy way to "unserialize" the cookie data
			($junk,$junk,$junk,$mypassword)=split("\"",$chipdata);
			my @temparray=split("\"",$chipdata);
			$myusername=pop(@temparray);
			if ($myusername!~/\d/)
			{
				$myusername=pop(@temparray);
			}
			debug("\$myusername starting as $myusername",3,__LINE__);
			$myusername=~tr/0-9/ /c;
			$myusername=~s/\s+//g;

			debug("\$myusername set to $myusername",3,__LINE__);
			debug("\$mypassword set to $mypassword",3,__LINE__);
		}

		# Check SMF logins
		if ($chip=~/^$SMFCookie/i && $::authentication_type eq 4)
		{
		my $junk;
		my $chipdata=$::cookie{$chip};
			debug("Found SMF password info: $chip --> $chipdata",3,__LINE__);

			# Crappy way to "unserialize" the cookie data
			($junk,$::usernumber,$junk,$mypassword)=split("\"",$chipdata);

			# Now user the userID to look up the username

			# Check for DBI package, include if present
			$dbi_fail=DBICheck();

			if (!$dbi_fail)
			{
			my $user_sql;
			my $dbh;
			my $sth;
			my $rv;
			my @row;
			my $maybedisplayname;

				debug("Using database Authentication (type $::authentication_type)",2,__LINE__);

				# Set "logged in" user
				$::loggedin=$::username;

				# Connect to database
				$dbh=DBI->connect("DBI:$::db_driver:$::db_name:$::db_hostname:$::db_port",$::db_user,$::db_password) || die $DBI::errstr;

				# Build SQL command
				$user_sql="SELECT `$::db_username`,`$::db_displaynamefield` FROM `$::db_membertable` WHERE `ID_MEMBER` = $::usernumber";

				debug("SQL query: $user_sql",2,__LINE__);

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
					debug("Query returned $rv rows.",2,__LINE__);

					# Check for errors
					if (!$rv)
					{
						$::warning.="$::S{293}$::S{221} ";
						$::warning.=$sth->errstr."<br />";
					}

					# Fetch Rows
					while(@row=$sth->fetchrow_array)
					{

						$myusername=$row[0];
						debug("\$row[0]=$myusername",2,__LINE__);

						$maybedisplayname=$row[1];
						debug("\$row[1]=$maybedisplayname",2,__LINE__);

						if ($maybedisplayname)
						{
							$::displayname=$maybedisplayname;
						}
					}

					# Finish and disconnect from database
					$sth->finish();
					$dbh->disconnect;
				}
			}

			debug("\$myusername set to $myusername",3,__LINE__);
			debug("\$mypassword set to $mypassword",3,__LINE__);
			debug("\$::displayname set to $::displayname",3,__LINE__);
			debug("\$::usernumber set to $::usernumber",3,__LINE__);
		}

		# Found Ikonboard username
		if ($lastchip=~/.*$iBMemberID.*/ && !$myusername && $::authentication_type eq 4)
		{
			debug("Found YaBB username info: $lastchip",3,__LINE__);
			$myusername=$chip;
			debug("\$myusername set to $myusername",3,__LINE__);
		}

		# Found Ikonboard passwords
		if ($lastchip=~/.*$iBPassWord.*/ && !$mypassword && $::authentication_type eq 4)
		{
			debug("Found Ikonboard password info: $lastchip",3,__LINE__);
			$mypassword=$chip;
			debug("\$mypassword set to $mypassword",3,__LINE__);
		}

		# Found YaBB 2 username
		if ($lastchip=~/^Y2User/ && !$myusername && $::authentication_type eq 3)
		{
			debug("Found YaBB 2 username: $lastchip",3,__LINE__);
			$myusername=$chip;
			debug("\$myusername set to $myusername",3,__LINE__);
		}

		# Found YaBB 2 password
		if ($lastchip=~/^Y2Pass/ && !$mypassword && $::authentication_type eq 3)
		{
			debug("Found YaBB 2 password info: $lastchip",3,__LINE__);
			$mypassword=$chip;
			debug("\$mypassword set to $mypassword",3,__LINE__);

			# Convert spaces to + in password
			$mypassword=~s/ /+/g;
		}

		# Found e-Blah username
		if ($lastchip=~/^eblah_un$/ && !$myusername && $::authentication_type eq 3)
		{
			debug("Found e-Blah username: $lastchip",3,__LINE__);
			$myusername=$chip;
			debug("\$myusername set to $myusername",3,__LINE__);
		}

		# Found e-Blah password
		if ($lastchip=~/^eblah_pw$/ && !$mypassword && $::authentication_type eq 3)
		{
			debug("Found e-Blah password info: $lastchip",3,__LINE__);
			$mypassword=$chip;
			debug("\$mypassword set to $mypassword",3,__LINE__);
		}

		# UBB.Threads Username (or USERID)
		if ($lastchip=~/^ubbt_myid$/ && !$myusername && $::authentication_type eq 4)
		{
			debug("Found UBB.Threads username: $lastchip",3,__LINE__);
			$myusername=$chip;
			debug("\$myusername set to $myusername",3,__LINE__);
		}

		# UBB.Threads Password
		if ($lastchip=~/^ubbt_key$/ && !$mypassword && $::authentication_type eq 4)
		{
			debug("Found UBB.Threads password: $lastchip",3,__LINE__);
			$mypassword=$chip;
			debug("\$mypassword set to $mypassword",3,__LINE__);
		}

		# Handle arrays
		if ($chip=~/&/)
		{
			@chips=splitCookie($chip);
			$chipcount=0;
			foreach $singlechip (@chips)
			{
				debug("Processing \$singlechip [$singlechip], part of [$lastchip]",4,__LINE__);
				$chipcount++;

				# Check UBB logins
				if ($lastchip=~/^ubb.*/ && $::authentication_type eq 2)
				{
					debug("Found UBB login info: $lastchip",3,__LINE__);

					# Username first
					if ($chipcount eq 1 && !$myusername)
					{
						$myusername=$singlechip;
						debug("\$myusername set to $myusername",3,__LINE__);
					}

					# Password second
					if ($chipcount eq 2 && !$mypassword)
					{
						$mypassword=$singlechip;
						debug("\$mypassword set to $mypassword",3,__LINE__);
					}

					# display name third
					if ($chipcount eq 3)
					{
						$::displayname=$singlechip;
						debug("\$::displayname set to $::displayname",3,__LINE__);
					}

					# Member number fourth
					if ($chipcount eq 5)
					{
						$::usernumber=$singlechip;
						debug("\$::usernumber set to $::usernumber",3,__LINE__);
					}
				}
			}
		}

		# Check for a general password
		if ($lastchip=~/pass/i)
		{
			debug("Found generic password info: $chip",3,__LINE__);
			$mypassword=$chip;
			debug("\$mypassword set to $mypassword",3,__LINE__);

			# Convert spaces to + in password
			$mypassword=~s/ /+/g
		}

		# Check for a general userid
		if (($lastchip=~/userid/i || $lastchip=~/name/i) && ($lastchip!~/ogout/i && $chip!~/ogout/i))
		{
			debug("Found generic userid info: $chip ($lastchip)",3,__LINE__);
			$myusername=$chip;
			debug("\$myusername set to $myusername",3,__LINE__);
		}

		# Native album.pl cookie login info
		if ($lastchip=~/^$::albumcookieusername.*/)
		{
			debug("Found Native album.pl username info: $lastchip",3,__LINE__);
			$myusername=$chip;
			debug("\$myusername set to $myusername",3,__LINE__);
		}

		# Native album.pl cookie login info
		if ($lastchip=~/^$::albumcookiepassword.*/)
		{
			debug("Found Native album.pl password info: $lastchip",3,__LINE__);
			$mypassword=$chip;
			debug("\$mypassword set to $mypassword",3,__LINE__);
		}

		if ($::cookie{$chip})
		{
			debug("[$chip] = [$::cookie{$chip}] (u:$myusername-p:$mypassword)",3,__LINE__);
		}

		$lastchip=$chip;
	}

	# Discard "deleted" cookies
	if ($myusername=~/^deleted/ && $mypassword=~/^deleted/)
	{
		$myusername=$mypassword="";
	}

	# Return status flag (was login info found...)
	if  ($myusername && $mypassword)
	{
		$::username=$myusername;
		$::password=$mypassword;
		debug("Found username: $::username and password: $::password in cookie. (Maybe #:$::usernumber and name: $::displayname too...)",2,__LINE__);
		$retcode=1;
	}
	else
	{
		debug("No login information found in cookies.",2,__LINE__);
		$retcode=0;
	}

	debug("Leaving subroutine: cookieLogin --> return code is $retcode",4,__LINE__);
	return($retcode);
}


##########################################################################

=head3 openDescfile()

 openDescfile($descfilename);

 $descfilename - The full, filesystem path to the album you want to read descriptions from.

Opens up $descfilename so that photo/album titles/descriptions can be loaded.

=cut
sub openDescfile
{
my $descfilename=shift;

	# Close any open filehandles here
	close(DESC);

	$descfilename.=$::descname;
	debug("Looking for DescFile: [$descfilename]",3,__LINE__);
	if (-r $descfilename)
	{
		$::usedesc=1;
		open(DESC,"$descfilename");
		debug("Using DescFile: [$descfilename]",3,__LINE__);
	}
}


##########################################################################

=head3 getDescription()

 getDescription($desctoget,$mode);

 $desctoget - Photo or album to get description of
 $mode - 0 = Normal; 1 = Searching

Retrieves the title, description and owner of the provided object. Puts the title in $::shortdesc, the description in $::longdesc (if present) and the owner in $::owner (if present) and the view permission level in $::this_level (if present).

=cut
sub getDescription
{
my $desctoget=shift;
my $mode=shift;
my $descline;
my $prevline;
my $filename;
my $tempowner;
my $temp_level;
my $temp_file;
my $desctosearch;

	debug("Entering subroutine: getDescription($desctoget,$mode)",4,__LINE__);

	debug("Getting Description for [$desctoget] --> \$::usedesc=[$::usedesc]",3,__LINE__);

	# Clear variables, in case they're being re-used
	$::shortdesc=$::longdesc=$::owner=$::this_level="";

	# Haven't found a description yet.
	$::founddesc=0;

	# See if description exists
	if ($::usedesc && $desctoget)
	{

		# Clear $desctoget if it was just set as a placeholder
		if ($desctoget eq "./")
		{
			$desctoget="";
		}

		$desctosearch=quotemeta($desctoget);

		# Rewind description file
		seek(DESC,0,0);

		# Reset for search
		$prevline=$::desc_delim;

		while ($descline=<DESC>)
		{
			chomp($descline);
			$descline=~s/[\n\r]//g;
			chomp($descline);

			# Block codes
			$descline=~s/####/#\/###/sg;

			# Doing search
			if ($mode && ($::searchdescriptions || $::searchowners))
			{
				if ($::searchdescriptions)
				{
					if ($descline=~/$::searchstring/i && $prevline!~/^$::desc_delim$/)
					{
						debug("Found a MATCH (description) of $::searchstring in $descline for object $desctoget$filename",4,__LINE__);
						if(isViewable($desctoget,$filename,"2"))
						{
							push @::searchresults,"$desctoget$filename";
						}
					}
				}

				# Store off filenames and check owners
				if ($prevline=~/^$::desc_delim$/)
				{
					($filename,$tempowner,$temp_level)=split(":",$descline);
					if ($tempowner=~/$::searchstring/ && $::searchowners)
					{
						debug("Found a MATCH (owner) of $::searchstring in $descline for object $desctoget$filename",4,__LINE__);
						if(isViewable($desctoget,$filename,"2"))
						{
							push @::searchresults,"$desctoget$filename";
						}
					}
				}

				$prevline=$descline;
			}

			# Found the description we're looking for (not via the search screen)
			if ($descline=~/^$desctosearch$/i || $descline=~/^$desctosearch:.*$/i)
			{
#				$::owner=$descline;
#				$::owner=~s/.*:(.*)/$1/;
#				debug("$descline:$::owner",2,__LINE__);
#				if ($::owner eq $descline)
#				{
#					$::owner="";
#				}

				# Why was this here? I commented it out, because it was breaking ownership! (Mike: 01 Jul 04)
				#$descline=~s/(.*):.*/$1/;

				# Pull out owner and view level
				($temp_file,$::owner,$::this_level)=split(":",$descline);
#				if($::owner && !$::this_level)
#				{
#					$::this_level=$::owner;
#					$::owner="";
#				}

				debug("$::owner owns $descline",2,__LINE__);
				debug("object level is $::this_level",2,__LINE__);
				$::shortdesc=<DESC>;
				chomp($::shortdesc);
				$::longdesc="";
				my $longdescline="";
				while (($::longdescline=<DESC>) && ($::longdescline!~/^$::desc_delim\w*/))
				{
					$::longdesc.=$::longdescline."<br />\n";
				}
				$::founddesc=1;
			}
		}
		if (!$::founddesc)
		{
			$::shortdesc=$::longdesc="";
			debug("No description found.",3,__LINE__);
		}
		debug("ShortDesc: [$::shortdesc]",3,__LINE__);
		debug("LongDesc: [$::longdesc]",3,__LINE__);
	}

	debug("Leaving subroutine: getDescription($desctoget,$mode)",4,__LINE__);

}


##########################################################################

=head3 buildDescFooter()

 $add_desc_footer=buildDescFooter($status);

 $add_desc_footer - The HTML code for adding a description, which is returned.
 $status - 0 if building the whole form, 1 if building it as part of another form (like the create album form, for example).

Creates $directory in $basedir, and updates the description with $::shortdesc and $::longdesc.

=cut
sub buildDescFooter
{
my $add_desc_footer;
my $status=shift;

		# Form for entering a new description

	if (!$status)
	{
		$add_desc_footer=<<HTML;
<form name="descriptionform" method=\"post\" action=\"$::albumprog\">
HTML
	}

	$add_desc_footer.="$::S{190}<br />\n";

	if (!$status)
	{
		# Where do we go when we click submit?
		$add_desc_footer.="<input type=\"hidden\" name=\"";

		debug("Checking to see what type of object this is: $::album_dir -- $::realgoback -- $::next_obj",2,__LINE__);

		# If there's a next object and it's an album or a movie, or there is no next object and we're in an album, then return to an album
		if (($::next_obj && -d "$::album_dir/$::realgoback/$::next_obj") || isAMovie($::next_obj) || (!$::next_obj && $::album))
		{
			$add_desc_footer.="album\" value=\"";
			if (isAMovie($::next_obj))
			{
				$add_desc_footer.="$::realgoback";
			}
			else
			{
				if (-d "$::album_dir/$::middle")
				{
					$add_desc_footer.="$::middle";
				}
				else
				{
					$add_desc_footer.="$::realgoback/$::next_obj";
				}
			}
		}
		# If the next object is a photo, or if there is no next object and this is a photo, then return to a photo
		elsif (isAPhotoOrJp2($::next_obj) || (!$::next_obj && $::photo))
		{
			$add_desc_footer.="photo\" value=\"";
			if ($::next_obj)
			{
				$add_desc_footer.="$::realgoback/$::next_obj";
			}
			else
			{
				$add_desc_footer.=$::photo;
			}
		}

		$add_desc_footer.="\" />\n";

		# Where do we go when we click submit?
		if (isAPhotoOrJp2($::next_obj))
		{
			$add_desc_footer.="<input type=\"hidden\" name=\"photo2\" value=\"";
			if ($::photo)
			{
				$add_desc_footer.="$::photo";
			}
			if ($::album)
			{
				$add_desc_footer.="$::album";
			}
			$add_desc_footer.="\" />\n";
		}

		$add_desc_footer.="<input type=\"hidden\" name=\"desc_file_loc\" value=\"$::desc_to_update\" />\n";
		$add_desc_footer.="<input type=\"hidden\" name=\"object\" value=\"$::shortobject\" />\n";
	}

	if (!$status)
	{
		# Set the correct function
		$::function=$::update_desc;
		$add_desc_footer.=passVars(1);

		# Now set it back
		$::function=$::enter_desc;
	}

	$add_desc_footer.="<input type=\"text\" name=\"title\" size=\"30\" value=\"$::existing_shortdesc\" /><br /><br />\n";

	# Add userlist
	require $::admin_module;
	$add_desc_footer.=$::S{299}." ";
	$add_desc_footer.=getUserList()."<br />\n";

	$add_desc_footer.="$::S{191}<br />\n";
	$add_desc_footer.="<textarea rows=\"$::enterdesc_rows\" name=\"description\" cols=\"$::enterdesc_cols\">$::textlongdesc</textarea>\n";

	my $temp_this_level=translateLevel($::this_level,1);
	if($::authentication_type eq 5)
	{
		$add_desc_footer.="<br />$S{340}\&nbsp;<select size=\"1\" name=\"view_level\"><option selected>$temp_this_level</option><option>$S{341}</option><option>$S{342}</option><option>$S{343}</option><option>$S{299}</option></select>\n";
	}
	if($::authentication_type eq 2)
	{
		$add_desc_footer.="<br />$S{340}\&nbsp;<select size=\"1\" name=\"view_level\"><option selected>$temp_this_level</option><option>$S{341}</option><option>$S{346}</option><option>$S{345}</option><option>$S{299}</option></select>\n";
	}
	if($::authentication_type eq 1 || $::authentication_type eq 3 || $::authentication_type eq 4)
	{
		$add_desc_footer.="<br />$S{340}\&nbsp;<select size=\"1\" name=\"view_level\"><option selected>$temp_this_level</option><option>$S{341}</option><option>$S{345}</option><option>$S{299}</option></select>\n";
	}

	if (!$status)
	{
		$add_desc_footer.="<br /><br /><input type=\"checkbox\" name=\"stop_add_desc\" value=\"stop\" class=\"checkbox\"";

		# Just edit this one
		if ($form->param('editobject'))
		{
			$add_desc_footer.="checked";
		}

		$add_desc_footer.="/>";
		$add_desc_footer.="$::S{192}\n";
		$add_desc_footer.="<br /><br /><input type=\"submit\" value=\"$::S{193}\" class=\"button\" />\n";

		# If the next object is a photo, display the option to go to it.
		if (isAPhotoOrJp2($::next_obj))
		{
			$add_desc_footer.=" <input type=\"submit\" value=\"$::S{231}\" name=\"advance\" class=\"button\" />\n";
		}
		$add_desc_footer.="</form>\n";
		$add_desc_footer.=<<HTML;
<SCRIPT LANGUAGE="javascript">
<!--
document.descriptionform.title.focus();
//-->
</SCRIPT>
HTML
	}

	return($add_desc_footer);
}


##########################################################################

=head3 getPhotoDimensions()

 ($height,$width)=getPhotoDimensions($filepath);

 $height - Height of photo.
 $width - Width of photo.
 $filepath - Full filesystem path to the photo to check.

Uses Imagemagick to determine the size of a photo.

=cut
sub getPhotoDimensions
{
use strict;
my $system_call;
my $flag;
my $height;
my $width;
my $data;
my $filepath=shift;

	debug("Entering subroutine: getPhotoDimensions($filepath);",4,__LINE__);

	# Imagemagick is not installed
	if (!$::imagemagick)
	{
		debug("ImageMagick is not installed",4,__LINE__);
		$width=-1;
		$height=-1;
		return($height,$width);
	}

	# File is not an image
	if (isAPhotoOrJp2($filepath) ne 1)
	{
		debug("$filepath is not a photo or jp2",4,__LINE__);
		return();
	}

	# Check the size of the pic
	$system_call="\"$::imagemagick/identify\" \"$filepath\"";
	debug("IMAGEMAGICK: $system_call",3,__LINE__);

	open(IMAGEMAGICK,"$system_call|") || error(__LINE__,"cant_fork","$system_call: $!");

	$flag=1;

	while (($data=<IMAGEMAGICK>) && $flag)
	{
		debug("IMAGEMAGICK: $data",4,__LINE__);
		if ($data=~/\s*$filepath\s+(.*)/)
		{
			$data=$1;
			$data=~s/^(\w+) *(\d+x\d+).*/$2/;
			$height=$width=$data;
			$width=~s/(\d+)x(\d+)/$1/;
			$height=~s/(\d+)x(\d+)/$2/;
			$flag=0;
		}
	}

	close(IMAGEMAGICK);

	debug("$filepath size is as follows: $width wide by $height high.",2,__LINE__);

	debug("Leaving subroutine: getPhotoDimensions($filepath);",4,__LINE__);
	return($height,$width);

}


##########################################################################

=head3 showFooter()

 $footer=showFooter($show);

 $footer - HTML footer, if returned.
 $show - If set to 0, the footer simply returned, if set to 1, it is displayed and returned.

Rerturns or displays the HTML footer for all pages.

=cut
sub showFooter
{
my @allinfo;
my $revdate;
my $show=shift;

if ($::create_html_flag)
{
	$revdate=setDate();
	$revdate="$::S{80} $revdate";
}
else
{
	@allinfo=stat($0);
	$revdate=localtime($allinfo[9]);
}

my $footer="<br /><br />\n<small><small><a title=\"album.pl\n$::release Release\nWritten by Mike Bobbitt\n$revdate\" href=\"";

if ($::create_html_flag)
{
	$footer.="http://dev.bobbitt.ca/album";
}
else
{
	$footer.="$::albumprog?function=about";
}

	$footer.=<<HTML;
">$::S{95} V$::ver</a></small></small>
HTML

	# Check to see if the version is correct
	if (($::cfgver ne $::ver) && (($form->param('function') ne "$::config") && ($form->param('function') ne "$::updateconfig")))
	{
		$::warning.="$::S{81} $::cfgver $::S{82} $::ver $::S{83}<br />";
	}

	if ($::warning)
	{
		$footer.="<div class=\"warning\">$::warning</div>\n";
	}

	if ($show)
	{
		require $::display_module;
		display($footer);
	}
	return($footer);
}


##########################################################################

=head3 buildTemplate()

 $template=buildTemplate();

 $template = variable to pass the template back into

Builds the object template, and returns it.

=cut
sub buildTemplate
{
my $template;
my $shortdesctitle;
my $template_loaded;

	debug("Entering subroutine: buildTemplate();",4,__LINE__);

	$template_loaded=0;

	# Check for local templates, if not found add full path to template files

	# Album Template
	$::album_template=findTemplate($::original_album_template);

	# Photo Template
	$::photo_template=findTemplate($::original_photo_template);

	# Object Template
	$::object_template=findTemplate($::original_object_template);

	# Upload Template
	$::upload_template=findTemplate($::original_upload_template);

	# Login Template
	$::login_template=findTemplate($::original_login_template);

	debug("\$::album_template is now $::album_template",4,__LINE__);
	debug("\$::photo_template is now $::photo_template",4,__LINE__);
	debug("\$::object_template is now $::object_template",4,__LINE__);
	debug("\$::upload_template is now $::upload_template",4,__LINE__);
	debug("\$::login_template is now $::login_template",4,__LINE__);

	# Photo template
	if ($::photo)
	{
		open(TEMPLATE,"$::photo_template") || error(__LINE__,"not_readable","$::photo_template: $!");
		debug("Using Template File: [$::photo_template]",2,__LINE__);
		$template_loaded=1;
	}

	# Upload Template
	if ($::function eq $::upload)
	{
		open(TEMPLATE,"$::upload_template") || error(__LINE__,"not_readable","$::upload_template: $!");
		debug("Using Template File: [$::upload_template]",2,__LINE__);
		$template_loaded=1;
	}

	# Login Template
	if (($::function eq $::login_code) && !$::authenticated)
	{
		open(TEMPLATE,"$::login_template") || error(__LINE__,"not_readable","$::login_template: $!");
		debug("Using Template File: [$::login_template]",2,__LINE__);
		$template_loaded=1;
	}

	# Album template
	if (!$template_loaded)
	{
		open(TEMPLATE,"$::album_template") || error(__LINE__,"not_readable","$::album_template: $!");
		debug("Using Template File: [$::album_template]",2,__LINE__);
	}

	$template=join("",<TEMPLATE>);
	close(TEMPLATE);

	debug("Loaded object_template: [$template]",4,__LINE__);

	# Cut out HTML for title
	$shortdesctitle=$::shortdesc;
	$shortdesctitle=~s/<([^>]|\n)*>//g;
	if (!$shortdesctitle)
	{
		$shortdesctitle="$::S{87}";
	}

	# Handle SSI pages by ripping out everything but ####OBJECT#### from the templates. It's rough, but it works.
	if ($::ssi && ($::function ne $::login_code))
	{
		# Rip out everything
		$template="####OBJECT####";

		# ...and if we're doing a slideshow, we have to re-insert that stuff...
		if ($::slide_timer)
		{
			$template="####SLIDESHOW####$template";
		}

		# Re-add stylesheet tag
		$template="####STYLESHEET####$template";
	}

	# Substitute tags for actual data
	$template=substituteData($template);

	# Adjust style sheet link for static HTML (best when not burning to CD)
	if ($::create_html_flag)
	{
		#$template=~s/$::style_sheet/$::album_dir$::style_sheet/g;
	}

	debug("Leaving subroutine: buildTemplate();",4,__LINE__);

	return($template);
}


##########################################################################

=head3 buildNavFooter()

 $nav_footer=buildNavFooter($mode);

 $mode - 0 = Build entire Nav footer; 1 = Build "Previous" section only; 2 = Build "Up" section only; 3 = Build "Next" section only; 4 = Jump station only

Builds the navigaction footer, and returns it. (The navigation footer is the buttons/links that allow you to visit the next/previous photo or album.)

=cut
sub buildNavFooter
{
use strict;
my $mode=shift;
my $nav_footer;
my $temp;
my $static_photos_thumb_temp;
my $albumtemp;
my $isalbumtemp;
my $dotdot;
my $tempfilenum=$::filenum;

# Max length of button descriptions
my $desclen=25;

	debug("Entering subroutine: buildNavFooter()",4,__LINE__);

	debug("\$::page = [$::page]",2,__LINE__);
	debug("\$::numfiles = [$::numfiles]",2,__LINE__);
	debug("\$::photos_per_page = [$::photos_per_page] [$::rows]x[$::columns]",2,__LINE__);
	debug("\$tempfilenum = [$tempfilenum]",2,__LINE__);
	debug("\$::filenum = [$::filenum]",2,__LINE__);
	debug("\$::photo = [$::photo]",2,__LINE__);

	# Crappy modulo code that I wrote on the bus
	if ($::photo && $::photos_per_page)
	{
		debug("In the loop",2,__LINE__);
		$::page=1;
		while ($tempfilenum > $::photos_per_page)
		{
			$::page++;
			$tempfilenum-=$::photos_per_page;
			debug("Incrementing page to $::page [$tempfilenum]",2,__LINE__);
		}
	}
	debug("\$::page = [$::page]",2,__LINE__);

	# Display the "previous photo" link/button
	if (!$mode || $mode eq 1)
	{
		$nav_footer="<div class=\"navwidth\">\n";

		debug("\$::prev_obj = [$::prev_obj]",2,__LINE__);

		if ($::prev_obj)
		{
			# Text link and prev photo thumbnail
			if (!$::usebuttons || $::nextprevthumb)
			{
				$nav_footer.="<a href=\"";
				if (!$::create_html_flag)
				{
					$temp="";
					if ($::realgoback)
					{
						$temp="$::realgoback/";
					}
					$temp.=$::prev_obj;
					$temp=webifyLinks($temp);

					if (isAMovie($::prev_obj))
					{
						$nav_footer.=$::album_web."/".$temp;
					}
					else
					{
						$nav_footer.="$::albumprog?";
						if (isAPhotoOrJp2($::prev_obj))
						{
							$nav_footer.="photo";
						}
						else
						{
							$nav_footer.="album";
						}
						$nav_footer.="=$temp";
						$nav_footer.=passVars(0);
					}
				}
				else
				{
					# Check to see if it's a photo or an album
					if (isAPhotoOrJp2($::prev_obj) || isAMovie($::prev_obj))
					{
						$nav_footer.="$::prev_obj.html";
					}
					else
					{
						$nav_footer.="../$::prev_obj/$::static_html_filename";
					}
				}
				$nav_footer.="\" class=\"navlink\">\n";

				$static_photos_thumb_temp=$::static_photos_thumb;

				# Show previous object thumbnail
				if ($::nextprevthumb)
				{
					$albumtemp=$::album;
					if ($::album)
					{
						$::album=~s/(.*)\/.*/$1/;
					}
					$isalbumtemp=$::isalbum;
					$::isalbum=1;
					$temp=showThumb("$::realgoback/$::prev_obj");

					$nav_footer.=$temp;
					$::isalbum=$isalbumtemp;
					$::album=$albumtemp;

					# Align description
					if ($::descloc eq 1)
					{
						$nav_footer.="<br />\n";
					}
				}

				$::static_photos_thumb=$static_photos_thumb_temp;

				if (!$::usebuttons)
				{
					if ($::prev_obj_desc)
					{
						$nav_footer.="$::prev_obj_desc";
					}
					else
					{
						$nav_footer.="$::S{88}";
					}
				}
				$nav_footer.="</a>\n";
			}

			if ($::usebuttons)
			{
				$nav_footer.="<form method=\"post\" action=\"$::albumprog\">\n";
				$nav_footer.="<input type=\"submit\"";
				$nav_footer.=" value=\"$::S{89} ";
				if ($::prev_obj_desc)
				{
					# Strip out quotes
					$temp=$::prev_obj_desc;
					$temp=~s/"//g;
					debug("Length of $temp is ".length($temp)." and has a max of $desclen.",2,__LINE__);
					if (length($temp) > $desclen)
					{
						$temp=substr($temp,0,$desclen-3);
						$temp.=$::S{233};
					}

					$nav_footer.=$temp;
				}
				else
				{
					$nav_footer.="$::S{88}";
				}
				$nav_footer.="\" class=\"button\" />\n<input type=\"hidden\" name=\"";
				if (isAPhotoOrJp2($::prev_obj) || isAMovie($::prev_obj))
				{
					$nav_footer.="photo";
				}
				else
				{
					$nav_footer.="album";
				}
				$nav_footer.="\" value=\"";
				if ($::realgoback)
				{
					$nav_footer.="$::realgoback/";
				}
				$nav_footer.="$::prev_obj\" />\n";
			}
			$nav_footer.=passVars(1);

			if ($::usebuttons)
			{
				$nav_footer.="</form>";
			}
		}

		$nav_footer.="</div>\n";

	}

	# Display the "back to album" link/button
	if (!$mode || $mode eq 2)
	{
		$nav_footer.="<div class=\"navwidth\">\n";

		debug("\$::middle = [$::middle]",2,__LINE__);

		if ($::middle)
		{
			$static_photos_thumb_temp=$::static_photos_thumb;

			# Text link and prev photo thumbnail
			if (!$::usebuttons || $::nextprevthumb)
			{
				$nav_footer.="<a href=\"";
				$temp="";
				if ($::realgoback)
				{
					$temp="$::realgoback/";
				}

				if (!$::create_html_flag)
				{
					$temp=webifyLinks($temp);
					$nav_footer.="$::albumprog?";
					$nav_footer.="album";
					$nav_footer.="=".webifyLinks($::goback);

					# If we're looking at a photo, find out what page it's on, and go back "up" to that page.
					if ($::photo && $::photos_per_page)
					{
						$nav_footer.=$::webdelim."page=$::page";
					}
					$nav_footer.=passVars(0);
				}
				else
				{
					if ($::album)
					{
						$nav_footer.="../$::static_html_filename";
					}
					if ($::photo)
					{
						$nav_footer.="./$::static_html_filename";
					}
				}
				$nav_footer.="\" class=\"navlink\">\n";

				# Show parent object thumbnail
				if ($::nextprevthumb)
				{
					$temp=$::middle;

					# Strip off trailing block
					$temp=~s/(.*)\/.*/$1/;

					# Adjust for first level albums (off the root album)
					if ($temp eq $::shortalbum && $::album)
					{
						$temp=$::rootalbumname;
					}
					$temp=showThumb("$temp");

					# Back up one!
					if ($::goback)
					{
						$temp=~s/$::thumbprefix$::goback/$dotdot..\/$::thumbprefix$::goback/;
					}

					$nav_footer.=$temp;

					# Align description
					if ($::descloc eq 1)
					{
						$nav_footer.="<br />\n";
					}
				}

				$nav_footer.="</a>\n";
			}

			$::static_photos_thumb=$static_photos_thumb_temp;

			if ($::usebuttons)
			{
				$nav_footer.="<form method=\"post\" action=\"$::albumprog\">\n";
				$nav_footer.="<input type=\"submit\"";
			}
			else
			{
				$nav_footer.="<a href=\"";
			}
			if ($::create_html_flag)
			{
				if ($::album)
				{
					$nav_footer.="../$::static_html_filename";
				}
				if ($::photo)
				{
					$nav_footer.="./$::static_html_filename";
				}
			}
			if ($::usebuttons)
			{
				$nav_footer.=" class=\"button\" value=\"";
				if ($::back_desc)
				{
					# Strip out quotes
					$temp=$::back_desc;
					$temp=~s/"//g;

					if (length($temp) > $desclen)
					{
						$temp=substr($temp,0,$desclen-3);
						$temp.=$::S{233};
					}

					$nav_footer.=$temp;
				}
				else
				{
					$nav_footer.="$::S{90}";
				}
				$nav_footer.="\" />\n<input type=\"hidden\" name=\"album\" value=\"";
				$nav_footer.="$::goback";
				$nav_footer.="\" />\n";
				$nav_footer.="<input type=\"hidden\" name=\"page\" value=\"$::page\">";
			}
			if (!$::create_html_flag && !$::usebuttons)
			{
				$nav_footer.="$::albumprog?album=$::goback";
			}
			$nav_footer.=passVars(1);

			if ($::usebuttons)
			{
				$nav_footer.="</form>";
			}
			else
			{
				$nav_footer.="\" class=\"navlink\">\n";
				if ($::back_desc)
				{
	#				if ($::create_html_flag)
	#				{
	#					$nav_footer.="Back To Album";
						#### TODO This doesn't work for static, for some reason...
	#				}
	#				else
	#				{
						$nav_footer.="$::back_desc";
	#				}
				}
				else
				{
					$nav_footer.="$::S{90}";
				}
				$nav_footer.="</a>\n";
			}
		}

		$nav_footer.="</div>\n";
	}

	# Display the "next photo" link/button
	if (!$mode || $mode eq 3)
	{

		$nav_footer.="<div class=\"navwidth\">\n";

		debug("\$::next_obj = [$::next_obj]",2,__LINE__);

		if ($::next_obj)
		{
			# Text link and next photo thumbnail
			if (!$::usebuttons || $::nextprevthumb)
			{
				$nav_footer.="<a href=\"";
				if (!$::create_html_flag)
				{
					$temp="";
					if ($::realgoback)
					{
						$temp="$::realgoback/";
					}
					$temp.=$::next_obj;
					$temp=webifyLinks($temp);

					if (isAMovie($::next_obj))
					{
						$nav_footer.=$::album_web."/".$temp;
					}
					else
					{
						$nav_footer.="$::albumprog?";
						if (isAPhotoOrJp2($::next_obj))
						{
							$nav_footer.="photo";
						}
						else
						{
							$nav_footer.="album";
						}
						$nav_footer.="=$temp";
						$nav_footer.=passVars(0);
					}
				}
				else
				{
					if (isAPhotoOrJp2($::next_obj) || isAMovie($::next_obj))
					{
						$nav_footer.="$::next_obj.html";
					}
					else
					{
						$nav_footer.="../$::next_obj/$::static_html_filename";
					}
				}
				$nav_footer.="\" class=\"navlink\">\n";

				$static_photos_thumb_temp=$::static_photos_thumb;

				# Show next object thumbnail
				if ($::nextprevthumb)
				{
					$albumtemp=$::album;
					if ($::album)
					{
						$::album=~s/(.*)\/.*/$1/;
					}
					$isalbumtemp=$::isalbum;
					$::isalbum=1;
					$temp=showThumb("$::realgoback/$::next_obj");

					$nav_footer.=$temp;
					$::isalbum=$isalbumtemp;
					$::album=$albumtemp;

					# Align description
					if ($::descloc eq 1)
					{
						$nav_footer.="<br />\n";
					}
				}

				$::static_photos_thumb=$static_photos_thumb_temp;

				if (!$::usebuttons)
				{
					if ($::next_obj_desc)
					{
						$nav_footer.="$::next_obj_desc";
					}
					else
					{
						$nav_footer.="$::S{91}";
					}
				}
				$nav_footer.="</a>\n";
			}

			if ($::usebuttons)
			{
				$nav_footer.="<form method=\"post\" action=\"$::albumprog\">\n";
				$nav_footer.="<input type=\"submit\"";
			}
			if ($::usebuttons)
			{
				$nav_footer.="  class=\"button\" value=\"";
				if ($::next_obj_desc)
				{
					# Strip out quotes
					$temp=$::next_obj_desc;
					$temp=~s/"//g;

					if (length($temp) > $desclen)
					{
						$temp=substr($temp,0,$desclen-3);
						$temp.=$::S{233};
					}

					$nav_footer.=$temp;
				}
				else
				{
					$nav_footer.="$::S{91}";
				}
				$nav_footer.=" $::S{92}\" />\n<input type=\"hidden\" name=\"";
				if (isAPhotoOrJp2($::next_obj) || isAMovie($::next_obj))
				{
					$nav_footer.="photo";
				}
				else
				{
					$nav_footer.="album";
				}
				$nav_footer.="\" value=\"";
				if ($::realgoback)
				{
					$nav_footer.="$::realgoback/";
				}
				$nav_footer.="$::next_obj\" />\n";
			}
			$nav_footer.=passVars(1);

			if ($::usebuttons)
			{
				$nav_footer.="</form>";
			}
		}

		if (!$mode)
		{
			$nav_footer.="<br clear=\"all\">";
		}

		$nav_footer.="</div>\n";
	}

	if (!$mode)
	{
		# New line
		$nav_footer.="<br clear=\"all\">";
	}

	if (!$mode || $mode eq 4)
	{
		# Display jump station
		if ($::jump_to)
		{
			$nav_footer.=$::jump_station;
		}
	}

	debug("Leaving subroutine: buildNavFooter()",4,__LINE__);

	return($nav_footer);
}



##########################################################################

=head3 passVars()

 $vars=passVars($format);

 $vars = variable to pass the formed variables back into
 $format = 0: pass in web URL format (&debug=1&configfile=file, etc); 1: pass in button format (<input type="hidden"...); 2: same as zero, but no function code

Sees which variables must be passed (configfile, debug, static, etc), builds the string containing the data, and passes the value back.

=cut
sub passVars
{
my $vars;
my $tempfunc;
my $format=shift;
my $mypass=$::password;
my $myuser=$::username;

	# If function=login or checkupdate, then clear it
	if ($::function eq $::login_code || $::function eq $::checkupdate)
	{
		$tempfunc=$::function;
		$::function="";
	}

	# Strip quotes out of username/password
	$myuser=~s/"//g;
	$mypass=~s/"//g;

#	if (!$::usebuttons)
#	{
#		$format=0;
#	}

	if (!$format || $format eq 2)
	{
		# Exclude function code, when called with $format=2
		if (!$format)
		{
			if ($::function)
			{
				$vars.=$::webdelim."function=$::function";
			}
		}
		if ($::slide_timer)
		{
			$vars.=$::webdelim."slideshow=$::slide_timer";
		}

		if ($::configfilepassed)
		{
			$vars.=$::webdelim."configfile=$::configfile";
		}
		if ($::debug)
		{
			$vars.=$::webdelim."$::debug_code=$::debug";
		}

		if ($::photo_width)
		{
			$vars.=$::webdelim."photo_width=$::photo_width";
		}
		if ($::photo_height)
		{
			$vars.=$::webdelim."photo_height=$::photo_height";
		}
		if ($::fullscreen)
		{
			$vars.=$::webdelim."fullscreen=1";
		}
		if ($::ssi)
		{
			$vars.=$::webdelim."ssi=$::ssi";
		}
		# Only pass username/password if we're not using flatfile authentication
#		if ($::authentication_type lt 2 || !$::cookielogin)
		if (!$::cookielogin)
		{
			if ($mypass)
			{
				$vars.=$::webdelim."password=$mypass";
			}
			if ($myuser)
			{
				$vars.=$::webdelim."username=$myuser";
			}
		}
	}
	else
	{
		if ($::function)
		{
			$vars.="<input type=\"hidden\" name=\"function\" value=\"$::function\" />\n";
		}
		if ($::slide_timer_passed)
		{
			$vars.="<input type=\"hidden\" name=\"slideshow\" value=\"$::slide_timer\" />\n";
		}
		if ($::configfilepassed)
		{
			$vars.="<input type=\"hidden\" name=\"configfile\" value=\"$::configfile\" />\n";
		}
		if ($::debug)
		{
			$vars.="<input type=\"hidden\" name=\"$::debug_code\" value=\"$::debug\" />\n";
		}
		if ($mypass)
		{
			$vars.="<input type=\"hidden\" name=\"password\" value=\"$mypass\" />\n";
		}
		if ($myuser)
		{
			$vars.="<input type=\"hidden\" name=\"username\" value=\"$myuser\" />\n";
		}
		if ($::photo_width)
		{
			$vars.="<input type=\"hidden\" name=\"photo_width\" value=\"$::photo_width\" />\n";
		}
		if ($::photo_height)
		{
			$vars.="<input type=\"hidden\" name=\"photo_height\" value=\"$::photo_height\" />\n";
		}
		if ($::fullscreen)
		{
			$vars.="<input type=\"hidden\" name=\"fullscreen\" value=\"1\" />\n";
		}
		if ($::ssi)
		{
			$vars.="<input type=\"hidden\" name=\"ssi\" value=\"$::ssi\" />\n";
		}
	}

	# Restore function, if required
	if (!$::function)
	{
		$::function=$tempfunc;
	}

	return($vars);
}


##########################################################################

=head3 printHeader()

 $header=printHeader($mode);

 $header - The formed header, with style sheet or body colour tags, is returned.
 $mode - 0 = Return all header HTML; 1 = Return just style sheet tag

Prints out either the style sheet or a generic body tag.

=cut
sub printHeader
{
my $mode=shift;
my $html;
my $width;
my $padding;
my $float;

	# Not for SSI
	# Uncomment this line to turn on the style sheet for SSI recent uploads
	# if ($::ssi && ($::album ne $::recent_upload_album) && !$::popular_flag)
	# Otherwise this line is in effect
	if ($::ssi && !$::popular_flag)
	{
		return();
	}

	if ($::style_sheet)
	{
		$html="<link rel=\"stylesheet\" type=\"text/css\" href=\"$::style_sheet\" />\n";
	}
	$html.="<meta http-equiv=\"Content-Type\" content=\"text/html; charset=ISO-8859-1\" />";

	# If columns is not set yet, then give it a value, so we can show things properly
	if (!$::columns)
	{
		$::columns=5;
	}

#	# Set the "float" properly, per browser
#	if (detectBrowser())
#	{
#		# Mozilla
#		$float="left";
#	}
#	else
#	{
#		# IE
#		$float="none";
#	}

	# Add style info for objects in an album, because width is dynamic
#	$width=int(100/$::columns)-int($::column_spacing/3);
#	$padding=$::column_spacing."px";

#	$html.=<<HTML;
#\n<style type="text/css">
#.dynwidth	{ width: $width%; display: inline; padding: $padding; float: $float; }
#</style>
#HTML

	if (!$mode)
	{
		$html.="</head>\n<body bgcolor=\"#000000\" text=\"#FFFFFF\"";
		if (!$::style_sheet)
		{
			$html.=" link=\"#008000\" vlink=\"#800000\" alink=\"#0000FF\"";
		}
		$html.=">\n";
	}

	# Insert "missing style sheet" warning
	$html.="<div class=\"hidden\"><font color=\"FF0000\" size=\"5\">$::S{297}</font></div>";

	return($html);
}


##########################################################################

=head3 trackView()

 $current_views=trackView($currentphoto,$mode;$newcount);

 $current_views - Returns a string containing the number of views and the last viewed date.
 $currentphoto - Photo to update views for.
 $mode - 0 = Update views; 1 = Don't update views; 2 = Reset count to zero; 3 = set count to passed number
 $newcount - Set counter to this number if passed and mode 3.

Updates the number of views and the last viewed date for the current photo in $::viewfile.

=cut
sub trackView
{
my $currentphoto=shift;
my $mode=shift;
my $newcount=shift;
my $updated_views;
my $data;
my $current_count;
my $this_count;
my $last_viewed_date;
my $read_date;
my $virtualfile="";
my $current_viewfile="$::album_dir/";
my $current_view_date=setDate();

	if ($::goback)
	{
		$current_viewfile.="$::goback/";
	}
	$current_viewfile.="$::viewfile";

	if (!$currentphoto)
	{
		debug("No photo selected, not updating views.",2,__LINE__);
		return();
	}

	debug("Entering subroutine: trackView($currentphoto,$mode,$newcount);",4,__LINE__);

	debug("Updating views for $currentphoto in $current_viewfile",2,__LINE__);

	# Does it already exist?
	if (-e $current_viewfile)
	{
		# Open $::viewfile for reading
		if (!open(VIEWS,"$current_viewfile"))
		{
			$::warning.="$::S{20} <b>$current_viewfile</b><br />";
		}

		if (!-W "$current_viewfile")
		{
			$::warning.="$::S{23} <b>$current_viewfile</b><br />";
		}

		# have not updated views
		$updated_views=0;

		if ($::warning)
		{
			return;
		}

		while ($data=<VIEWS>)
		{
			# Check to see if this is the one we want
			if ($data=~/^$currentphoto\t.*/)
			{
				chomp($data);
				debug("Found match: $data",3,__LINE__);
				close(RATINGS);
				($current_count,$current_count,$read_date)=split("\t",$data);

				if ($read_date eq $data || !$read_date)
				{
					$read_date="$::S{93}";
				}
				debug("Data: [$data] --> Count:[$current_count] Date:[$read_date]",4,__LINE__);

				$this_count=$current_count;

				if ($mode eq 2)
				{
					$this_count=0;
				}
				elsif ($mode eq 3)
				{
					$this_count=$newcount;
				}
				elsif (!$mode)
				{
					$this_count++;
				}
				$last_viewed_date=$read_date;
				$virtualfile.="$currentphoto\t$this_count\t$current_view_date\n";

				# don't re-add the desc at the end
				$updated_views=1;
			}
			else
			{
				debug("Wrote: $data",4,__LINE__);
				$virtualfile.="$data";
			}
		}

		# If the photo didn't already hav an entry, add it now.
		if (!$updated_views)
		{
			debug("No entry found, adding one.",2,__LINE__);
                        if (!$mode)
                        {
			        $virtualfile.="$currentphoto\t1\t$current_view_date\n";
                        }
                        else
                        {
			        $virtualfile.="$currentphoto\t$newcount\t$current_view_date\n";
                        }
		}

		close(VIEWS);

		# Update views if that's what we're doing
		if (!$mode || $mode eq 2 || $mode eq 3)
		{
			# Re-open views file and write out new contents
			if (!open(VIEWS,">$current_viewfile"))
			{
				$::warning.="$::S{23} <b>$current_viewfile</b><br />";
				return();
			}
			print VIEWS $virtualfile;
			close(VIEWS);
		}
	}
	elsif (!$mode || $ mode eq 3)
	{
		$last_viewed_date="";
		debug("$current_viewfile does not exist, creating...",2,__LINE__);
		if (!open(VIEWS,">$current_viewfile"))
		{
			$::warning.="$::S{23} <b>$current_viewfile</b><br />";
			return();
		}
                if (!$mode)
                {
		        print VIEWS "$currentphoto\t1\t$current_view_date\n";
        		debug("printing $currentphoto\t1\t$current_view_date",2,__LINE__);
                }
                else
                {
		        print VIEWS "$currentphoto\t$newcount\t$current_view_date\n";
        		debug("printing $currentphoto\t$newcount\t$current_view_date",2,__LINE__);
                        $this_count=$newcount;
                }
		close(VIEWS);
	}

	if (!$this_count)
	{
		$this_count=1;
	}

	if (!$mode)
        {
                $data="$::S{94} ";
        }
        $data.=$this_count;
	if (!$mode)
        {
                $data.=" ";
	        if ($this_count gt 1)
	        {
		        $data.="$::S{202}";
	        }
	        else
	        {
		        $data.="$::S{200}";
	        }

	        if (!$last_viewed_date)
	        {
		        $data.=" $::S{96}";
	        }
	        else
	        {
	        	$data.=". $::S{97} $last_viewed_date.";
        	}
        }

	debug("Data is: $data",4,__LINE__);

	debug("Leaving subroutine: trackView($currentphoto,$mode);",4,__LINE__);

	return($data);
}


##########################################################################

=head3 findTemplate()

 $template_path=findTemplate($template_name);

 $template_path - The full path to the appropriate template (local or global).
 $template_path - The filename of the template.

Replaces all the tags in the data passed in, and returns the updated string.

=cut
sub findTemplate
{
my $template_name=shift;
my $localdir;

	debug("Entering subroutine: findTemplate($template_name);",4,__LINE__);


	if ($::album && $::album ne $::recent_upload_album)
	{
		$localdir=$::album;
	}
	else
	{
		$localdir="$::album_dir/$goback";
	}

	debug("Checking [$localdir/$template_name]",4,__LINE__);

	# Load localized object template if present
	if (-r "$localdir/$template_name")
	{
		$template_name="$localdir/$template_name";
	}
	elsif (-r "$::template_dir/$template_name")
	{
		$template_name="$::template_dir/$template_name";
	}

	debug("Template is now [$template_name]",4,__LINE__);

	debug("Leaving subroutine: findTemplate($template_name);",4,__LINE__);

	return($template_name);
}


##########################################################################

=head3 substituteData()

 $output_data=substituteData($input_data);

 $input_data - Data that is passed in. Each of the "####TAGS####" tags are replaced with actual data. See the file format section of this document for details on the tags.
 $output_data - After substitutions, the data that is returned.

Replaces all the tags in the data passed in, and returns the updated string.

=cut
sub substituteData
{
my $html_data=shift;
my $footer;
my $legend_html;
my $notify_html;
my $add_desc_footer;
my $slidestop_html;
my $slideshow_html;
my $views;
my $ratings;
my $format_html;
my $upload_form;
my $date;
my $fullscreen_html;
my $insert_file;
my $temp;
my $temp2;
my $thisphoto;
my $thisalbum;
my $debug_html;
my $insert_filename;
my $login_html;
my $login_form;
my $jhead_data;
my $vars;
my $recent_uploads_html;
my $purl;
my $purl2;
my $create_html;
my $delete_html;
my $move_html;
my $link_html;
my $bread_html;
my $sizes_html;
my $style_html;
my $search_html;
my $config_html;
my $random_html;
my $tempalbum;
my $popular_html;
my $admin_menu;
my $navprev;
my $navup;
my $navnext;
my $navjump;

	debug("Data before substitution: [$html_data]",4,__LINE__);

	# Add create album form - Note that this only replaces the OBJECT tag if we're on admincreate.
	if ($form->param('admincreate') && !$form->param('albumname'))
	{
		require $::admin_module;
		$create_html=createAlbumForm($form->param('album'));
		$html_data=~s/####OBJECT####/\n<!-- OBJECT tag start -->\n$create_html\n<!-- OBJECT tag end -->\n/g;
	}

	# Add delete form - Note that this only replaces the OBJECT tag if we're on deleteobject.
	if ($form->param('deleteobject'))
	{
		require $::admin_module;
		$delete_html=deleteObject($form->param('deleteobject'),1);
		$html_data=~s/####OBJECT####/\n<!-- OBJECT tag start -->\n$delete_html\n<!-- OBJECT tag end -->\n/g;
	}

	# Add move form - Note that this only replaces the OBJECT tag if we're on moveobject.
	if ($form->param('moveobject'))
	{
		require $::admin_module;
		$move_html=moveObject($form->param('moveobject'),1);
		$::shortdesc=$::S{217};
		$::longdesc="";
		$html_data=~s/####OBJECT####/\n<!-- OBJECT tag start -->\n$move_html\n<!-- OBJECT tag end -->\n/g;
	}

	# Add link form - Note that this only replaces the OBJECT tag if we're on linkobject.
	if ($::linkobject)
	{
		require $::admin_module;
		$link_html=linkObject($::linkobject,1);
		$::shortdesc=$::S{309};
		$::longdesc="";
		$html_data=~s/####OBJECT####/\n<!-- OBJECT tag start -->\n$link_html\n<!-- OBJECT tag end -->\n/g;
	}

	# Add search form - Note that this only replaces the OBJECT tag if we're on search.
	if ($form->param('searchstart'))
	{
		require $::recent_module;
		$search_html=searchForm();
		$html_data=~s/####OBJECT####/\n<!-- OBJECT tag start -->\n$search_html\n<!-- OBJECT tag end -->\n/g;
	}

	# Add search results - Note that this only replaces the OBJECT tag if we're processing a search.
	if ($::searchstring)
	{
		debug("Calling search($::searchstring)",3,__LINE__);
		require $::recent_module;
		$search_html=search($::searchstring);
		$html_data=~s/####OBJECT####/\n<!-- OBJECT tag start -->\n$search_html\n<!-- OBJECT tag end -->\n/g;
	}

	# Recent Uploads Page
	if ($::recent_uploads && ($form->param('album') eq $::recent_upload_album))
	{
		require $::recent_module;
		$recent_uploads_html=recentUploads();
		$::shortdesc="$::recent_uploads $::S{195}";
		$::longdesc="";
		$html_data=~s/####OBJECT####/\n<!-- OBJECT tag start -->\n$recent_uploads_html\n<!-- OBJECT tag end -->\n/g;
	}

	# Add Most Popular results - Note that this only replaces the OBJECT tag if we're processing a search.
	if ($::popular_flag)
	{
		debug("Calling popular()",3,__LINE__);
		require $::recent_module;
		$popular_html=popular();
		$html_data=~s/####OBJECT####/\n<!-- OBJECT tag start -->\n$popular_html\n<!-- OBJECT tag end -->\n/g;
	}
	# Add rating form - Note that this only replaces the OBJECT tag if we're entering a rating.
	if ($::function eq $::rating_form)
	{
		$ratings=<<HTML;
<br /><br />
HTML
		$::shortphoto=$::object;
		$thisalbum=$form->param('rating_file_loc');
		$thisphoto=$form->param('object');

		if ($::ratingfile)
		{
			$ratings.=getRatings(1,$thisalbum);
		}

		$ratings.=<<HTML;
<form method="post" action="$::albumprog">
<br /><br />
$::S{197} <SELECT name=rating>
<option value="5">$::S{109}</option>
<option value="4">$::S{110}</option>
<option  value="3" selected>$::S{111}</option>
<option value="2">$::S{112}</option>
<option value="1">$::S{113}</option>
</select>
<br /><br />
$::S{114}
HTML

		$ratings.="<input type=\"text\" name=\"name\" ";
		if ($::authenticated)
		{
			$ratings.=" value=\"$::displayname\"";
		}
		$ratings.="/>";
		$ratings.=<<HTML;
<br /><br />
$::S{115}
<br />
<textarea rows="$::enterdesc_rows" name="comments" cols="$::enterdesc_cols">
</textarea>
<br /><br />
HTML
		$::function=$::update_rating;
		$ratings.=passVars(1);

		$ratings.=<<HTML;
<input type="hidden" name="rating_file_loc" value="$thisalbum" />
<input type="hidden" name="object" value="$thisphoto" />
<input type="submit" value=" $::S{116} " class="button" />
</form>
<br /><img src="$::album_web/$thisalbum/$thisphoto" border="0" title="" /><br />
HTML
		$html_data=~s/####OBJECT####/\n<!-- OBJECT tag start -->\n$ratings\n<!-- OBJECT tag end -->\n/g;
	}

	# Replace object tag if we're just doing regular stuff
	$html_data=~s/####OBJECT####/\n<!-- OBJECT tag start -->\n$::actual_object\n<!-- OBJECT tag end -->\n/g;

	# Insert files (this is done first so that all inserted tags are also replaced
	while ($html_data=~/####FILE=([^#]*)####/)
	{
		$insert_filename=$1;

		$insert_filename=findTemplate($insert_filename);

		debug("Inserting file: [$insert_filename]",2,__LINE__);
		if (-r $insert_filename)
		{
			open(FILE,$insert_filename);
			$insert_file=join("",<FILE>);
			close(FILE)
		}
		else
		{
			$insert_file="<!-- File ($insert_filename) not found or not readable! -->\n";
			debug("Not inserted! (Not readable)",2,__LINE__);
		}
		$html_data=~s/####FILE=([^#]*)####/\n<!-- FILE ($insert_filename) tag start -->\n$insert_file\n<!-- FILE ($insert_filename) tag end -->\n/;
	}

	# Set internal variables
	while ($html_data=~/####CODE=(.*?)####/s)
	{
		debug("Evaluating CODE expression: [$1]",2,__LINE__);

		$config_html=eval("$1");

		# Don't display return codes of 0/1, but display any other returned data
		if (!$config_html || $config_html eq 1)
		{
			$config_html="";
		}

		$html_data=~s/####CODE=(.*?)####/$config_html/s;
	}

	# Substitute Strings from album_strings.txt
	$html_data=~s/####STRING=(\d*)####/$::S{$1}/g;

	# Substitute internal variables
	while ($html_data=~/####CONFIG=(.*?)####/)
	{
		debug("Evaluating CONFIG expression: [$1]",2,__LINE__);
		$config_html=eval("\$$1");
		$html_data=~s/####CONFIG=(.*?)####/$config_html/;
	}

	# Replace object title tag with object title
	$html_data=~s/####TITLE####/\n<!-- TITLE tag start -->\n$::shortdesc\n<!-- TITLE tag end -->\n/g;
	# Replace metadata title tag with object title. Do not put the start and end comments here it hoses up meta tags.
	$html_data=~s/####METATITLE####/$::shortdesc/g;

	# Strip out HTML tags from the object title if it's used as the page title.
	$temp=$::shortdesc;
	$temp=~s/<([^>]|\n)*>//g;
	$html_data=~s/<title>.*<\/title>/<title>$temp<\/title>/isg;

	# Perform substitutions of tags for actual data
	$html_data=~s/####DESCRIPTION####/\n<!-- DESCRIPTION tag start -->\n$::longdesc\n<!-- DESCRIPTION tag end -->\n/g;
	# Replace metadata description tag with object desctiption and remove any other HTML. Do not put the start and end comments here it hoses up meta tags.
	$temp=$::longdesc;
	$temp=~s/<([^>]|\n)*>//g;
	$html_data=~s/####METADESCRIPTION####/$temp/g;

	$style_html=printHeader(1);
	$html_data=~s/####STYLESHEET####/\n<!-- STYLESHEET tag start -->\n$style_html\n<!-- STYLESHEET tag end -->\n/g;
	$html_data=~s/####SIZE####/\n<!-- SIZE tag start -->\n$::upload_size_limit\n<!-- SIZE tag end -->\n/g;
	$html_data=~s/####MOVIESIZE####/\n<!-- MOVIESIZE tag start -->\n$::movie_upload_size_limit\n<!-- MOVIESIZE tag end -->\n/g;
	$html_data=~s/####PAGES####/\n<!-- PAGES tag start -->\n$::pages_html\n<!-- PAGES tag end -->\n/g;

	# Build navigation footer buttons/links
	$navprev=buildNavFooter(1);
	if ($::keep_this)
	{
		$navup=buildNavFooter(2);
	}
	$navnext=buildNavFooter(3);
	$navjump=buildNavFooter(4);
	$::nav_footer=buildNavFooter();
	$html_data=~s/####NAVPREV####/\n<!-- NAVPREV tag start -->\n$navprev\n<!-- NAVPREV tag end -->\n/g;
	$html_data=~s/####NAVUP####/\n<!-- NAVUP tag start -->\n$navup\n<!-- NAVUP tag end -->\n/g;
	$html_data=~s/####NAVNEXT####/\n<!-- NAVNEXT tag start -->\n$navnext\n<!-- NAVNEXT tag end -->\n/g;
	$html_data=~s/####NAVJUMP####/\n<!-- NAVJUMP tag start -->\n$navjump\n<!-- NAVJUMP tag end -->\n/g;
	$html_data=~s/####NAV####/\n<!-- NAV tag start -->\n$::nav_footer\n<!-- NAV tag end -->\n/g;

	# Date
	$date=setDate("",1);
	$html_data=~s/####DATE####/\n<!-- DATE tag start -->\n$date\n<!-- DATE tag end -->\n/g;

	# Direct URL to photo (not through album.pl), plain
	if ($::photo)
	{
		$purl="$::album_web/$::photo";
		$purl=~s/ /%20/g;
	}
	$html_data=~s/####OBJECTURL####/$purl/g; # Don't put tags around OBJECTURL, as it screws up the HTML if it's used in a link

	# Direct URL to photo (not through album.pl), HTMLized
	if ($::photo)
	{
		$purl="$::S{210} <a target=\"_blank\" href=\"$purl\">$purl</a> $::S{211}";
	}
	$html_data=~s/####URL####/\n<!-- URL tag start -->\n$purl\n<!-- URL tag end -->\n/g;

	# Album/Photo Path
	if ($::photo)
	{
		$purl2=webifyLinks($::photo);
	}
	else
	{
		if ($::shortalbum ne $::rootalbumname)
		{
			if ($::goback)
			{
				$purl2.="$::goback/";
			}
			$purl2.="$::shortalbum";
		}
	}
	$html_data=~s/####PATH####/$purl2/g; # Don't put tags around PATH, as it screws up the HTML if it's used in a link

	# URL to photo through album.pl, not HTMLized
	if ($::photo)
	{
		$purl2="$::albumprog?photo=$purl2";
	}
	else
	{
		if ($::shortalbum ne $::rootalbumname)
		{
			$purl2="?album=$purl2";
		}
		$purl2="$::albumprog$purl2";
	}
	$html_data=~s/####URLONLY####/$purl2/g; # Don't put tags around URLONLY, as it screws up the HTML if it's used in a link

	# Direct call to album.pl root album (with vars), not the curent object.
	$vars=passVars(2);
	$html_data=~s/####ALBUMPROG####/$::albumprog?full=1$vars/g; # Don't put tags around albumprog, as it screws up the HTML if it's used in a link

	# Code to set default upload dir to current album provided by Systematic
	if (($::shortalbum ne $::rootalbumname) && $::shortalbum)
	{
		my $temptemp="function=$::upload".$::webdelim."album=";
		if ($::goback)
		{
			$temptemp.="$::goback/";
		}
		$temptemp.="$::shortalbum\"";
		$html_data=~s/function=$::upload"/$temptemp/g;
	}

	# Is this the root album? If so, build legend and notify chunks.
	if (!$::middle)
	{
		if ($::legend)
		{
			$legend_html="$::S{101}<br />\n";
			$legend_html.="<table align=\"center\"><tr><td align=\"center\"><img src=\"$::album_icon\" align=\"center\" title=\"$::S{87} $::S{102}\" /><br />$::S{47}";
			$legend_html.="</td><td align=\"center\">";
			$legend_html.="<img src=\"$::photo_icon\" align=\"center\" title=\"$::S{46} $::S{102}\" /><br />$::S{46}";
			$legend_html.="</td><td align=\"center\">";
			$legend_html.="<img src=\"$::movie_icon\" align=\"center\" title=\"$::S{104} $::S{102}\" /><br />$::S{104}</td></tr></table>";
		}
		if ($::notify)
		{
			$notify_html="$::S{103} $::shortdesc$::S{105}<br />\n";
			$notify_html.="<form method=\"post\" action=\"$::albumprog\">";
			$notify_html.="<input type=\"text\" name=\"email_notify\" />";
			$notify_html.=" <input type=\"submit\" value=\"$::S{106}\" class=\"button\" />";
			$notify_html.="</form>\n";
		}
	}
	if ($form->param('email_notify') && $::notify)
	{
		open(NOTIFY,">>$::notify_file") || error(__LINE__,"not_writable","$::notify_file");
		print NOTIFY $form->param('email_notify');
		print NOTIFY "\n";
		close(NOTIFY);
		$notify_html.="<center>$::S{107} (".$form->param('email_notify').") $::S{108}<br />\n";
		$notify_html.="</center><hr />\n";

		# Don't add twice
		$::notify=0;
	}

	$html_data=~s/####LEGEND####/\n<!-- LEGEND tag start -->\n$legend_html\n<!-- LEGEND tag end -->\n/g;
	$html_data=~s/####NOTIFY####/\n<!-- NOTIFY tag start -->\n$notify_html\n<!-- NOTIFY tag end -->\n/g;

	# Fullscreen slide show
	if ($::photo)
	{
		$temp="$::albumprog?slideshow=";
		if ($::slide_timer)
		{
			$temp.=$::slide_timer;
		}
		else
		{
			$temp.="5";
		}
		$temp.=$::webdelim."fullscreen=1".$::webdelim."photo=".webifyLinks($::photo).$::webdelim;

		# Clear constrained values
		my $temp_height=$::photo_height;
		my $temp_width=$::photo_width;
		$::photo_height=$::photo_width=0;

		$temp.=passVars(0);
		$temp2=$temp."photo_width=auto".$::webdelim."photo_height=auto";
		($height,$width)=getPhotoDimensions("$::album_dir/$::photo");
		if ($width > $height)
		{
			$temp.=$::webdelim."photo_width=";
			$fullscreen_html.="<a href=\"$temp2\" target=\"_blank\" class=\"button\" onClick=\"return popup(\'$temp\',\'screenshow\')\">";
		}
		else
		{
		      $temp.=$::webdelim."photo_height=";
		      $fullscreen_html.="<a href=\"$temp2\" target=\"_blank\" class=\"button\" onClick=\"return popup(\'$temp\',\'screenshow\',true)\">";
		}
		if ($::textmenu)
		{
			$fullscreen_html.=" $::S{98} $::S{51}";
		}
		else
		{
			$fullscreen_html.="<img class=\"button\" src=\"$::fullscreen_button\" title=\"$::S{51}\" />";
		}
		$fullscreen_html.="</a>";

		# Restore original sizes
		$::photo_height=$temp_height;
		$::photo_width=$temp_width;
	}
	$html_data=~s/####FULLSCREEN####/\n<!-- FULLSCREEN tag start -->\n$fullscreen_html\n<!-- FULLSCREEN tag end -->\n/g;

	# Insert "sizes" text for photos
	if ($::photo && !$::create_html_flag)
	{
		$temp=$::photo_width;
		$temp2=$::photo_height;
		$::photo_width=0;
		$::photo_height=0;

		# Display [ Small ] resize link
		if ($::small_width || $::small_height)
		{
			$sizes_html.="<a href=\"$::albumprog?photo=".webifyLinks($::photo);
			$sizes_html.=passVars(0);
			if ($::small_width)
			{
				$sizes_html.=$::webdelim."photo_width=$::small_width";
			}
			if ($::small_height)
			{
				$sizes_html.=$::webdelim."photo_height=$::small_height";
			}
			$sizes_html.="\" class=\"optionslink\">";
			if ($::textmenu)
			{
				$sizes_html.=$::S{54};
			}
			else
			{
				$sizes_html.="<img class=\"button\" src=\"$::small_button\" title=\"$::S{54}\" />";
			}
			$sizes_html.="</a> ";
		}

		# Display [ Medium ] resize link
		if ($::medium_width || $::medium_height)
		{
			# Insert divider for text menus
			if ($::textmenu && ($::small_width || $::small_height))
			{
				$sizes_html.=" $::S{98} ";
			}

			$sizes_html.="<a href=\"$::albumprog?photo=".webifyLinks($::photo);
			$sizes_html.=passVars(0);
			if ($::small_width)
			{
				$sizes_html.=$::webdelim."photo_width=$::medium_width";
			}
			if ($::small_height)
			{
				$sizes_html.=$::webdelim."photo_height=$::medium_height";
			}
			$sizes_html.="\" class=\"optionslink\">";
			if ($::textmenu)
			{
				$sizes_html.=$::S{139};
			}
			else
			{
				$sizes_html.="<img class=\"button\" src=\"$::medium_button\" title=\"$::S{139}\" />";
			}
			$sizes_html.="</a> ";
		}

		# Display [ Large ] resize link
		if ($::large_width || $::large_height)
		{
			# Insert divider for text menus
			if ($::textmenu && ($::medium_width || $::medium_height))
			{
				$sizes_html.=" $::S{98} ";
			}

			$sizes_html.="<a href=\"$::albumprog?photo=".webifyLinks($::photo);
			$sizes_html.=passVars(0);
			if ($::small_width)
			{
				$sizes_html.=$::webdelim."photo_width=$::large_width";
			}
			if ($::small_height)
			{
				$sizes_html.=$::webdelim."photo_height=$::large_height";
			}
			$sizes_html.="\" class=\"optionslink\">";
			if ($::textmenu)
			{
				$sizes_html.=$::S{177};
			}
			else
			{
				$sizes_html.="<img class=\"button\" src=\"$::large_button\" title=\"$::S{177}\" />";
			}
			$sizes_html.="</a> ";
		}

		# If we've displayed any of these, display the [ Full Size ] link.
		if ($::small_width || $::small_height || $::medium_width || $::medium_height || $::large_width || $::large_height)
		{
			# Display [ Auto Size ] resize link

			# Insert divider for text menus
			if ($::textmenu)
			{
				$sizes_html.=" $::S{98} ";
			}
			$sizes_html.="<a href=\"$::albumprog?photo=".webifyLinks($::photo);
			$sizes_html.=passVars(0);
			if ($::small_width)
			{
				$sizes_html.=$::webdelim."photo_width=auto";
			}
			if ($::small_height)
			{
				$sizes_html.=$::webdelim."photo_height=auto";
			}
			$sizes_html.="\" class=\"optionslink\">";
			if ($::imagemagick)
			{
				if ($::textmenu)
				{
					$sizes_html.=$::S{339};
				}
				else
				{
					$sizes_html.="<img class=\"button\" src=\"$::auto_button\" title=\"$::S{339}\" />";
				}
			}

			$sizes_html.="</a> ";

			# Insert divider for text menus
			if ($::textmenu)
			{
				$sizes_html.=" $::S{98} ";
			}

			$sizes_html.="<a href=\"$::albumprog?photo=".webifyLinks($::photo);

			# Add manual resize codes for "full size"
			$sizes_html.=$::webdelim."photo_height=-1";
			$sizes_html.=$::webdelim."photo_width=-1";

			$sizes_html.=passVars(0);
			$sizes_html.="\" class=\"optionslink\">";
			if ($::textmenu)
			{
				$sizes_html.=$::S{179};
			}
			else
			{
				$sizes_html.="<img class=\"button\" src=\"$::fullsize_button\" title=\"$::S{179}\" />";
			}
			$sizes_html.="</a> ";
		}

		$::photo_width=$temp;
		$::photo_height=$temp2;
	}
	$html_data=~s/####SIZES####/\n<!-- SIZES tag start -->\n$sizes_html\n<!-- SIZES tag end -->\n/g;

	# Recent Uploads Link
	if ($::recent_uploads && !$::create_html_flag)
	{
		$recent_uploads_html="<a href=\"$::albumprog?album=$::recent_upload_album$vars\" class=\"optionslink\">";
		if ($::textmenu)
		{
			$recent_uploads_html.=$::S{234};
		}
		else
		{
			$recent_uploads_html.="<img class=\"button\" src=\"$::recent_button\" title=\"$::S{234}\" />";
		}
		$recent_uploads_html.="</a>";
	}
	$html_data=~s/####RECENTUPLOADS####/\n<!-- RECENTUPLOADS tag start -->\n$recent_uploads_html\n<!-- RECENTUPLOADS tag end -->\n/g;

	# Are we tracking the number of photo views?
	if ($::viewfile && !$::create_html_flag && $::keep_this)
	{
		$views=trackView($::shortphoto);
	}
	$html_data=~s/####VIEWS####/\n<!-- VIEWS tag start -->\n$views\n<!-- VIEWS tag end -->\n/g;

	# Height an dwidth (no tags)
	$html_data=~s/####HEIGHT####/$height/g;
	$html_data=~s/####WIDTH####/$width/g;

	# Get thumbnail URL
	$thumburl=showThumb($::photo,1);
	$html_data=~s/####THUMBURL####/$thumburl/g;

	# Insert "breadcrumbs"
	if ($::keep_this)
	{
		$bread_html=showBreadCrumbs();
	}
	$html_data=~s/####BREAD####/\n<!-- BREAD tag start -->\n$bread_html\n<!-- BREAD tag end -->\n/g;

	# Substitute upload formats
	$format_html=join(", ",@::imgexts);
	if ($::movie_upload)
	{
		if ($::imgexts[0])
		{
			$format_html.=", "
		}
		$format_html.=join(", ",@::movieexts);
	}
	$format_html=~s/(.*), /$1 $::S{245} /;

	$html_data=~s/####FORMAT####/\n<!-- FORMAT tag start -->\n$format_html\n<!-- FORMAT tag end -->\n/g;

	# Random Thumbnail
	if ($html_data=~/####RANDTHUMB####/)
	{
		# Save off album
		$tempalbum=$::album;

		# Get random image
		require $::recent_module;
		$random_html=randomizer();

		# Fix album var for this operation
		$::album=$::manual_override;
		$::album=~s/(.*)\/.*/$1/;

		# Generate random HTML
		$random_html=showObject($random_html);
		$html_data=~s/####RANDTHUMB####/\n<!-- RANDTHUMB tag start -->\n$random_html\n<!-- RANDTHUMB tag end -->\n/g;

		# Reset album to normal value
		$::album=$tempalbum;
	}

	# Login status
	$login_html=loginStatus();
	$html_data=~s/####LOGIN####/\n<!-- LOGIN tag start -->\n$login_html\n<!-- LOGIN tag end -->\n/g;

	# jhead information
	if ($::jhead && $::photo)
	{
		$jhead_data=$::jhead_html;
	}
	$html_data=~s/####JHEAD####/\n<!-- JHEAD tag start -->\n$jhead_data\n<!-- JHEAD tag end -->\n/g;

	# Put in fullscreen popup java code (must appear in <head> section)
	if ($::photo && ($::fullscreen ne "1" && $::fullscreen ne $::S{263}))
	{
		$slideshow_html=<<HTML;
<script type="text/javascript" language="JavaScript">
<!--
function popup(mylink,windowname,vertical)
{
if (! window.focus)return true;
picWidth=screen.width-40;
picHeight=screen.height-100;
try {
  if (NS_NewOpen) window.name=windowname;
}
catch(Error){}
if (vertical)
{
   window.open(mylink+picHeight, windowname, ',type=fullWindow,fullscreen,scrollbars=auto');
}
else
{
   window.open(mylink+picWidth, windowname, ',type=fullWindow,fullscreen,scrollbars=auto');
}
return false;
}
//-->
</script>
HTML
	}
	# Put slide show directive in (must appear in <head> section)
	if ($::slide_timer && $::photo)
	{
	my $next_web_link=$::next_photo_link;

		# If there's a next photo, refresh to it
		if ($::next_obj)
		{

			$next_web_link=~s/;/&/g;
			if (($form->param('fullscreen') ne "1") && $::fullscreen ne $::S{263})
			{
				$slideshow_html.="<meta http-equiv=\"Refresh\" content=\"$::slide_timer; url=$next_web_link\">";
			}
			else
			{
				$next_web_link=~s/photo_width=//g;
				$next_web_link=~s/photo_height=//g;
				$next_web_link.="\&";
				($height,$width)=getPhotoDimensions("$::album_dir/$::goback/$::next_obj");
				if ($width > $height)
				{
					$next_web_link.="photo_width=";
					$slideshow_html.=<<HTML;

<script type="text/javascript" language="JavaScript">
<!--
picWidth=screen.width-40;
reftag="<meta http-equiv=\'Refresh\' content=\'$::slide_timer; url=$next_web_link";
document.write(reftag+picWidth+"\'>");
//-->
</script>
HTML
				}
				else
				{
					$next_web_link.="photo_height=";
					$slideshow_html.=<<HTML;

<script type="text/javascript" language="JavaScript">
<!--
picHeight=screen.height-100;
reftag="<meta http-equiv=\'Refresh\' content=\'$::slide_timer; url=$next_web_link";
document.write(reftag+picHeight+"\'>");
//-->
</script>
HTML
				}
			}
                }

		# Full screen mode!
		if ((($form->param('fullscreen') eq "1") || $::fullscreen eq $::S{263}) && $::photo)
		{
			$html_data="<head>\n####STYLESHEET####\n$slideshow_html";
			$html_data.=<<HTML;
<script type="text/javascript" language="JavaScript">
<!--
window.focus();
function targetopener(mylink, closeme, closeonly) {
	if (! (window.focus && window.opener))return true;
	try {
	  var ie4=document.all&&navigator.userAgent.indexOf("Opera")==-1
	  if (NS_NewOpen && !ie4)return true;
	}
	catch(Error){}
	window.opener.focus();
	if (! closeonly)window.opener.location.href=mylink.href;
	if (closeme)window.close();
	return false;
}
//-->
</SCRIPT>
HTML
			$style_html=printHeader(1);
			$html_data=~s/####STYLESHEET####/\n<!-- STYLESHEET tag start -->\n$style_html\n<!-- STYLESHEET tag end -->\n/g;
			$html_data.="</head>\n<body>\n<center>\n$::actual_object\n<br /><br />\n####STOPSLIDESHOW####\n<center>\n<a href=\"$::albumprog\?photo=$::photo\" onClick=\"return targetopener(this,true)\" class=\"button\">$::S{277}</a></center>\n</body>\n</html>";
		}
	}
	$html_data=~s/####SLIDESHOW####/\n<!-- SLIDESHOW tag start -->\n$slideshow_html\n<!-- SLIDESHOW tag end -->\n/g;

	# Slideshow Controls
	if ($::slide_timer && $::next_obj && $::photo)
	{
		$slidestop_html="<form method=\"post\" action=\"$::albumprog\">\n";
		# Save off slideshow timer
		$temp=$::slide_timer;
		$::slide_timer=-1;
		$slidestop_html.=passVars(1);
		$::slide_timer=$temp;
		$slidestop_html.="<input type=\"hidden\" name=\"photo\" value=\"$::photo\" />\n";
		# $slidestop_html.="<input type=\"submit\" value=\"Pause Slideshow\" class=\"button\" />\n";

		# Show fullscreen button
		if (!$::fullscreen)
		{
			$slidestop_html.="<input type=\"submit\" value=\"$::S{99}\" class=\"button\" />\n";
        		$temp2="$::albumprog?slideshow=";
			$temp2.=$::slide_timer;
        		$temp2.=$::webdelim."fullscreen=1".$::webdelim."photo=".webifyLinks($::photo);

		        # Clear constrained values
		        $::photo_height=$::photo_width=0;

		        $temp2.=passVars(0);
		        $temp3=$temp2."photo_width=auto".$::webdelim."photo_height=auto";
			  ($height,$width)=getPhotoDimensions("$::album_dir/$::photo");
			  if ($width > $height)
			  {
			        $temp2.=$::webdelim."photo_width=";
			        $slidestop_html.="<a href=\"$temp3\" target=\"_blank\" class=\"button\" onClick=\"return popup(\'$temp2\',\'screenshow\')\">";
			  }
			  else
			  {
			        $temp2.=$::webdelim."photo_height=";
			        $slidestop_html.="<a href=\"$temp3\" target=\"_blank\" class=\"button\" onClick=\"return popup(\'$temp2\',\'screenshow\',true)\">";
			  }
		        if ($::textmenu)
		        {
			        $slidestop_html.=" $::S{98} $::S{263}";
		        }
		                else
		        {
			        $slidestop_html.="<img class=\"button\" src=\"$::fullscreen_button\" title=\"$::S{263}\" />";
		        }
		        $slidestop_html.="</a>";
		}
	        $slidestop_html.="</form>\n";
	}

	$html_data=~s/####STOPSLIDESHOW####/\n<!-- STOPSLIDESHOW tag start -->\n$slidestop_html\n<!-- STOPSLIDESHOW tag end -->\n/g;

	if ($::debug)
	{
		$debug_html="<form method=\"post\" action=\"$::albumprog\">\n";
		# Save off slideshow timer
		$temp=$::debug;
		$::debug=0;
		$debug_html.=passVars(1);
		$::debug=$temp;
		if ($::photo)
		{
			$debug_html.="<input type=\"hidden\" name=\"photo\" value=\"$::photo\" />\n";
		}
		if ($::album && $::shortalbum ne $::rootalbumname)
		{
			$debug_html.="<input type=\"hidden\" name=\"album\" value=\"$::middle\" />\n";
		}
		$debug_html.="<input type=\"submit\" value=\"$::S{100}\" class=\"button\" />\n";
		$debug_html.="</form>\n";
	}

	$html_data=~s/####STOPDEBUG####/\n<!-- STOPDEBUG tag start -->\n$debug_html\n<!-- STOPDEBUG tag end -->\n/g;

	# Show upload form
	if ($::function eq $::upload)
	{
		require $::upload_module;
		$upload_form=showUploadForm();
	}
	$html_data=~s/####UPLOAD####/\n<!-- UPLOAD tag start -->\n$upload_form\n<!-- UPLOAD tag end -->\n/g;

	# Show Administration menu
	if (isAdmin())
	{
		require $::admin_module;
		$admin_menu=showAdminMenu(0);
	}
	$html_data=~s/####ADMIN####/\n<!-- ADMIN tag start -->\n$admin_menu\n<!-- ADMIN tag end -->\n/g;

	# Show Login Form
	if ($::function eq $::login_code)
	{
		require $::login_module;
		$login_form=showLogin();
	}
	$html_data=~s/####LOGINFORM####/\n<!-- LOGINFORM tag start -->\n$login_form\n<!-- LOGINFORM tag end -->\n/g;

	# Check to see if we are adding a description
	if ($::function eq $::enter_desc || $form->param('editobject'))
	{
		$add_desc_footer=buildDescFooter(0);
	}
	$html_data=~s/####ENTERDESC####/\n<!-- ENTERDESC tag start -->\n$add_desc_footer\n<!-- ENTERDESC tag end -->\n/g;

	# Are we rating photos?
	if ($::ratingfile && !$::create_html_flag && !$::album && $::keep_this)
	{
		$ratings=getRatings();
	}
	$html_data=~s/####RATINGS####/\n<!-- RATINGS tag start -->\n$ratings\n<!-- RATINGS tag end -->\n/g;

	# Add footer last, in case there are any warnings
	$footer=showFooter(0);
	$html_data=~s/####FOOTER####/\n<!-- FOOTER tag start -->\n$footer\n<!-- FOOTER tag end -->\n/g;

	debug("Data after substitution: [$html_data]",4,__LINE__);

	# Return data
	return($html_data);
}


##########################################################################

=head3 buildObject()

 $output_data=buildObject();

 $output_data - The HTML for displaying the object is build and returned.

Builds the "object" to be displayed. For a photo, it builds the HTML to display the photo, and for an album, it builts the list of objects in that album (photos and sub-albums).

=cut
sub buildObject
{
my $actual_object;
my $relpath;
my $temppage;
my $temppage2;
my $pages_html2;
my $jhead_txt;
my @sorted;
my $movietemp;
my @temp_file_list;
my $item;
my $first;
my $platform;
my $convertflag;
my $systemcall;
my $time_taken;
my $width;
my $height;
my $buff;
my $type;
my $auto_size=0;
my $g_HTML_string="";

	debug("Entering subroutine: buildObject();",4,__LINE__);

	if ($::function eq "about")
	{
		$actual_object=<<HTML;
</center>
<br />
Version $::ver ($::release Release) written by <a href="mailto:Mike\@Bobbitt.ca">Mike Bobbitt</a>.
<br />With modifications by <a href="mailto:fristersoft\@comcast.net">J.J. Frister</a>
<br />&nbsp;<br />
See <a href="http://dev.bobbitt.ca/album" target="_blank">http://dev.bobbitt.ca/album</a> for updates and information.
<br />&nbsp;<br />
Please post any problems or questions about this program in the <a href="http://dev.bobbitt.ca/forums" target="_blank">the album.pl support forums</a>.
<br />&nbsp;<br />
<center><a href="http://dev.bobbitt.ca/album" target="_blank"><img border="0" src="http://dev.bobbitt.ca/img/album_logo.png" title="" /></a></center>
&#169; 1999-2004 Cipher Logic Canada Inc. All Rights Reserved.
<br />& &#169 2003-2004 fristersoft. All Rights Reserved.<br />&nbsp;<br />
HTML
		return($actual_object);
	}


	if (($::photo_width eq "auto" || $::photo_height eq "auto") && (!$::imagemagick))
	{
		$::photo_width=$::small_width;
		$::photo_height=$::small_height;
	}
	if (($::photo_width eq "auto" || $::photo_height eq "auto") && isAPhotoOrJp2("$::album_dir/$::photo"))
	{
		$auto_size=1;
		debug("Auto size = 1",4,__LINE__);

		# jscript for window sizing
		$actual_object.=<<HTML;
<script type="text/javascript" language="JavaScript">
resize();

<!--
function resize()
   {
     var g_HTMLstring = "";
     var w_newWidth=0;
     var w_newPWidth=0;
     var w_maxWidth=1600;
     var w_newHeight=0;
     var w_newPHeight=0;
     var w_maxHeight=1200;
     var w_currRatio=0;
     var w_reqRatio=0;
     if (self.innerHeight) // all except Explorer
     {
      var netscapeScrollWidth=15;
      w_newWidth=self.innerWidth-netscapeScrollWidth;
      w_newHeight=self.innerHeight-netscapeScrollWidth;
     }
     else if (document.documentElement && document.documentElement.clientHeight) // Explorer 6 Strict Mode
     {
      var explorerScrollWidth=15;
      w_newWidth=document.documentElement.clientWidth;
      w_newHeight=document.documentElement.clientWidth;
     }
     else if (document.body) // other Explorers
     {
      w_newWidth=document.body.clientWidth;
      w_newHeight=document.body.clientHeight;
     }
     if (w_newWidth > w_maxWidth)
       w_newWidth=w_maxWidth;
     if (w_newHeight > w_maxHeight)
       w_newHeight=w_maxHeight;
     w_newPWidth = ( w_newWidth - 45 );
     w_newPHeight = ( w_newHeight - 145 );
     w_currRatio = ( w_newPHeight / w_newPWidth );
HTML

		($height,$width)=getPhotoDimensions("$::album_dir/$::photo");
                $actual_object.="var real_height=$height; var real_width=$width;";
		$actual_object.=<<HTML;

     if (real_height > real_width)
        w_reqRatio = real_width/real_height;
     else
        w_reqRatio = real_height/real_width;
     if (w_currRatio < w_reqRatio)
        {w_newPWidth = w_newPHeight / w_reqRatio;}
     else
        {w_newPHeight = w_newPWidth * w_reqRatio;}
     resize.w_newPWidth=w_newPWidth;
     resize.w_newPHeight=w_newPHeight;
     var c1 = "'";

HTML
	}

	if ($::photo && !isAJp2($::photo))
	{
		# If the next file is also a photo, make a link to it
		if (isAPhotoOrJp2($::next_obj) || isAMovie($::next_obj))
		{
			$relpath=$::next_obj;

#($height,$width)=getPhotoDimensions("$::album_dir/$::goback/$::photo");

			$g_HTML_string.="<a href=\"";
			if ($::create_html_flag)
			{
				# Check to see if it's a photo or an album
				if (isAPhotoOrJp2($::next_obj))
				{
					$g_HTML_string.=webifyLinks($relpath).".html";
				}
				elsif (isAMovie($::next_obj))
				{
					$g_HTML_string.=webifyLinks($::album_dir."/".$relpath);
				}
				else
				{
					$g_HTML_string.=webifyLinks($relpath)."$relpath";
				}
			}
			else
			{
				$relpath="$::realgoback/$relpath";

				if (isAPhotoOrJp2($::next_obj))
				{
					$g_HTML_string.="$::albumprog?photo=".webifyLinks($relpath);
					$g_HTML_string.=passVars(0);
				}
				elsif (isAMovie($::next_obj))
				{
					$g_HTML_string.=webifyLinks($::album_web."/".$relpath);
				}
			}
			$g_HTML_string.="\" class=\"photolink\">";
		}

		if (!isAMovie($::photo))
		{
			# Update jpeg comments (jhead only)
			if ($::jhead && $::jhead_comments && ($::shortdesc || $::longdesc))
			{
			my $comment=$::shortdesc;

				if ($::longdesc)
				{
					$comment.="\n$::longdesc";
				}
				if (updateComment($::photo,$comment))
				{
					debug("updateComment($::photo,$comment) seemed to fail!",2,__LINE__);
				}
			}

			$g_HTML_string.="<img src=\"";
			if ($::create_html_flag)
			{
				$g_HTML_string.=webifyLinks($::shortphoto);
			}
			else
			{
				$g_HTML_string.=webifyLinks("$::album_web/$::photo");
			}
			$g_HTML_string.="\" border=\"0\" title=\"$::S{117} ";
			$safe_photo=$::photo;
			$safe_photo=~s/\'/\\\'/g;
			$g_HTML_string.=$safe_photo;

			if (!$auto_size)
			{
				$g_HTML_string.="\n";
			}
			else
			{
				$g_HTML_string.=" ";
			}
			if ($::next_obj)
			{
				$g_HTML_string.="$::S{118} $::next_obj";
			}
			else
			{
				$g_HTML_string.="$::S{119}";
			}

			$g_HTML_string.="\" ";

			# Get jhead data, if jhead is being used
			if ($::jhead && -x $::jhead)
			{
			my $jhead_text;

				$::jhead_html="\"$::jhead\"";
				if ($::jhead_details)
				{
					$::jhead_html.=" -v";
				}
				$::jhead_html.=" \"$::album_dir/$::photo\"";

				open(JHEAD,"$::jhead_html|") or error(__LINE__,"cant_fork","$! ($::jhead_html)");

				debug("Calling jhead: [$::jhead_html]",2,__LINE__);

				$::jhead_html=$jhead_text="";

				while (<JHEAD>)
				{
					$::jhead_html.="$_<br />";
					$jhead_text.=$_;
					debug("jhead output: $_",2,__LINE__);
				}
				close(JHEAD);

        			if (!$auto_size)
	        		{
        				$g_HTML_string.="onmouseover=\"show(event, 'photoInfo'); return true;\" onmouseout=\"hide('photoInfo'); return true;\"";
                                }
                                else
	        		{
        				$g_HTML_string.="onmouseover=\"show(event, ' + c1 + 'photoInfo' + c1 + '); return true;\" onmouseout=\"hide(' + c1 + 'photoInfo' + c1 + '); return true;\"";
                                }

				debug("jhead text: $jhead_text [$::jhead_html]",2,__LINE__);

				# Turn " into ' so it can be in a title="" tag
				$jhead_text=~s/"/'/g;

				# Fix problems with jscript and jhead output
				$jhead_text=~s/\\/\\\\/g;
#				$jhead_text=~s/\n/\\n/g;
#				$g_HTML_string.="$jhead_text";

				$::jhead_html=<<HTML;
<div id="photoInfo" class="popup">
$::jhead_html
</div>
HTML
			}

			if (!$auto_size)
			{
				if ($::photo_width && $::photo_width ne -1)
				{
					$g_HTML_string.=" width=\"$::photo_width\"";
				}

				if ($::photo_height && $::photo_height ne -1)
				{
					$g_HTML_string.=" height=\"$::photo_height\"";
				}
			}
			else
			{
				$g_HTML_string.=" width=\"\' + resize.w_newPWidth +";
				$g_HTML_string.="\'\"  height=\"\' + resize.w_newPHeight + \'\" ";
			}

			$g_HTML_string.=" />";
			if (!$auto_size)
			{
				$g_HTML_string.="\n";
			}
#			if ($::jhead_html)
#			{
#				$g_HTML_string.=$::jhead_html;
#			}
		}
		else
		{
			$g_HTML_string.=showThumb($::photo);
		}

		# Close off link for next pic
		if (isAPhotoOrJp2($::next_obj) || isAMovie($::next_obj))
		{
			$g_HTML_string.="</a>";
		}
	}

	if (isAJp2($::photo))
	{
		$type=$ENV{"HTTP_USER_AGENT"};
		if ($type=~/Linux/)
		{
			$platform=1;
		}
		if(!$::temp_loc)
		{
			$::temp_loc=$::album_dir
		}
		if ($::imagemagick && !$::create_html_flag && $platform)
		{
			$convertflag=convertImg("\"$::album_dir/$::photo\"","jp2");
			# If the next file is also a photo, make a link to it
			if (isAPhotoOrJp2($::next_obj) || isAMovie($::next_obj))
			{
				$relpath=$::next_obj;
				$g_HTML_string.="<a href=\"";
				$relpath="$::realgoback/$relpath";
				if (isAPhotoOrJp2($::next_obj))
				{
					$g_HTML_string.="$::albumprog?photo=".webifyLinks($relpath);
					$g_HTML_string.=passVars(0);
				}
				elsif (isAMovie($::next_obj))
				{
					$g_HTML_string.=webifyLinks($::album_web."/".$relpath);
				}
			}
			$g_HTML_string.="\" class=\"photolink\">";
			if(!$::temp_web)
			{
				$::temp_web=$::album_web
			}
			$g_HTML_string.="<img src=\"";
			$g_HTML_string.="$::temp_web/converted.jpg";
			$g_HTML_string.="\" border=\"0\" title=\"";
			$g_HTML_string.="$::S{117} $::photo";
			if (!$auto_size)
			{
				$g_HTML_string.="\n";
			}
			else
			{
				$g_HTML_string.=" ";
			}
			if ($::next_obj)
			{
				$g_HTML_string.="$::S{118} $::next_obj";
			}
			else
			{
				$g_HTML_string.="$::S{119}";
			}

			$g_HTML_string.="\"";

			if (!$auto_size)
			{
				if ($::photo_width && $::photo_width ne -1)
				{
					$g_HTML_string.=" width=\"$::photo_width\"";
				}

				if ($::photo_height && $::photo_height ne -1)
				{
					$g_HTML_string.=" height=\"$::photo_height\"";
				}
			}
			else
			{
				$g_HTML_string.=" width=\"\' + resize.w_newPWidth +";
				$g_HTML_string.="\'\"  height=\"\' + resize.w_newPHeight + \'\" ";
			}

			$g_HTML_string.=" />";
			if (!$auto_size)
			{
				$g_HTML_string.="\n";
			}
			# Close off link for next pic
			if (isAPhotoOrJp2($::next_obj) || isAMovie($::next_obj))
			{
				$g_HTML_string.="</a>";
			}
		}
		else
		{
			if (!$auto_size)
			{
				if($::imagemagick)
				{
					# Check the size of the pic
					($height,$width)=getPhotoDimensions("$::album_dir/$::photo");
				}

				if ($::photo_width && !$::photo_height && $::photo_width ne -1)
				{
					if($height)
					{
						$height=($height*$::photo_width/$width);
					}
					else
					{
						$height=$::photo_width;
					}
					$width=$::photo_width;
				}
				elsif (!$::photo_width && $::photo_height && $::photo_height ne -1)
				{
					if($width)
					{
						$width=($width*$::photo_height/$height);
					}
					else
					{
						$width=$::photo_height;
					}
					$height=$::photo_height;
				}
				elsif (($::photo_width && $photo_width ne -1) && ($::photo_height && $::photo_height ne -1))
				{
					$width=$::photo_width;
					$height=$::photo_height;
				}
				elsif (!$width)
				{
					$height=$width=600;
				}

				debug("height=$height width=$width photo_height=$::photo_height photo_width=$::photo_width",4,__LINE__);
			}
			if (!detectBrowser())
			{
				$g_HTML_string.="<object class=\"photolink\" id=img_1 codebase=\"http://www.luratech.com/download/bin/jp2x.cab#Version=1,1,3,11\" border=0 ";
				if (!$auto_size)
				{
					$g_HTML_string.="height=\"$height\" width=\"$width\" ";
				}
				else
				{
					$g_HTML_string.=" width=\"\' + resize.w_newPWidth +";
					$g_HTML_string.="\'\"  height=\"\' + resize.w_newPHeight + \'\" ";
				}
				$g_HTML_string.="classid=\"CLSID:0D4B9606-1FEF-43B0-B76E-43150B060AEB\"><param name=\"SRC\" value=\"";
				if ($::create_html_flag)
				{
					$g_HTML_string.="$shortphoto";
				}
				else
				{
					$g_HTML_string.="$album_web/$photo";
				}
				$g_HTML_string.="\" ref><param name=\"progressive\" value=\"true\">";
				$g_HTML_string.="<param name=\"strict\" value=\"1\">";
				$g_HTML_string.="<param name=\"limit\" value=\"30000\">";
				# If the next file is also a photo, make a link to it
				if (isAPhotoOrJp2($::next_obj) || isAMovie($::next_obj))
				{
					$relpath=$::next_obj;

					$g_HTML_string.="<param name=\"href\" value=\"";
					if ($::create_html_flag)
					{
						# Check to see if it's a photo or an album
						if (isAPhotoOrJP2($::next_obj))
						{
							$g_HTML_string.=webifyLinks($relpath).".html";
						}
						else
						{
							$g_HTML_string.=webifyLinks($relpath)."$relpath";
						}
					}
					else
					{
						$relpath="$::realgoback/$relpath";
						$g_HTML_string.="$::albumprog?photo=".webifyLinks($relpath);
					}
					$g_HTML_string.=passVars(0);
					$g_HTML_string.="\" ref>";
				}
				$g_HTML_string.="$::S{117} $photo";
				if (!$auto_size)
				{
					$g_HTML_string.="\n";
				}
				else
				{
					$g_HTML_string.=" ";
				}
				if ($::next_obj)
				{
					$g_HTML_string.="$::S{118} $next_obj";
				}
				else
				{
					$g_HTML_string.="$::S{119}";
				}
				$g_HTML_string.="</object>";
				if (!$auto_size)
				{
					$g_HTML_string.="\n";
				}
			}
			else
			{
				$g_HTML_string.="<embed type=\"image/jp2\" border=\"0\" ";
				if (!$auto_size)
				{
					$g_HTML_string.="height=\"$height\" width=\"$width\" ";
				}
				else
				{
					$g_HTML_string.=" width=\"\' + resize.w_newPWidth +";
					$g_HTML_string.="\'\"  height=\"\' + resize.w_newPHeight + \'\" ";
				}
				$g_HTML_string.="strict=\"1\" limit=\"30000\" ";
				$g_HTML_string.="src=\"";
				if ($::create_html_flag)
				{
					$g_HTML_string.="$::shortphoto";
				}
				else
				{
					$g_HTML_string.="$::album_web/$::photo";
				}
				$g_HTML_string.="\" progressive=\"1\" pluginurl=\"http://www.luratech.com/download/files/LuraTech_BrowserPlugins_win.exe\" ";
				# If the next file is also a photo, make a link to it
				if (isAPhotoOrJp2($::next_obj) || isAMovie($::next_obj))
				{
					$relpath=$::next_obj;

					$g_HTML_string.="href=\"";
					if ($::create_html_flag)
					{
						# Check to see if it's a photo or an album
						if (isAPhotoOrJp2($::next_obj))
						{
							$g_HTML_string.=webifyLinks($relpath).".html";
						}
						else
						{
							$g_HTML_string.=webifyLinks($relpath)."$relpath";
						}
					}
					else
					{
						$relpath="$::realgoback/$relpath";
						$g_HTML_string.="$::albumprog?photo=".webifyLinks($relpath);
					}
					$g_HTML_string.=passVars(0);
					$g_HTML_string.="\" title=\"";
					$g_HTML_string.="$::S{117} $photo";
					if (!$auto_size)
					{
						$g_HTML_string.="\n";
					}
					else
					{
						$g_HTML_string.=" ";
					}
					if ($::next_obj)
					{
						$g_HTML_string.="$::S{118} $next_obj";
					}
					else
					{
						$g_HTML_string.="$::S{119}";
					}
					$g_HTML_string.="\"";
				}
				$g_HTML_string.="></embed>";
				if (!$auto_size)
				{
					$g_HTML_string.="\n";
				}
			}
		}
	}

	if (!$auto_size)
	{
		$actual_object.=$g_HTML_string;
	}
	else
	{
		$actual_object.="g_HTMLstring = \'".$g_HTML_string."\';";
		$actual_object.=<<HTML;

   document.write(g_HTMLstring);

   }
   -->
</SCRIPT>
HTML

	}
	if ($::jhead_html)
	{
		$actual_object.=$::jhead_html;
	}

	if ($::album)
	{
	my $temptemplate;
		$actual_object="";
		if ($form->param('pickthumb'))
		{
			$actual_object.=$::S{275}."<br /><br />";
		}

		$temptemplate=$::object_template;

		# Load localized object template if present
		$::object_template=findTemplate($::object_template);

		# Open object template
		open(TEMPLATE,"$::object_template") || error(__LINE__,"not_readable","$::object_template: $!");
		debug("Using Template File: [$::object_template]",2,__LINE__);

		$::subtemplate=join("",<TEMPLATE>);
		close(TEMPLATE);

		# Make substitutions for dynamic data in the object template
		$::subtemplate=substituteData($::subtemplate);

		# Restore object template
		$::object_template=$temptemplate;

		# Reset the number of pictures in the current row and on the current page
		$::num_page_pics=$::multi_page=$::total_objects=0;

		$::starting_number=$::photos_per_page*$::page-$::photos_per_page;
		$::ending_number=$::photos_per_page*$::page+1;
		debug("Displaying pictures in range: $::starting_number to $::ending_number",2,__LINE__);

		@temp_file_list=@::file_list;

		if (@::album_list)
		{
			@::file_list=@::album_list;
			@sorted=sortObjects();

			if (@::photo_list || @::movie_list)
			{
				$actual_object.="<div class=\"group\">$::S{259}$::S{286}</div>\n";
			}

			# Open table
			$actual_object.="<table align=\"center\" cellspacing=\"$::column_spacing\"><tr>\n";

			foreach $::shortfile (@sorted)
			{
				$actual_object.=buildAlbum(1);
			}

			# Close table
			$actual_object.="<td></td></tr></table>\n";

			# Close off line
			$actual_object.="<br clear=\"all\">\n";

		}

		# Reset object count
		$::total_objects=0;

		if (@::photo_list || @::movie_list)
		{

			@::file_list=@::photo_list;
			push @::file_list,@::movie_list;

			@sorted=sortObjects();

			if (@::album_list)
			{
				$actual_object.="<div class=\"group\">";
				if (@::photo_list)
				{
					$actual_object.="$::S{260}";
				}
				if (@::movie_list && @::photo_list)
				{
					$actual_object.=" $::S{8} ";
				}
				if (@::movie_list)
				{
					$actual_object.="$::S{261}";
				}
				$actual_object.="$::S{286}</div>\n";
			}

			# Open table
			$actual_object.="<table align=\"center\" cellspacing=\"$::column_spacing\"><tr>\n";

			foreach $::shortfile (@sorted)
			{
				$actual_object.=buildAlbum();
			}

			# Close table
			$actual_object.="<td></td></tr></table>\n";

			# Close off line
			$actual_object.="<br clear=\"all\">\n";
		}

		@::file_list=@temp_file_list;

		# Display total number of pages...
		if ($::multi_page)
		{
			$::pages_html="";

			$::num_page_pics=$::total_objects;
			$temppage=1;
			while ($::num_page_pics > 0)
			{
				$::num_page_pics-=$::photos_per_page;
				$::pages_html.=" ";
				if ($::page ne $temppage)
				{
					$::pages_html.="<a href=\"$::albumprog?";
					if ($::shortalbum ne $::rootalbumname)
					{
						$::pages_html.="album=".webifyLinks($::middle).$::webdelim;
					}
					$::pages_html.="page=$temppage";
					$::pages_html.=passVars(0);
					$::pages_html.="\" class=\"pageslink\">";
				}
				$::pages_html.="$temppage";
				if ($::page ne $temppage)
				{
					$::pages_html.="</a>";
				}
				$temppage++;
			}
			$temppage--;

			debug("Total pages: $temppage",2,__LINE__);
			debug("Current page: $::page",2,__LINE__);

			# Print "Previous" page link
			if (($temppage > 1) && ($::page > 1))
			{
				$pages_html2.=" $::S{89} <a href=\"$::albumprog?";
				if ($::middle)
				{
					$pages_html2.="album=".webifyLinks($::middle).$::webdelim;
				}
				$temppage2=$::page-1;
				$pages_html2.="page=$temppage2";
				$pages_html2.=passVars(0);
				$pages_html2.="\" class=\"pageslink\">";
				$pages_html2.="$::S{209}</a>";
				$::pages_html="$pages_html2 $::pages_html";
			}

			# Print "Next" page link
			if (($temppage > 1) && ($::page < $temppage))
			{
				$::pages_html.=" <a href=\"$::albumprog?";
				if ($::middle)
				{
					$::pages_html.="album=".webifyLinks($::middle).$::webdelim;
				}
				$temppage2=$::page+1;
				$::pages_html.="page=$temppage2";
				$::pages_html.=passVars(0);
				$::pages_html.="\" class=\"pageslink\">";
				$::pages_html.="$::S{208}</a> $::S{92} ";
			}

			# Show "All" pages
			$pages_html2="<a href=\"$::albumprog?";
			if ($::middle)
			{
				$pages_html2.="album=".webifyLinks($::middle).$::webdelim;
			}
			$pages_html2.="page=all";
			$pages_html2.=passVars(0);
			$pages_html2.="\" class=\"pageslink\">";
			$pages_html2.="$::S{303}</a>";

			$::pages_html="$pages_html2 $::pages_html";

			# "Page:" prefix
			$::pages_html="$::S{207} $::pages_html";
		}
	}

	debug("Leaving subroutine: buildObject();",4,__LINE__);

	return($actual_object);
}


##########################################################################

=head3 sortObjects()

 @sorted=sortObjects($mode);

 @sorted - The @::file_list, sorted according to the configuration
 $mode - 0 = Sorting for album view; 1 = Sorting for navigation bar (cuts off photo filename)

Sorts @::file_list, according to configuration settings, and returns the sorted array.

=cut
sub sortObjects
{
my @tempsort;
my @sorted;
my $count;
my $length;
my $newmiddle=$::middle;
my $mode=shift;
my %m;

# $sortby =
# 0 = Sort by filename (ascending)
# 1 = Sort by filename (descending)
# 2 = Sort by modified date (newest first)
# 3 = Sort by modified date (oldest first)
# 4 = Sort by creation date (newest first)
# 5 = Sort by creation date (oldest first)

	debug("Entering subroutine: sortObject()",4,__LINE__);

	debug("\$::sortby = $::sortby",2,__LINE__);

	# Cheap way to do debug("XX",2,__LINE__);
	if ($::debug gt 2)
	{
	my $temp;

		require $::display_module;
		display("<pre>".__LINE__.": Unsorted...<br />");

		foreach $temp (@::file_list)
		{
			display("--> $temp<br />");
		}
		display("</pre>");
	}

	@::file_list=sort {uc($a) cmp uc($b)} @::file_list;

	# Sort by file date
	if ($::sortby eq 2 || $::sortby eq 3 || $::sortby eq 4 || $::sortby eq 5)
	{
		debug("Sorted by modified date, newest first...",3,__LINE__);
		# Sorting Code by Sukeband (sukeband@vzavenue.net)
		@tempsort=@::file_list;

		# Change all \'s to /'s
		$newmiddle=~s/\\/\//g;

		if ($mode)
		{
			$newmiddle=~s/(.*)\/.*/$1/;
		}
		$newmiddle=$::album_dir."/".$newmiddle."/";

		# Cycle through all elements of @tempsort, adding full path
		for($count=1;$count<=@tempsort;$count++)
		{
			$tempsort[$count-1]="$newmiddle$tempsort[$count-1]";
		}
		$length=1;

		if ($::sortby eq 2 || $::sortby eq 3)
		{
			# Get the modified date of each file
			@sorted=sort{ ($m{$a} ||= -M $a) <=> ($m{$b} ||= -M $b) } @tempsort;
		}
		elsif ($::sortby eq 4 || $::sortby eq 5)
		{
			# Get the creation date of each file
			@sorted=sort{ ($m{$a} ||= -C $a) <=> ($m{$b} ||= -C $b) } @tempsort;
		}

	}
	else
	# Sort by filename, ascending
	{
		debug("Sorted by filename, ascending...",3,__LINE__);
		@sorted=@::file_list;
	}

	# Reverse
	if ($::sortby eq 1 || $::sortby eq 3 || $::sortby eq 5)
	{
		debug("Reversing Sort...",3,__LINE__);
		@sorted=reverse @sorted;
	}


	# Strip out added path, if required
	if ($length)
	{
		# How long is the path we added?
		$length=length("$newmiddle");

		# Chop the added path off again!
		for($count=1;$count<=@sorted;$count++)
		{
			substr($sorted[$count-1],0,$length)="";
		}
	}

	# Cheap way to do debug("XX",2,__LINE__);
	if ($::debug gt 2)
	{
	my $temp;

		require $::display_module;
		display("<pre>".__LINE__.": Sorted...<br />");

		foreach $temp (@sorted)
		{
			display("--> $temp<br />");
		}
		display("</pre>");
	}

	debug("Leaving subroutine: sortObject()",4,__LINE__);

	return(@sorted);
}


##########################################################################

=head3 buildAlbum()

 $return_html=buildAlbum($mode);

 $return_html - The built HTML for the current object
 $mode - 1 = Display this group on every page (albums); 0 = Display as per usual (photos and movies)

Builds the HTML for a photo, album or movie, as it appears in it's album (called when building an album page, for each "thimbnail" object on that page).

=cut
sub buildAlbum
{
# Pull down clean copy of template to use
my $actual_object=$::subtemplate;
my $mode=shift;
my $imagelink="";
my $admin_html="";
my $rating_html="";
my $objthumb="";
my $count_html="";
my $marker_html="";
my $setthumbflag=0;
my $webfile;
my $itsamovie;
my $photocount;
my $moviecount;
my $subalbumcount;
my $eachfile;

	debug("Entering subroutine: buildAlbum($mode)",4,__LINE__);

	# Keep count of total objects
	if ($::shortfile)
	{
		$::total_objects++;
	}

	debug("\$::num_page_pics: $::num_page_pics",3,__LINE__);
	debug("\$::total_objects: $::total_objects (out of $::photos_per_page, exclusive range $::starting_number to $::ending_number)",3,__LINE__);

	# Is this page full?
	if ($::shortfile && (!$::photos_per_page || (($::starting_number < $::total_objects) && ($::ending_number > $::total_objects))) || $mode)
	{
	my $tempmiddle=$::middle;

		debug("\Going to display $::shortfile",3,__LINE__);

		$::isimage=0;
		$::isalbum=0;

		$::file="$::album_dir";
		$webfile="$::album_web";
		if ($::middle)
		{
			$::file.="/$::middle";
			$webfile.="/$::middle";
		}
		$::file.="/$::shortfile";
		$webfile.="/$::shortfile";

		# Check to see if file has photo extension
		$::isimage=isAPhotoOrJp2($::file);

		# Handle links
		$::link_relpath="";
		if ($::isimage eq 2)
		{
			$::link_relpath=$::file;
			$::file=getLinkURL("$::file");
			$::file="$::album_dir/$::file";
			$::shortfile=$::file;
			$::shortfile=~s/.*\/(.*)/$1/;
			$::middle=$::file;
			$::middle=~s/$::album_dir\/(.*)/$1/;
			$::middle=~s/(.*)\/.*/$1/;
			$webfile=$::album_web;
			if ($::middle)
			{
				$webfile.="/$::middle";
			}
			$webfile.="/$::shortfile";
		}

		debug("\$::file: $::file",3,__LINE__);
		debug("\$webFile: $webfile",3,__LINE__);

		# Find relative path
		$::relpath=$::file;
		$::relpath=~s/$::album_dir\/(.*)/$1/;
		$::link_relpath=~s/$::album_dir\/(.*)/$1/;

		debug("Relpath: $::relpath",3,__LINE__);
		debug("Link Relpath: $::link_relpath",3,__LINE__);

		$itsamovie=0;
		# If it's not a photo and not a JPEG 2000, check to see if it's a movie
		if (!$::isimage)
		{
			$::isimage=$itsamovie=isAMovie($::file);
		}

		openDescfile("$::album_dir/$middle/");
		getDescription($::shortfile);

		debug("Checking to see if $::file is a directory",4,__LINE__);
		if (-d $::file)
		{
			debug("$::file is a directory",4,__LINE__);
			$::isimage=0;
			$::isalbum=1;
		}

		# Cheap way to do debug("XX",2,__LINE__);
		if ($::debug gt 2)
		{
			require $::display_module;
			display("<pre>".__LINE__.": $::file");
			if ($::isimage)
			{
				display(" is a photo (so says \$::isimage)");
			}
			if ($::isalbum)
			{
				display(" is an album (so says \$::isalbum)");
			}
			display("</pre>");
		}

		# Use filename if no desc found
		if (!$::founddesc)
		{
			$::shortdesc=$::shortfile;
		}

		# New object
#		$actual_object.="<div class=\"dynwidth\" align=\"$::object_alignment\">";

		if ($::isimage)
		{
			$objthumb.="<div class=\"photosubtitle\">";
#			$objthumb.="<a href=\"#\" onClick=\"MyWindow=window.open('";
			$objthumb.="<a href=\"";

			$imagelink="";

			# Keep track of # of pics on this page
			$::num_page_pics++;

			# if it's a movie...
			if (isAMovie($::file))
			{
				$::static_movies_done++;
				if ($::create_html_flag)
				{
					$imagelink="$::shortfile";
				}
				else
				{
					$imagelink="$::album_web/".webifyLinks($::relpath);
				}
			}
			elsif ($::create_html_flag)
			{
				$imagelink="$::shortfile.html";
			}
			else
			{
				$imagelink="$::albumprog?";

				# We're picking thumbnails
				if ($form->param('pickthumb'))
				{
				my $relalbum="";
				my $thumbpick;

					if ($::goback)
					{
						$relalbum="$::goback/";
					}
					if ($::shortalbum ne $::rootalbumname)
					{
						$relalbum.="$::shortalbum";
					}

					# Get thumbnail HTML for this image
					$thumbpick=showThumb("$relalbum/$::shortfile");

					# Kill off HTML, and just leave relative path
					$thumbpick=~s/^<img.*?src="$::album_web\/.*\/(.*)" align=".*/$1/;

					# A thumbnail is there, so let's do this thing...
					if ($thumbpick=~/$::thumbprefix/)
					{
						$imagelink.="album=$relalbum";
						$imagelink.=$::webdelim."setthumb=$thumbpick";
						$setthumbflag=1;
					}
					else
					{
						$imagelink.="photo=$relalbum/$::shortfile";
					}
				}
				else
				{
					$imagelink.="photo=".webifyLinks($::relpath);
				}
			}

			# If you're entering descriptions, keep going. (Unless this object is a movie...)
			if (!$itsamovie)
			{
				$imagelink.=passVars(0);
			}


			# Open movies in a new window
			if (isAMovie($::file))
			{
#				$imagelink.="','MyWindow','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width=$width,height=$height'); return false;\" target=\"_blank\" class=\"moviethumb";
				$imagelink.="\" target=\"_blank\" class=\"moviethumb";
			}
			else
			{
#				$imagelink.="','MyWindow','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width=$width,height=$height'); return false;\" class=\"imagethumb";
				$imagelink.="\" class=\"imagethumb";
			}

			$objthumb.=$imagelink;
			$objthumb.="\">\n";

			$objthumb.=showThumb($::relpath);
		}

		# The current object is a sub-album
		if ($::isalbum)
		{
			$objthumb.="<div class=\"albumsubtitle\">";

			$objthumb.="<a href=\"";

			$imagelink="";

			# Keep track of # of pics on this page
			$::num_page_pics++;

			if ($::create_html_flag)
			{
				$imagelink="$::shortfile/$::static_html_filename";
			}
			else
			{
				$imagelink="$::albumprog?album=".webifyLinks($::relpath);
			}

			# Insert vars
			$imagelink.=passVars(0);

			$objthumb.=$imagelink;
			$objthumb.="\" class=\"albumthumb\">\n";

			$objthumb.=showThumb($::relpath);
		}

		$objthumb.="</a>";

		# Close the div tag
		$objthumb.="</div>\n";

		# Check to see if we're at the end of a row
		if (!($::total_objects % $::columns))
		{
			$actual_object.="</tr><tr>\n";
		}

		# Substitute with actual object
		$actual_object=~s/####OBJECTTHUMB####/\n<!-- OBJECTTHUMB tag start -->\n$objthumb\n<!-- OBJECTTHUMB tag end -->\n/g;

		# Album admin menu
		if (isAdmin())
		{
			require $::admin_module;
			$admin_html=showAdminMenu(1);
		}
		$actual_object=~s/####OBJADMIN####/\n<!-- OBJADMIN tag start -->\n$admin_html\n<!-- OBJADMIN tag end -->\n/g;

		# Short Description (Title)
		$actual_object=~s/####OBJTITLE####/\n<!-- OBJTITLE tag start -->\n<a href=\"$imagelink\">$::shortdesc<\/a>\n<!-- OBJTITLE tag end -->\n/g;

		# Long Description (no comment tags, so it can be commented out)
		$actual_object=~s/####OBJLONGDESC####/$::longdesc\n/g;

		# Show ratings for movies, or if rating_location is set.
		if ((isAMovie($::file) || ($::rating_location && $::ratingfile)) && !$::isalbum)
		{
			$rating_html.="<br />\n";
			$rating_html.=getRatings(3);
		}

		# Ratings Link
		$actual_object=~s/####OBJRATING####/\n<!-- OBJRATING tag start -->\n$rating_html\n<!-- OBJRATING tag end -->\n/g;


		# Ratings Link
		#buildDescFooter
		$actual_object=~s/####OBJENTERDESC####/\n<!-- OBJENTERDESC tag start -->\n$rating_html\n<!-- OBJENTERDESC tag end -->\n/g;

		# Show count of album contents
		if ($::isalbum && ($::showcount || $::showmoviecount || $::showsubalbumcount))
		{
			opendir(ENTRIES,"$::file") or error(__LINE__,"not_readable","$::file");

			# Change Grep
			@::file_list=grep !/^\.\.?$/,readdir ENTRIES;
			close(ENTRIES);

			$photocount=0;
			$moviecount=0;
			$subalbumcount=0;

			foreach $eachfile (@::file_list)
			{
				if (isAPhotoOrJp2($eachfile))
				{
					$photocount++;
				}
				if (isAMovie($eachfile))
				{
					$moviecount++;
				}
				if (-d "$::file/$eachfile")
				{
					$subalbumcount++;
				}
			}

			$count_html.="$::S{75}";
			if ($::showcount)
			{
				$count_html.="$photocount";
			}
			if ($::showcount && $::showmoviecount)
			{
				$count_html.=", ";
			}
			if ($::showmoviecount)
			{
				$count_html.="$moviecount";
			}
			if ($::showmoviecount && $::showsubalbumcount || $::showsubalbumcount && $::showcount)
			{
				$count_html.=", ";
			}
			if ($::showsubalbumcount)
			{
				$count_html.="$subalbumcount";
			}
			$count_html.="$::S{76}";
		}

		# Object count (no comment tags, so it can be commented out)
		$actual_object=~s/####SHOWCOUNT####/$count_html\n/g;

		# Is there a long description too?
		if ($::founddesc && $::longdesc)
		{
			$marker_html="$::S{120}";
		}

		# Object count (no comment tags, so it can be commented out)
		$actual_object=~s/####OBJDESCMARKER####/$marker_html\n/g;

		# Restore $::middle
		$::middle=$tempmiddle;
	}

	# Are we looking at multiple pages?
	elsif (($::photos_per_page && $::photos_per_page le $::num_page_pics) || ($::page > 1))
	{
		$actual_object="";
		$::multi_page=1;
	}
	else
	{
		$actual_object="";
	}

	if ($form->param('pickthumb') && !$setthumbflag)
	{
		$actual_object="";
	}

	debug("Leaving subroutine: buildAlbum($mode)",4,__LINE__);

	return($actual_object);

}


##########################################################################

=head3 parseLinks()

 $template=parseLinks($template);

 $template - Data is passed in, made web safe, and passed out.

Checks the data passed and converts special characters within any links into web safe characters.

=cut
sub parseLinks
{
my $template=shift;

	# Replace any spaces in the links to %20. Yeah, that's a cool regex, I know. :)
	while ($template=~s/ (src|href)="([^"]*?) ([^"]*)"/ $1="$2%20$3"/g)
	{
	}

	return($template);
}


##########################################################################

=head3 showThumb()

 $thumbnail_html=showThumb($myobject,$mode);

 $myobject - Path/filename to object to search for thumbnail of, relative to album_dir.
 $thumbnail_html - HTML for the thumbnail.
 $mode - 1 = return just the URL to the thumb, not the HTML for the thumb

Returns the proper HTML for the thumbnail of the passed object, honouring all configfile settings. If configured to do so, will also call genThumb for photos that do not already have a thumbnail.

=cut
sub showThumb
{
my $myobject=shift;
my $mode=shift;
my $thumbnail_html;
my $object_no_ext;
my $imgext;
my $thumb_album;
my $middlebit;
my $origisalbum=$::isalbum;
my $objecttype="";
my $newthumbborder=0;
my $alb_thumb_ext;
my $image_thumb;
my $static_album_last;
my $isalbumcache=0;
my $showborder=1;

	debug("Entering subroutine: showThumb($myobject)",4,__LINE__);

	# Is it a link? If so, just turn it into a direct link to the photo...
	if (isAPhotoOrJp2($myobject) eq 2)
	{
		$myobject=getLinkURL("$::album_dir/$myobject");
	}

	# Set up album thumbnails
	if (-d "$::album_dir/$myobject" || $myobject eq $::rootalbumname)
	{
		$objecttype="album";

		if ($::representative_thumbnails)
		{
			# Insert $::thumbprefix to allow proper checking for existing album thumbs
			my $newmiddlebit=$myobject;
			my $newmyobject;
			$newmiddlebit=~s/(.*)\/(.*)/$1/;
			if ($newmiddlebit eq $myobject)
			{
				$newmyobject=$myobject;
				$newmiddlebit="";
			}
			else
			{
				$newmyobject=$2;
				$newmiddlebit.="/";
			}

			my $flag=0;
			my $imgextU;
			foreach $imgext (@::imgexts)
			{
				debug("Searching for album thumbnail: [$::album_dir/$newmiddlebit$::thumbprefix($newmyobject).*]",4,__LINE__);
				$imgext="\L$imgext";
				$imgextU="\U$imgext";
				if (-r "$::album_dir/$newmiddlebit$::thumbprefix$newmyobject.$imgext" || -r "$::album_dir/$newmiddlebit$::thumbprefix$newmyobject.$imgextU")
				{
					$flag=1;
					debug("--> Exists.",4,__LINE__);
				}
			}

			# Only proceed if there is no album thumbnail and the album is a directory
			if (!$flag && -d "$::album_dir/$myobject")
			{
				# Use first thumbnail in album as representitive thumb
				opendir(ENTRIES,"$::album_dir/$myobject") or error(__LINE__,"not_readable","$::album_dir/$myobject");

				# Pick out just thumbnails
				my @bucket=grep /^$::thumbprefix/,readdir ENTRIES;
				close(ENTRIES);

				my $bringa=shift(@bucket);
				# Strip out $::thumbprefix
				$bringa=~s/$::thumbprefix//;

				if ($bringa)
				{
					$objecttype="photo";
					$isalbumcache=1;
					$myobject.="/".$bringa;
					debug("Found a representative thumbnail: $myobject",2,__LINE__);
				}
			}
		}
	}
	# Set up photo/movie thumbnails
	else
	{
		$objecttype="photo";
	}

	# Set vars
	$middlebit=$myobject;
	$middlebit=~s/(.*)\/(.*)/$1/;
	$object_no_ext=$2;
	if ($middlebit eq $myobject)
	{
		$middlebit="";
	}

	if ($object_no_ext)
	{
		$myobject=$object_no_ext;
	}
	$thumb_album="$::album_dir/$middlebit";

	if ($::photo)
	{
		$::isimage=1;
	}

	debug("\$myobject = $myobject",3,__LINE__);
	debug("\$thumb_album = $thumb_album",3,__LINE__);
	debug("\$middlebit = $middlebit",3,__LINE__);
	debug("\$objecttype = $objecttype",3,__LINE__);

	# Set object with no extention var
	if ($objecttype eq "photo")
	{
		# Set photo thumbnail to search for.
		$object_no_ext=$myobject;
		$object_no_ext=~s/(.+)\..+/$1/;
		debug("Stripping extension off photo...",3,__LINE__);
	}
	elsif ($objecttype eq "album")
	{
		$object_no_ext=$myobject;
	}

	debug("\$object_no_ext = $object_no_ext",3,__LINE__);

	debug("Looking for a thumbnail in $thumb_album/$::thumbprefix$object_no_ext.*",3,__LINE__);

	foreach $imgext (@::imgexts)
	{
		# Check lower case extensions
		$imgext="\L$imgext";
		if (-r "$thumb_album/$::thumbprefix$object_no_ext.$imgext")
		{
			$alb_thumb_ext=$imgext;
			debug("Found: $alb_thumb_ext",3,__LINE__);
		}

		# Check upper case extensions
		$imgext="\U$imgext";
		if (-r "$thumb_album/$::thumbprefix$object_no_ext.$imgext")
		{
			$alb_thumb_ext=$imgext;
			debug("Found: $alb_thumb_ext",3,__LINE__);
		}
	}

	if ($alb_thumb_ext)
	{
		$image_thumb="$thumb_album/$::thumbprefix$object_no_ext.$alb_thumb_ext";
		debug("Found thumbnail at: ($image_thumb) ([$thumb_album][/][$::thumbprefix][$object_no_ext][.][$alb_thumb_ext])",3,__LINE__);
	}
	else
	{
		$image_thumb="$thumb_album/$::thumbprefix$myobject";
		debug("No file thumbnail found.",2,__LINE__);
	}

	# Use *something* as a thumbnail!
	if (($::icons && ((-e $::file_photo_icon && $::photo) || (-e $::file_album_icon && $thumb_album))) || (-e "$image_thumb") || $::constrain_thumbs || $::imagemagick || $::perl_gd)
	{
		debug("I've been told to use something as a thumbnail.",2,__LINE__);

		# Thumbnail fading code from MessageDJ
		if ($::thumb_fading)
		{
			$thumbnail_html.="<img ";

			# Don't show fading for SSI calls...
			if (!$::ssi)
			{
				$thumbnail_html.="onmouseover=imageFade(this,$::fade_to,10,$::fade_over) style=\"FILTER: alpha(opacity=$::fade_load)\" onmouseout=imageFade(this,$::fade_out,10,$::fade_over) img ";
			}
			$thumbnail_html.="src=\"";
		}
		else
		{
			$thumbnail_html.="<img src=\"";
		}

		if ($mode)
		{
			$thumbnail_html="";
		}

		# Found a thumbnail for this specific image
		if (-e "$image_thumb")
		{
			debug("$image_thumb exists!",4,__LINE__);
			if ($::create_html_flag)
			{
				# *** This is sort of right... but not quite.
				if ($middlebit && $isalbumcache)
				{
					$thumbnail_html.="/$middlebit/";
				}
				$thumbnail_html.="$::thumbprefix$object_no_ext.$alb_thumb_ext";

				# Keep count of album thumbnails
				if (-d "$thumb_album/$myobject" && $static_album_last ne $myobject)
				{
					$::static_albums_thumb++;
					$static_album_last=$myobject;
				}
			}
			else
			{
				$thumbnail_html.="$::album_web/$middlebit/$::thumbprefix$object_no_ext.$alb_thumb_ext";
				debug("URL to thumbnail: $::album_web/$middlebit/$::thumbprefix$object_no_ext.$alb_thumb_ext",4,__LINE__);
			}
			if ($objecttype eq "photo")
			{
				if (isAMovie($myobject))
				{
					$::static_movies_thumb++;
				}
				else
				{
					$::static_photos_thumb++;
				}
			}
		}
		else
		# No specific thumbnail found, just use the generic one
		{
			debug("$image_thumb does not exist.",4,__LINE__);
			if (isAMovie($myobject))
			{
				# Set this so we don't put borders around the icons (that just looks bad)
				$showborder=0;

				debug("$myobject is a movie.",2,__LINE__);
				if ($::create_html_flag)
				{
					$thumbnail_html.="$::file_movie_icon";
				}
				else
				{
					$thumbnail_html.="$::movie_icon";
				}
			}
			else
			{
				debug("$myobject is not a movie.",2,__LINE__);
				if ($::constrain_thumbs && $objecttype eq "photo")
				{
					debug("It's an image, use a constrained thumbnail.",3,__LINE__);
					if ($::create_html_flag)
					{
						$thumbnail_html.="$myobject";
					}
					else
					{
						$thumbnail_html.="$::album_web/$middlebit/$myobject";
					}
					if ($::thumb_height)
					{
						$thumbnail_html.="\" height=\"$::thumb_height";
					}
					if ($::thumb_width)
					{
						$thumbnail_html.="\" width=\"$::thumb_width";
					}
				}
				else
				{
					if ($::create_html_flag)
					{
						if ($objecttype eq "photo")
						{
							$thumbnail_html.="$::file_photo_icon";
						}
						else
						{
							$thumbnail_html.="$::file_album_icon";
						}
					}
					else
					{
						debug("Defaulting to the generic icon for a thumbnail...",3,__LINE__);
						if ($objecttype eq "photo")
						{
							# Try to generate a thumbnail
							if ($::imagemagick || $::perl_gd)
							{
								$newthumbborder=0;
								if (!$::file)
								{
									$::file="$thumb_album/$myobject";
								}
								debug("\$::file=$::file, \$myobject=$myobject",2,__LINE__);
								$newthumbborder=genThumb($::file,"$thumb_album/$::thumbprefix$object_no_ext."."png",0);
							}

							# Add thumbnail HTML if it was generated properly
							if ($newthumbborder)
							{
								$thumbnail_html.="$::album_web/$middlebit/$::thumbprefix$myobject";
								$newthumbborder=1;
							}
							else
							{
								$thumbnail_html.="$::photo_icon";
								$newthumbborder=0;
							}
						}
						else
						{
							$thumbnail_html.="$::album_icon";

							# Set this so we don't put borders around the icons (that just looks bad)
							$showborder=0;
						}
					}
				}
			}
		}

		if ($mode)
		{
			$justurl=$thumbnail_html;
		}

		$thumbnail_html.="\" align=\"middle\" class=\"";

		# Set isalbum for representative thumbnails, since it's not already set
		if ($isalbumcache)
		{
			$::isalbum=1;
			$isalbumcache=0;
			$myobject="";
		}
		if ($newthumbborder)
		{
			$thumbnail_html.="thumb";
		}
		elsif (isAPhotoOrJp2($myobject))
		{
			$thumbnail_html.="photo";
		}
		elsif (isAMovie($myobject) && $showborder)
		{
			$thumbnail_html.="movie";
		}
		elsif ($::isalbum && $showborder)
		{
			$thumbnail_html.="album";
		}
		else
		{
			$thumbnail_html.="\" border=\"0";
		}
		$thumbnail_html.="\" title=\"$myobject\" />";
	}

	# Kill double /'s
	#$thumbnail_html=~s/([^:])\/\//$1\//g;

	# Restore $::isalbum
	$::isalbum=$origisalbum;

	if ($mode)
	{
		$thumbnail_html=$justurl;
	}


	debug("Full thumbnail HTML is: [$thumbnail_html]",4,__LINE__);

	debug("Leaving subroutine: showThumb($myobject)",4,__LINE__);

	return($thumbnail_html);
}


##########################################################################

=head3 readConfig()

 readConfig($confile,$mode);

 $confile - path and filename of the config file
 $mode - 0 = Reading primary config; 1 = Reading local config (per album config)

Reads configuration information from the specified config file.

=cut
sub readConfig
{
my $confile=shift;
my $mode=shift;
my $data;
my $var;
my $value;
my $localfunc;
my $line=0;
my $confopen=0;
my $couldbe=$0;
my @array_values;

	debug("Entering subroutine: readConfig($confile,$mode)",4,__LINE__);

	if (!$mode)
	{
		# Set all config vars to null, just so they exist. (Was causing some setup issues)
		# ALL VARIABLES SHOULD EXIST HERE
		# String variables
		$::cgi_dir=$::cgi_web=$::album_web=$::album_dir=$::module_path=$::notify_file=$::photo_icon=$::movie_icon=$::album_icon=$::style_sheet=$::descname=$::upload_logfile=$::membersdir=$::auth_db=$::static_html_filename=$::thumbprefix=$::album_password=$::enter_desc=$::update_desc=$::viewfile=$::album_template=$::photo_template=$::updateconfig=$::config=$::update_rating=$::ratingfile=$::upload_template=$::debug_code=$::object_alignment=$::jhead=$::template_dir=$::newconfig=$::protect_album=$::default_admins=$::stringtable=$::imagemagick=$::pic_resize=$::album_folder_icon=$::member_subdir=$::img_dir=$::login_button=$::home_button=$::search_button=$::random_button=$::upload_button=$::recent_button=$::rate_button=$::email_button=$::small_button=$::medium_button=$::large_button=$::fullsize_button=$::fullscreen_button=$::edit_button=$::delete_button=$::move_button=$::config_button=$::create_button=$::titles_button=$::updates_button=$::adminupload_button=$::thumb_button=$::db_name=$::db_hostname=$::db_user=$::db_password=$::db_membertable=$::db_username=$::db_driver=$::object_template=$::postupload=$::popular_button=$::default_guests=$::login_template=$::db_passwdfield=$::db_displaynamefield=$::logout_button=$::link_button=$::auto_button=$::temp_loc=$::temp_web=$::skipalbums="";

		# Numeric variables
		$::cfgver=$::columns=$::column_spacing=$::descloc=$::showcount=$::showmoviecount=$::icons=$::legend=$::notify=$::allow_uploads=$::upload_overwrite=$::upload_size_limit=$::authentication_type=$::per_member_upload=$::create_html_flag=$::slide_timer=$::nextprevthumb=$::constrain_thumbs=$::showsubalbumcount=$::quota=$::jhead_details=$::allow_edit=$::allow_delete=$::allow_move=$::allow_link=$::recent_uploads=$::rating_location=$::thumb_quality=$::always_pic_resize=$::concurrent_uploads=$::block_ubb_junior_members_from_uploading=$::rows=$::default_size=$::db_port=$::textmenu=$::most_popular=$::movie_upload=$::thumb_width=$::thumb_height=$::sortby=$::bread_style=$::jhead_comments=$::movie_upload_size_limit=$::perl_gd=$::thumb_fading=$::fade_load=$::fade_to=$::fade_over=$::fade_out=$::representative_thumbnails=$::shadow_borders=$::shadow_background=0;

		# Array variables
		@::imgexts=("");
		@::movieexts=("");
		@::jp2exts=("");
	}

	debug("Reading configuration information from $confile...",2,__LINE__);

	# Trying to open the provided config file
	if (open(CONFIG,"$confile"))
	{
		debug("Opened config file at $confile",2,__LINE__);
		$confopen=1;
	}
	else
	{
		$confopen=0;
	}

	# Nope. Try just album.cfg
	if (!$confopen && !$mode)
	{
		debug("Trying to read configuration information from album.cfg...",2,__LINE__);
		if (open(CONFIG,"album.cfg"))
		{
			debug("Opened config file at album.cfg",2,__LINE__);
			$confopen=1;
			$::configfile="album.cfg";
		}
		else
		{
			$confopen=0;
		}
	}

	# Nope. Try the same directory as album.pl explicitly
	if (!$confopen && !$mode)
	{
		# Change all \'s to /'s
		$couldbe=~s/\\/\//g;

		# Drop the filename
		$couldbe=~s/(.*\/).*/$1/;

		$couldbe.="album.cfg";
		debug("Trying to read configuration information from $couldbe...",2,__LINE__);
		if (open(CONFIG,"$couldbe"))
		{
			debug("Opened config file at $couldbe",2,__LINE__);
			$confopen=1;
			$::configfile=$couldbe;
		}
		else
		{
			$confopen=0;
		}
	}

	# Nope. Try the same directory as album.pl explicitly, but use $confile as the name, just in case the user has changed it to something like install.cfg
	if (!$confopen && !$mode)
	{
		# Change all \'s to /'s
		$couldbe=~s/\\/\//g;

		# Drop the filename
		$couldbe=~s/(.*\/).*/$1/;

		$couldbe.=$confile;
		debug("Trying to read configuration information from $couldbe...",2,__LINE__);
		if (open(CONFIG,"$couldbe"))
		{
			debug("Opened config file at $couldbe",2,__LINE__);
			$confopen=1;
			$::configfile=$couldbe;
		}
		else
		{
			$confopen=0;
		}
	}

	# Maybe it's a totally new install, and they're using album.cfg.clean
	if (!$mode && -e "$confile.clean" && !-e $confile)
	{
	use File::Copy;

		if (!copy("$confile.clean",$confile))
		{
			print "Error: $!<br />\n";
		}

		debug("Copied $confile.clean to $confile and will try to open that...",2,__LINE__);

		if (open(CONFIG,"$confile"))
		{
			debug("Opened newly created config file at $confile",2,__LINE__);
			$confopen=1;
			$::configfile=$couldbe;
		}
		else
		{
			$confopen=0;
		}
	}

	# Just couldn't find the bloody thing!
	if (!$confopen && !$mode)
	{
		# Plain message, since errors probably won't work.
		error(__LINE__,"no_config","ERROR: Could not open album.cfg. If this is a new install you may have to manually copy album.cfg.clean to album.cfg. ($confile)");
	}

	# No local config, just return
	if (!$confopen)
	{
		debug("No local config file found (which is normal), returning...",2,__LINE__);
		debug("Leaving subroutine: readConfig($confile,$mode)",4,__LINE__);
		return;
	}

	while ($data=<CONFIG>)
	{
		$line++;
		chomp($data);

		# Stript out trailing and leading whitespace
		$data=~s/^\s*(\S*)\s*$/$1/;

		# skip comments and blank lines
		if (!(($data eq "") || ($data=~/^#.*/)))
		{
			if ($data!~/.+=.*/)
			{
				# Manually set this warning string, if it's not already set
				if (!$::S{29})
				{
					$::S{29}="Error in configuration file, line:";
				}
				$::warning.="$::S{29} $line";
			}
			$data=~/(@*\w+)=(.*)/;
			$var=$1;
			$value=$2;

			# Change all \'s to /'s
			$value=~s/\\/\//g;

			debug("Var [$var] = [$value]",3,__LINE__);

			# set variables
			# is it an array?
			if ($var=~/^\@/)
			{
				# Strip spaces from $value
				$value=~s/\s//g;

				@array_values=split(",",$value);
				eval("$var=\@array_values");
				debug("Setting loaded: [$var=@array_values]",4,__LINE__);
			}
			else
			{
				if ($value || $mode)
				{
				my $evalcheck;
					$evalcheck=eval("\$$var=\"\$value\"");

					# Print header if turning on debug
					if ($var eq $::debug_code || $var eq "debug")
					{
						printHTMLHeader();
					}
					debug("Setting var: [$var=$value] -- Result was [$evalcheck:$@]",4,__LINE__);
				}
			}
		}
	}
	close(CONFIG);

	# Check to see if any data was loaded at all
	if (!$::cgi_dir)
	{
		$::warning.="$::S{29} $::S{121}";
	}

	# Full path to album.pl - don't change this
	$::albumprog=$0;

	debug("\$0: $0",2,__LINE__);

	# Change all \'s to /'s
	$::albumprog=~s/\\/\//g;

	# Drop the preceeding path
	$::albumprog=~s/.*\/(.*)/$1/;

	$::albumprog=$::cgi_web."/".$::albumprog;

	debug("Web Path to Album (albumprog): $::albumprog",2,__LINE__);

	# Set default rows, if none are defined
	if (!$::rows)
	{
		$::rows=10;
	}

	# If cols=0, then give it a value, so we can show things properly
	if (!$::columns)
	{
		$::columns=5;
	}

	# If no skipalbums were defined, that can be a problem
	if (!$::skipalbums)
	{
		$::skipalbums="NeverGonnaNameAnAlbumThis";
	}

	# Set $::photos_per_page according to rows x cols
	$::photos_per_page=$::rows*$::columns;
	debug("\$::photos_per_page = [$::photos_per_page] [$::rows]x[$::columns]",2,__LINE__);

	$localfunc=$form->param('function');

	debug("Function is: $localfunc [$::function]",2,__LINE__);

	# Is this the very first time the config has been loaded?
	if ($::newconfig eq "true" && ($localfunc ne $::updateconfig))
	{
		# Set stringtable correctly
		$::stringtable="$::cgi_dir/$::stringtable";
		debug("\$::stringtable is now $::stringtable",3,__LINE__);

		# Check some basic stuff to make sure the environment is safe
		sanityTest();
		require $::admin_module;
		print showConfig();
	}

	debug("Leaving subroutine: readConfig($confile,$mode)",4,__LINE__);
}


##########################################################################

=head3 getRatings()

 $ratings=getRatings($mode,$rating_file_loc);

 $ratings - The string of rating information to insert into the template.
 $mode - 0 = Add a link to submit a rating to the returned data; 1 = Do not return the link to add a rating; 2 = Perform search; 3 = Show rating only, not comments; 4 = It's a popularity contest! Populate @poplist with info on photo ratings.
 $rating_file_loc - Location of ratings file (optional, only used if mode=1).

Returns the ratings information for the current photo/movie.

=cut
sub getRatings
{
my $current_ratingfile="$::album_dir/";
my $mode=shift;
my $rating_file_loc=shift;
my $data="";
my $filename;
my $showcomment;
my $poplistkey;
my $temp1;
my $temp2;
my $searchphoto;

	debug("Entering subroutine: getRatings($mode,$rating_file_loc);",4,__LINE__);

	# Clean out old values
	$::num_ratings=$::current_rating=$::comments="";

	# Reset vars
	$temp1=$temp2=0;

	if ($mode eq 3)
	{
		$showcomment=0;
		$mode=0;
	}
	else
	{
		$showcomment=1;
	}

	if (!$::shortphoto && !$::album)
	{
		debug("No photo selected, not getting ratings.",2,__LINE__);
		return();
	}

	if (!$::ratingfile)
	{
		debug("Ratings are not enabled.",2,__LINE__);
		return();
	}

	# Show rating info for the thumbnail we're looking at, not the current object, if it's a movie or that's how we want it displayed
	if (isAMovie($::file) || $::album && $::rating_location)
	{
		$::shortphoto=$::shortfile;
		$current_ratingfile.="$::middle/";
	}
	elsif ($::goback)
	{
		$current_ratingfile.="$::goback/";
	}
	elsif ($mode)
	{
		$current_ratingfile.="$rating_file_loc/";
	}
	$current_ratingfile.="$::ratingfile";

	if ($rating_file_loc eq $::rootalbumname || $::shortalbum eq $::rootalbumname)
	{
		$current_ratingfile="$::album_dir/$::ratingfile";
	}

	# Reset crap when searching
	if ($mode>1)
	{
		$current_ratingfile="$::album_dir/$rating_file_loc/$::ratingfile";
	}
	debug("\$mode=$mode",3,__LINE__);
	debug("\$::ratingfile=$::ratingfile",3,__LINE__);

	debug("Getting ratings for $::shortphoto in $current_ratingfile",2,__LINE__);

	$searchphoto=quotemeta($::shortphoto);

	# Does it already exist?
	if (-e $current_ratingfile)
	{
		debug("Opened $current_ratingfile, looking for $::shortphoto",4,__LINE__);

		# Open $ratings for reading
		open(RATINGS,"$current_ratingfile") || error(__LINE__,"not_readable","$current_ratingfile");

		while ($data=<RATINGS>)
		{
			chomp($data);

			debug("$current_ratingfile: [$data]",4,__LINE__);

			# Block codes
			$data=~s/####/#\/###/sg;

			# Doing search
			if ($mode>1 && $::searchcomments)
			{
				if ($data=~/$::searchstring/i)
				{
					($filename,,,)=split("\t",$data);
					debug("Found a MATCH (description) of $::searchstring in $data for object $rating_file_loc/$filename",4,__LINE__);
					if(isViewable($rating_file_loc,$filename,"1"))
					{
						push @::searchresults,"$rating_file_loc/$filename";
					}
				}
			}

			# Check for most popular
			if ($mode eq 4)
			{
				($filename,$::num_ratings,$::current_rating,$::comments)=split("\t",$data);

				# Check to see that it still exists before adding it to the list
				if (-e "$::album_dir/$rating_file_loc/$filename")
				{

					# Are we using galleries or photos?
					if ($::popular_flag eq 2)
					{
						$poplistkey="$rating_file_loc";

						# Add existing values to get a total for the gallery
						if ($::poplist{"$poplistkey"})
						{
							($temp1,$temp2)=split("\t",$::poplist{"$poplistkey"});
							$::num_ratings+=$temp1;
							$::current_rating+=$temp2;
						}
					}
					else
					{
						$poplistkey="$rating_file_loc/$filename";
					}

					$::poplist{"$poplistkey"}="$::num_ratings\t$::current_rating";
				}
			}

			# Check to see if this is the one we want
			elsif ($data=~/^$searchphoto\t.*/)
			{
				debug("Found match: $data",3,__LINE__);
				close(RATINGS);
				($filename,$::num_ratings,$::current_rating,$::comments)=split("\t",$data);
				debug("Data: [$data] --> Ratings:[$::num_ratings] Rating:[$::current_rating] Comments:[$::comments]",4,__LINE__);
			}
		}

		close(RATINGS);
	}
	else
	{
		debug("$::current_ratingfile not found.",2,__LINE__);
	}

	if (!$::num_ratings)
	{
		$data="$::S{174}";
	}
	else
	{
		$data="$::S{175} $::num_ratings ";

		# Singular or plural?
		if ($::num_ratings gt 1)
		{
			$data.="$::S{202}";
		}
		else
		{
			$data.="$::S{200}";
		}
		$data.="$::S{176} $::current_rating.";
		if ($showcomment)
		{
			$data.="<br />$::comments";
		}
	}

	# Add "Rate It" link
	if (!$mode)
	{
		$data.="<br /><a href=\"$::albumprog?function=$::rating_form".$::webdelim."rating_file_loc=";

		# Show rating info for the thumbnail we're looking at, not the current object
		if (isAMovie($::file) || $::album && $::rating_location)
		{
			$data.=webifyLinks($::middle);
		}
		else
		{
			$data.=webifyLinks($::goback);
		}
		$data.=$::webdelim."object=";

		# For movies, the object is not the current object, but the object being added to the album. Whew! Also true when rating_location=1...
		if (isAMovie($::file) || $::album && $::rating_location)
		{
			$data.="$::shortfile";
		}
		else
		{
			$data.="$::shortobject";
		}
		$data.=passVars(0);

		# Turn HTML breaks into line breaks when inserting comments as alt text
		$::comments=~s/<br \/>/\n/g;
		$::comments=~s/<br>/\n/g;
		# Kill quotes
		$::comments=~s/"//g;
		$data.="\">";
		if ($::textmenu)
		{
			$data.=$::S{213};
		}
		else
		{
			$data.="<img class=\"button\" src=\"$::rate_button\" title=\"$::comments\" />";
		}
		$data.="</a>";
	}

	$data="<div class=\"ratings\">$data</div>";

	debug("Returning rating of [$data]",4,__LINE__);

	debug("Leaving subroutine: getRatings($mode,$rating_file_loc);",4,__LINE__);

	return($data);
}


##########################################################################

=head3 webifyLinks()

 $output=webifyLinks($input);

 $input - The string to webify (make web safe).
 $output - Web safe version returned.

Returns the "websafe" version of the passed filename/path.

=cut
sub webifyLinks
{
my $input=shift;

	eval("use URI::Escape;");

	if ($@!~/^Can't locate/)
	{
		eval("use URI::Escape");

		# Replace any unsafe chars with their web versions
		$input=uri_escape($input);
	}

	# Replace %2f's with slashes again
	$input=~s/%2f/\//ig;

	# Replace broken http:'s
	$input=~s/http%3a/http:/ig;

	# Clean out '
	$input=~s/\'/%27/g;

	return($input);
}


##########################################################################

=head3 isAdmin()

 $status=isAdmin();

 $status - 0 = Not an admin; 1 = Yep, they're an admin!; 2 = They're a user, but they own this album.

Checks to see if the current user is an authenticated admin.

=cut
sub isAdmin
{
my $status=0;

	# Check to see if the user owns this album
	if ($::loggedin eq $::owner && $::loggedin)
	{
		$status=2;
	}

	# If the current user is a default admin and is logged in, or the admin function is being used.
	if (($::default_admins=~/.*,$::loggedin,.*/ && $::loggedin) || $::function eq $::admin)
	{
		$status=1;
	}

	debug("isAdmin: \$::function=$::function; \$::loggedin=$::loggedin; \$::owner=$::owner; \$::default_admins=$::default_admins... Is admin: $status",2,__LINE__);

	return($status);
}


##########################################################################

=head3 isGuest()

 $status=isGuest();

 $status - 0 = Not a guest, 1 = Yep, they're a guest!

Checks to see if the current user is an authenticated guest.

=cut
sub isGuest
{
my $status=0;

	# If the current user is a default admin and is logged in, or the admin function is being used.
	if (($::default_guests=~/.*,$::loggedin,.*/ && $::loggedin) || $::default_guests=~/^,all,$/i && !isAdmin())
	{
		$status=1;
	}
	if ($::mem_level eq 0 && $::loggedin)
	{
		$status=1;
	}

	debug("isGuest: \$::loggedin=$::loggedin; \$::default_guests=$::default_guests... Is guest: $status",2,__LINE__);

	return($status);
}


##########################################################################

=head3 getCookie()

 getCookie();

Gets cookie from browser, and puts it into %cookie hash.

=cut
sub getCookie
{
my $chip;
my $val;

	# split cookie at each ; (cookie format is name=value; name=value; etc...)
	# Convert plus to space (in case of encoding (not necessary, but recommended)
	foreach (split(/; /, $ENV{'HTTP_COOKIE'}))
	{
		s/\+/ /g;

		# Split into key and value.
		# splits on the first =.
		($chip, $val) = split(/=/,$_,2);

		# Convert %XX from hex numbers to alphanumeric
		$chip =~ s/%([A-Fa-f0-9]{2})/pack("c",hex($1))/ge;
		$val =~ s/%([A-Fa-f0-9]{2})/pack("c",hex($1))/ge;

		# Associate key and value
		$::cookie{$chip} .= "\1" if (defined($::cookie{$chip})); # \1 is the multiple separator
		$::cookie{$chip} .= $val;
	}
}


##########################################################################

=head3 splitCookie()

 splitCookie($param);

 $param = parameter to split

Splits a multi-valued chip into a list of parameters.

=cut
sub splitCookie
{
my $param=shift;
my @params=split("&",$param);
	return (wantarray ? @params : $params[0]);
}


##########################################################################

=head3 showCookie()

 showCookie();

Displays the contents of a cookie in debug level 2.

=cut
sub showCookie
{
my $chip;
my @chips;
my $singlechip;

	debug("Cookie Contents Follow: ",2,__LINE__);
	foreach $chip (%::cookie)
	{
		# Handle arrays
		if ($chip=~/&/)
		{
			@chips=splitCookie($chip);
			foreach $singlechip (@chips)
			{
				debug(" --> [$singlechip]",2,__LINE__);
			}
		}
		if ($::cookie{$chip})
		{
			debug("[$chip] = [$::cookie{$chip}]",2,__LINE__);
		}
	}
	debug("END OF COOKIE",2,__LINE__);
}


##########################################################################

=head3 genThumb()

 $status=genThumb($myobject,$image_thumb,$mode);

 $status - 0 = Success, 1 = Failure
 $myobject - The full file system path to the object to generate a thumbnail for
 $image_thumb - The full file system path to the thumbnail to create for this image
 $mode - 0 = Generate thumbnails for pictures; 1 = Resize pictures on upload; 2 = Resize pictures on upload by file size (not dimensions)

Generates a thumbnail for $object, according to the current rules for thumbnails. This subroutine requires ImageMagick to be installed in order to work.

=cut
sub genThumb
{
my $myobject=shift;
my $image_thumb=shift;
my $mode=shift;
my $system_call;
my $output;
my $retcode;
my $count;
my $target_filesize=$::pic_resize;
my $height;
my $width;
my $resize_dims;

	debug("Entering subroutine: genThumb($myobject,$image_thumb,$mode)",4,__LINE__);

	# Imagemagick is not installed
	if (!$::imagemagick && !$::perl_gd)
	{
		debug("Neither ImageMagick nor GD are installed",4,__LINE__);
		return(1);
	}

	# File is not an image
	if (isAPhotoOrJp2($myobject) ne 1)
	{
		debug("$myobject is not a photo",4,__LINE__);
		return(1);
	}

	# Copy down upload resize dimensions
	$resize_dims=$::pic_resize;

	# Resizing by file size
	if ($mode eq 2)
	{
	my $filesize;
	my $jig;
	my $resizefacator;

		$target_filesize=~s/(\d+)k$/$1/gi;
		debug("Target File Size: $target_filesize",3,__LINE__);

		# Check file size
		($jig,$jig,$jig,$jig,$jig,$jig,$jig,$filesize,$jig,$jig,$jig,$jig,$jig)=stat($myobject);
		debug("$myobject file size: $filesize",3,__LINE__);

		if ($filesize gt ($target_filesize*1024))
		{
			$resizefacator=($target_filesize*1024)/$filesize;

			# Average dimension reduction
#			$resizefacator=($resizefacator+1)/2;
			debug("Resize Factor: $resizefacator",3,__LINE__);

			# Don't enlarge images
			if ($resizefacator lt 1)
			{

				# Check image dimensions
				($height,$width)=getPhotoDimensions($myobject);
				debug("$myobject dimensions (original): $width x $height",3,__LINE__);

				$height=int($height*$resizefacator);
				$width=int($width*$resizefacator);

				$resize_dims=$width."x".$height;

				debug("$myobject dimensions (new): $width x $height",3,__LINE__);
			}
			else
			{
				return(0);
			}
		}
	}

	# Generate thumbnail using ImageMagick
	if ($::imagemagick)
	{
		$system_call="\"$::imagemagick/convert\" ";
		if ($::thumb_quality)
		{
			$system_call.="-quality $::thumb_quality ";
		}
		# Add size parm per ImageMagick man page to reduce processing
		$system_call.="-size ";
		if ($mode)
		{
			$system_call.="$resize_dims";
		}
		else
		{
			if ($::thumb_width)
			{
				$system_call.=$::thumb_width;
			}
			if ($::thumb_width || $::thumb_height)
			{
				$system_call.="x";
			}
			if ($::thumb_height)
			{
				$system_call.=$::thumb_height;
			}
		}

		if ($mode)
		{
			# Some older ImageMagick installs don't know "resize" so use "scale" instead
		#	$system_call.=" -scale ";
			$system_call.=" -resize ";
		}
		else
		{
			# Likewise, ImageMagick 6+ knows how to do "thumbnail" so use that instead
			$system_call.=" -thumbnail ";
		}

		if ($mode)
		{
			$system_call.="$resize_dims";
		}
		else
		{
			if ($::thumb_width)
			{
				$system_call.=$::thumb_width;
			}
			if ($::thumb_width || $::thumb_height)
			{
				$system_call.="x";
			}
			if ($::thumb_height)
			{
				$system_call.=$::thumb_height;
			}
		}
		# limit thumbnails to 256 colors
		if (!$mode)
		{
#			Commented out because it seems to have no effect
#			$system_call.=" -depth 8";
#			call -type Pallete because -colors 256 gives segmentation faults in Imagemagick when type already is Grayscale, Pallete or Bilevel
			$system_call.=" -type Palette";
		}
		$system_call.=" \"$myobject\" \"$image_thumb\"";

		# Resize into desired quality and dimensions
		debug("IMAGEMAGICK: $system_call",2,__LINE__);
	#	system("$system_call");
		$output=`$system_call 2>&1`;
		debug("IMAGEMAGICK RETURNED: $output",2,__LINE__);

		# Add shadow borders, if configured to do so
		if (!$mode && $::shadow_borders)
		{
			$system_call="\"$::imagemagick/convert\" ";
			$system_call.=" \"$image_thumb\"";
			$system_call.=" -threshold 100% +matte - | ";
			$system_call.="\"$::imagemagick/convert\" ";
			$system_call.="- -bordercolor ";
			if ($::shadow_background)
			{
				$system_call.="\"$::shadow_background\"";
			}
			else
			{
				$system_call.="white";
			}
			$system_call.=" -border 20x20 -gaussian 0x3 -shave 15x15 - | \"$::imagemagick/composite\" -gravity northwest";
			$system_call.=" \"$image_thumb\"";
			$system_call.=" -";
			$system_call.=" \"$image_thumb\"";

			# Add drop shadow to thumbnail
			debug("IMAGEMAGICK: $system_call",2,__LINE__);
			#	system("$system_call");
			$output.=`$system_call 2>&1`;
			debug("IMAGEMAGICK RETURNED: $output",2,__LINE__);

			if ($::shadow_borders eq 2)
			{
				$system_call="\"$::imagemagick/convert\" ";
				$system_call.=" \"$myobject\"";
				$system_call.=" -threshold 100% +matte - | ";
				$system_call.="\"$::imagemagick/convert\" ";
				$system_call.="- -bordercolor ";
				if ($::shadow_background)
				{
					$system_call.="\"$::shadow_background\"";
				}
				else
				{
					$system_call.="white";
				}
				$system_call.=" -border 40x40 -gaussian 0x3 -shave 30x30 - | \"$::imagemagick/composite\: -gravity northwest";
				$system_call.=" \"$myobject\"";
				$system_call.=" -";
				$system_call.=" \"$myobject\"";

				# Add drop shadow to original
				debug("IMAGEMAGICK: $system_call",2,__LINE__);
				#	system("$system_call");
				$output.=`$system_call 2>&1`;
				debug("IMAGEMAGICK RETURNED: $output",2,__LINE__);
			}
		}

		if ($output)
		{
			print "$::S{214} $output<br /><br />";
		}

		$retcode=1;

		# Keep checking for thumbnail, for 2 seconds
		for($count=0;$count ge 20;$count++)
		{
			if (!$retcode)
			{
				next;
			}
			sleep(.1);
			if (-r $image_thumb)
			{
				$retcode=0;
			}
		}
	}

	# Generate thumbnail using GD
	if ($::perl_gd)
	{
		# Many thanks for daniel.hofverberg@telia.com for the GD thumbnail code!

		debug("Using Perl GD to create thumbnail...",2,__LINE__);

		eval("use GD;");

		if ($@!~/^Can't locate/)
		{
			GD::Image->trueColor(1); # 1 = Truecolor, 0 = 256 colors

			my $new_height=$::thumb_height;
			my $new_width=$::thumb_width;

			# Create new image
			my $srcimage = GD::Image->newFromJpeg($myobject);
			# For creating thumbnails from PNG files, use newFromPng instead
			# (works exactly the same way)

			if (!$srcimage)
			{
				debug("Could not newFromJpeg for $myobject (probably not a jpeg).",2,__LINE__);
			}
			else
			{
				# Get original dimentions
				my ($srcW,$srcH) = $srcimage->getBounds();

				debug("Original dimensions: $srcW x $srcH",4,__LINE__);

				# Handle situations where only 1 dimension is provided
				if ($new_height && !$new_width && $srcH)
				{
					$new_width=int(($new_height/$srcH)*$srcW);
				}
				if ($new_width && !$new_height && $srcW)
				{
					$new_height=int(($new_width/$srcW)*$srcH);
				}

				debug("Resize dimensions: $new_width x $new_height",4,__LINE__);
				debug("Config'd thumbnail dimensions: $$::thumb_width x $::thumb_height",4,__LINE__);

				# Create thumbnail image
				my $newimage = new GD::Image($new_width,$new_height);

				# Resize original into thumbnail
				$newimage->copyResampled($srcimage,0,0,0,0,$new_width,$new_height,$srcW,$srcH);
				debug("Created newimage ($new_width x $new_height)",4,__LINE__);

				# Write out thumbnail file
				open(GDFILE, ">$image_thumb") || error(__LINE__,"not_writable","$image_thumb");
				debug("Opened $image_thumb",4,__LINE__);
				binmode(GDFILE);

				if ($newimage)
				{
					debug("Creating as JPEG, quality $::thumb_quality.",4,__LINE__);
					print GDFILE $newimage->jpeg($::thumb_quality);
					debug("JPEG created and written.",4,__LINE__);
				}

				debug("Wrote Image",4,__LINE__);
				close(GDFILE);
				debug("Closed $image_thumb",4,__LINE__);
			}
		}
		else
		{
			debug("Could not use GD: ($@) $!",4,__LINE__);
			$::warning.="$@: $!";
		}
	}

	debug("Leaving subroutine: genThumb($myobject,$image_thumb,$mode)",4,__LINE__);

	return($retcode);
}


##########################################################################

=head3 showBreadCrumbs()

 $breadcrumbs=showBreadCrumbs();

 $breadcrumbs - The HTML for the breadcrumb trail.

Builds an HTML "breadcrumb" trail so the user can navigate upwards in their album.
$::bread_style defines the format to be used:

 0 = Use folder heirarchy
 1 = use » single » line » breadcrumbs

=cut
sub showBreadCrumbs
{
my @slices;
my $temp;
my $lastslice;
my $count;
my $indent=0;
my $slice;
my $fullslice;
my $first=1;
my $breadcrumbs;

	debug("Entering subroutine: showBreadCrumbs()",4,__LINE__);

	if ($::album)
	{
		$slice=$::album;
	}
	if ($::photo)
	{
		$slice=$::photo;
	}
	$slice=~s/^$::album_dir(.*)/$1/;

	@slices=split("/",$slice);
	$count=scalar(@slices);
	$count--;
	debug("There are $count levels in this breadcrumb path.",2,__LINE__);

	if (($breadcrumbs || $::album eq $::album_dir) && !$::create_html_flag)
	{
		return($breadcrumbs);
	}

	$breadcrumbs="<a href=\"";
	if ($::create_html_flag)
	{
		$temp=$count;
		while ($temp gt 0)
		{
			$breadcrumbs.="../";
			$temp--;
		}
		$breadcrumbs.="$::static_html_filename";
	}
	else
	{
		$breadcrumbs.="$::albumprog?full=1";
		$breadcrumbs.=passVars(0);
	}
	$breadcrumbs.="\" class=\"breadlink\">";
	openDescfile("$::album_dir/");
	getDescription($::rootalbumname);

	if (!$::bread_style)
	{
		$breadcrumbs.="<img border=\"0\" src=\"";
		if ($::create_html_flag)
		{
			# Hard coded. I know, I know...
			$breadcrumbs.="/thmb_album.png";
		}
		else
		{
			$breadcrumbs.="$::album_folder_icon";
		}
		$breadcrumbs.="\" title=\"\" /> ";
	}

	if (!$::shortdesc)
	{
		$::shortdesc="$::S{87}";
	}
	$breadcrumbs.="$::shortdesc";
	$breadcrumbs.="</a>\n";

	foreach $slice (@slices)
	{
	# Are we on the last "slice" and is it a photo?
	my $lastphoto=($::photo && isAPhotoOrJp2($slice));

		if (!$slice)
		{
			next;
		}

		$indent++;

		if ($lastphoto)
		{
			openDescfile("$::album_dir/$lastslice/");
		}
		else
		{
			openDescfile("$::album_dir/$fullslice/");
		}
		$::shortdesc="";
		getDescription($slice);

		if (!$::bread_style)
		{
			$breadcrumbs.="<br />";

			# Indent sub albums
			$temp=$indent;
			while ($temp)
			{
				$breadcrumbs.=$::S{232};
				$temp--;
			}
		}
		else
		{
			$breadcrumbs.="$::S{276} ";
		}

		if ($first)
		{
			$first=0;
		}
		else
		{
			$fullslice.="/";
		}
		$fullslice.=$slice;
		debug("\$slice=$slice",4,__LINE__);
		debug("\$fullslice=$fullslice",4,__LINE__);
		$breadcrumbs.="<a href=\"";

		if ($::create_html_flag)
		{
			if ($lastphoto)
			{
				$breadcrumbs.="$::shortphoto.html";
			}
			else
			{
				$temp=$count-1;
				while ($temp gt 0)
				{
					$breadcrumbs.="../";
					$temp--;
				}
				$breadcrumbs.="$::static_html_filename";
			}
		}
		else
		{
			$breadcrumbs.="$::albumprog?";

			if ($lastphoto)
			{
				$breadcrumbs.="photo";
			}
			else
			{
				$breadcrumbs.="album";
			}
			$breadcrumbs.="=".webifyLinks($fullslice);
			$breadcrumbs.=passVars(0);
		}
		$breadcrumbs.="\" class=\"breadlink\">";

		if (!$::shortdesc)
		{
			$::shortdesc=$slice;
		}
		if ($slice eq $::recent_upload_album)
		{
			$::shortdesc="$::recent_uploads $::S{195}";
		}

		if (!$::bread_style)
		{
			$breadcrumbs.="<img border=\"0\" src=\"";
			if ($::create_html_flag)
			{
				# Hard coded. I know, I know...
				$breadcrumbs.="/thmb_album.png";
			}
			else
			{
				$breadcrumbs.="$::album_folder_icon";
			}
			$breadcrumbs.="\" title=\"\" /> ";
		}

		$breadcrumbs.="$::shortdesc</a>\n";
		$lastslice=$fullslice;
		$count--;
	}

	debug("Leaving subroutine: showBreadCrumbs()",4,__LINE__);
	return($breadcrumbs);
}


##########################################################################

=head3 shroudPic()

 $imgcode=shroudPic($image);

 $imgcode - The actual content of the image, to display
 $image - The full file path to the image to display back

Displays the image pointed to by $image, even if it is not under the web root.

=cut
sub shroudPic
{
my $image=shift;
my $imgcode="";
my $ext=$image;
my $buf;
my $err=0;
my $referer=$::albumprog;
my $env_referer=$ENV{'HTTP_REFERER'};
my $convertflag=0;
my $ext2="";

	debug("Entering subroutine: shroudPic($image)",4,__LINE__);

	debug("Referer is: $referer",2,__LINE__);
	debug("HTTP_REFERER is: $env_referer",2,__LINE__);

	if ($image eq "random" || $image eq "randthumb")
	{
		# Get random pic
		require $::recent_module;
		$image=randomizer();

		debug("IMAGE: $image",2,__LINE__);

		# Just do thumbnails
		if ($mode ne "randthumb")
		{
			if (isAJp2($image))
			{
				$ext2="jp2";
				if(!$::temp_loc)
				{
					$::temp_loc=$::album_dir;
				}
				if ($::imagemagick)
				{
					$convertflag=convertImg("$::album_dir/$image","jp2");
					$image=$::temp_loc."/converted.jpg";
				}
				else
				{
					print "Content-Type: text/html\n\n<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\"><html>";
				debug("ImageMagick not Installed - Could not convert $image",2,__LINE__);
				print "ImageMagick not Installed - Could not convert $image";
				print "Can not display random JPEG 2000 image. Please use the following URL: ";
				print "<a href=\"$::albumprog\">$::albumprog</a></html>";
				exit(1);
			}
		}
	}

		# Bypass valid referer check
		$env_referer=$referer;
	}

	# Check for valid referer
	if ($env_referer!~/^$referer/i || !$env_referer)
	{
		print "Content-Type: text/html\n\n<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\"><html>";
		debug("Bad Referer: $env_referer",2,__LINE__);

		print "You are not permitted to view this image. Please use the following URL: ";
		print "<a href=\"$::albumprog\">$::albumprog</a></html>";
		exit(1);
	}

	# Get extension
	$ext=$image;
	$ext=~s/.*\.(.*)/$1/;
	$ext="\L$ext";

	if ($ext eq "jpg")
	{
		$ext="jpeg";
	}

	# Special hack for /stuff/image.gif/../morestuff --> /morestuff
	if ($image=~/$ext.*$ext/)
	{
		$image=~s/(.*)\/.*$ext\/\.\.(\/.*$ext)/$1$2/;
	}

	# Strip funny stuff off image link
	#$image=~s/[^a-z0-9\.\_\-\\\/:] ,//gi;

	# Check for relative paths
	if ($image=~/^\\*\./)
	{
		$err=1;
	}
	if ($image=~/^\/*\./)
	{
		$err=1;
	}

	# Remove special chars
	$image=~s/[|><]//g;

	if ($err)
	{
		exit(1);
	}

	if (!$ext2)
	{
		$image="$::album_dir/$image";
	}
	debug("Displaying shrouded image: $image",2,__LINE__);

	# Only show the image if it exists
#	if (-e $image && isAPhotoOrJp2($image))
	if (-e $image)
	{
		$imgcode="Content-Type: image/$ext\n\n";
		open(IMG,"< $image");
		binmode(IMG);
		binmode(STDOUT);

		# Read next 1024 bytes
		while(sysread(IMG, $buf, 1024))
		{
			$imgcode.=$buf;
		}

		close(IMG);
	}
	else
	{
		debug("PROBLEM! Could not open $image",4,__LINE__);
# for debugging only
		$imgcode="Content-Type: text/html\n\n<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\"><html>";
		$imgcode.="PROBLEM! Could not open $image, it does not exist.";
		$imgcode.=" Please use the following URL: ";
		$imgcode.="<a href=\"$::albumprog\">$::albumprog</a></html>";
#		exit(1);
	}
	debug("\$imgcode=[$imgcode]",4,__LINE__);

	debug("Leaving subroutine: shroudPic($image)",4,__LINE__);

	return($imgcode);
}


##########################################################################

=head3 showObject()

 $html=showObject($myobject,$mode,$uploaduser,$uploadtime);

 $html - The object, as seen in "album view," including thumbnail, ratings, etc. Formatted in HTML.
 $myobject - The path to the object (relative to $::album_dir) to display.
 $mode - 0 = Display object normally; 1 = Display object for Recent Uploads; 2 = Display for Popular List
 $uploaduser - Username that uploaded this file (recent uploads only)
 $uploadtime - Time/date that the file was uploaded (recent uploads only)

Displays $object using the current settings of the album.

=cut
sub showObject
{
my $myobject=shift;
my $mode=shift;
my $uploaduser=shift;
my $uploadtime=shift;
my $object_html="";
my $temp;
my $path;
my $albumtemp;
my $middletemp;
my $filetemp;
my $ssitemp;
my $objecttype;
my $classtype;
my $auto_size=0;
my $g_HTML_string="";
my $height=0;
my $width=0;

	debug("Entering subroutine: showObject($myobject,$mode);",4,__LINE__);

	# Save off vars
	$albumtemp=$::album;
	$middletemp=$::middle;

	# find album, path for permission check

	# Is it a photo, movie or an album?
	if (-d "$::album_dir/$myobject")
	{
		$objecttype="album";
	}
	$::album=$myobject;
	$::album=~s/(.*)\/(.*)/$1/;
	$path=$2;
	# Clear middle (album) if it's bogus
	if ($::album eq $myobject)
	{
		$::album="";
	}
	$::middle=$::album;
	# Set path if it's empty
	if (!$path)
	{
		$path=$myobject;
	}
	if ($objecttype eq "album")
	{
		$::album="$::album_dir/$myobject";
		$::album=~s/(.*)\/.*/$1/;
		$path=$::middle;
		$::middle=~s/(.*)\/.*/$1/;
		if ($path eq $::middle)
		{
			$::middle="";
		}
		$path=$myobject;
		$path=~s/.*\/(.*)/$1/;
	}
	else
	{
		$::album="$::album_dir/$::album";
	}

	debug("\$myobject = $myobject",3,__LINE__);
	debug("\$::album = $::album",3,__LINE__);
	debug("\$path = $path",3,__LINE__);
	debug("\$::middle = $::middle",3,__LINE__);

	if(!isViewable($::album,$path,1))
	{
		# restore vars
		$::album=$albumtemp;
		$::middle=$middletemp;
		return;
	}

	# Change all \'s to /'s
	$myobject=~s/\\/\//g;

	# If we were passed an object, and is readable, and if it still points to a file which isn't a thumbnail, display it
	if ($myobject && -r "$::album_dir/$myobject" && $myobject!~/$::thumbprefix/i)
	{
		debug("Displaying object: $myobject",3,__LINE__);

		# Handle links
		if (isAPhotoOrJp2($myobject) eq 2)
		{
			$myobject=getLinkURL("$::album_dir/$myobject");
		}

		# Open table
		if ($mode)
		{
			$object_html.='<table align="center"><tr><td>';
		}

		# For "regular" photos, view in $::columns colums
#		if (!$mode)
#		{
#			$object_html.="<div class=\"dynwidth\">\n";
#		}
#		else
#		{
			if ($::ssi)
			{
				# Add slide show randomizer
				if ($::randompic && $::slide_timer)
				{
					$object_html="<html><head>\n";
					$object_html.="<meta http-equiv=\"Refresh\" content=\"$::slide_timer; url=$::albumprog?random=1&ssi=$::ssi&slideshow=$::slide_timer\">\n";
					$object_html.="</head><body>\n";
				}
				if ($::ssi eq 2)
				{
					$object_html="<html><head>\n";
					$object_html.="</head><body>\n";
				}
				$object_html.="<div class=\"ssirecentuploads\">\n";
			}
			elsif ($mode eq 1)
			{
				$object_html.="<div class=\"recentuploads\">\n";
			}
			elsif ($mode eq 2)
			{
				$object_html.="<div class=\"popular\">\n";
			}
#		}

		# Is it a photo, movie or an album?
		if (-d "$::album_dir/$myobject")
		{
			$objecttype="album";
		}
		elsif (isAMovie($myobject))
		{
			$objecttype="movie";
		}
		else
		{
			$objecttype="photo";
		}

		if (($::photo_width eq "auto" || $::photo_height eq "auto") && (!$::imagemagick))
		{
			$::photo_width=$::small_width;
			$::photo_height=$::small_height;
		}
		if (($::photo_width eq "auto" || $::photo_height eq "auto") && isAPhotoOrJp2($myobject) && $::ssi eq 2)
		{
			$auto_size=1;
			debug("Auto size = 1",4,__LINE__);

			# jscript for window sizing
			$object_html.=<<HTML;
<script type="text/javascript" language="JavaScript">
resize();

<!--
function resize()
   {
     var g_HTMLstring = "";
     var w_newWidth=0;
     var w_newPWidth=0;
     var w_maxWidth=1600;
     var w_newHeight=0;
     var w_newPHeight=0;
     var w_maxHeight=1200;
     var w_currRatio=0;
     var w_reqRatio=0;
     if (self.innerHeight) // all except Explorer
     {
      var netscapeScrollWidth=15;
      w_newWidth=self.innerWidth-netscapeScrollWidth;
      w_newHeight=self.innerHeight-netscapeScrollWidth;
     }
     else if (document.documentElement && document.documentElement.clientHeight) // Explorer 6 Strict Mode
     {
      var explorerScrollWidth=15;
      w_newWidth=document.documentElement.clientWidth;
      w_newHeight=document.documentElement.clientWidth;
     }
     else if (document.body) // other Explorers
     {
      w_newWidth=document.body.clientWidth;
      w_newHeight=document.body.clientHeight;
     }
     if (w_newWidth > w_maxWidth)
       w_newWidth=w_maxWidth;
     if (w_newHeight > w_maxHeight)
       w_newHeight=w_maxHeight;
     w_newPWidth = ( w_newWidth - 45 );
     w_newPHeight = ( w_newHeight - 145 );
     w_currRatio = ( w_newPHeight / w_newPWidth );
HTML

			($height,$width)=getPhotoDimensions("$::album/$path");
			$object_html.="if ($height > $width)";
			$object_html.=<<HTML;

        w_reqRatio = 1014/676;
     else
        w_reqRatio = 676/1014;
     if (w_currRatio < w_reqRatio)
       {w_newPWidth = w_newPHeight / w_reqRatio;}
     else
       {w_newPHeight = w_newPWidth * w_reqRatio;}
     resize.w_newPWidth=w_newPWidth;
     resize.w_newPHeight=w_newPHeight;

HTML
		}


		debug("\$::ssi = $::ssi",4,__LINE__);
		# Open link
		$g_HTML_string.="<a href=\"";

		if ($objecttype eq "movie")
		{
			$g_HTML_string.="$::album_web/$myobject";
		}
		else
		{
			$g_HTML_string.="$::albumprog?$objecttype=$myobject";
		}

		$ssitemp=$::ssi;
		$::ssi=0;
		if ($objecttype ne "movie")
		{
			$temp=passVars(0);
		}
		$::ssi=$ssitemp;
		$g_HTML_string.=$temp;

		# Set link class by object type
		if ($objecttype eq "movie")
		{
			$classtype="moviethumb";
		}
		elsif ($objecttype eq "photo")
		{
			$classtype="imagethumb";
		}
		else
		{
			$classtype="albumthumb";
		}
		$g_HTML_string.="\" class=\"$classtype\">";

		$::album=$myobject;
		$::album=~s/(.*)\/(.*)/$1/;
		$path=$2;

		# Clear middle (album) if it's bogus
		if ($::album eq $myobject)
		{
			$::album="";
		}
		$::middle=$::album;

		# Set path if it's empty
		if (!$path)
		{
			$path=$myobject;
		}

		if ($objecttype eq "album")
		{
			$::album="$::album_dir/$myobject";
			$::album=~s/(.*)\/.*/$1/;

			$path=$::middle;
			$::middle=~s/(.*)\/.*/$1/;
			if ($path eq $::middle)
			{
				$::middle="";
			}

			$path=$myobject;
			$path=~s/.*\/(.*)/$1/;

			$::isalbum=1;
		}
		else
		{
			$::album="$::album_dir/$::album";
		}

		debug("\$myobject = $myobject",3,__LINE__);
		debug("\$::album = $::album",3,__LINE__);
		debug("\$path = $path",3,__LINE__);
		debug("\$::middle = $::middle",3,__LINE__);

		# Save off some vars
		$filetemp=$::file;
		$::file="";

		# Insert thumbnail HTML
		# Show actual image, not thumbnail
		if ($::ssi eq 2)
		{
			if (!isAJp2($myobject))
			{
				$g_HTML_string.="<img ";

				if (!$auto_size)
				{
					if ($::photo_width && $::photo_width ne -1)
					{
						$g_HTML_string.=" width=\"$::photo_width\"";
					}
					if ($::photo_height && $::photo_height ne -1)
					{
						$g_HTML_string.=" height=\"$::photo_height\"";
					}
				}
				else
				{
					$g_HTML_string.=" width=\"\' + resize.w_newPWidth +";
					$g_HTML_string.="\'\"  height=\"\' + resize.w_newPHeight + \'\" ";
				}

				$g_HTML_string.="src=\"$::album_web/$myobject\">";
			}
			else
			{
				$type=$ENV{"HTTP_USER_AGENT"};
				if ($type=~/Linux/)
				{
					$platform=1;
				}
				if(!$::temp_loc)
				{
					$::temp_loc=$::album_dir
				}
				if ($::imagemagick && !$::create_html_flag && $platform)
				{
					$convertflag=convertImg("\"$::album_dir/$myobject\"","jp2");
					if(!$::temp_web)
					{
						$::temp_web=$::album_web
					}
					$g_HTML_string.="<img src=\"";
					$g_HTML_string.="$::temp_web/converted.jpg";
					$g_HTML_string.="\" border=\"0\"";

					if (!$auto_size)
					{
						if ($::photo_width && $::photo_width ne -1)
						{
							$g_HTML_string.=" width=\"$::photo_width\"";
						}

						if ($::photo_height && $::photo_height ne -1)
						{
							$g_HTML_string.=" height=\"$::photo_height\"";
						}
					}
					else
					{
						$g_HTML_string.=" width=\"\' + resize.w_newPWidth +";
						$g_HTML_string.="\'\"  height=\"\' + resize.w_newPHeight + \'\" ";
					}

					$g_HTML_string.=" />";
					if (!$auto_size)
					{
						$g_HTML_string.="\n";
					}
				}
				else
				{
					if (!$auto_size)
					{
						if($::imagemagick)
						{
							# Check the size of the pic
							($height,$width)=getPhotoDimensions("$::album_dir/$myobject");
						}

						if ($::photo_width && !$::photo_height && $::photo_width ne -1)
						{
							if($height)
							{
							$height=($height*$::photo_width/$width);
							}
							else
							{
								$height=$::photo_width;
							}
							$width=$::photo_width;
						}
						elsif (!$::photo_width && $::photo_height && $::photo_height ne -1)
						{
							if($width)
							{
								$width=($width*$::photo_height/$height);
							}
							else
							{
								$width=$::photo_height;
							}
							$height=$::photo_height;
						}
						elsif (($::photo_width && $photo_width ne -1) && ($::photo_height && $::photo_height ne -1))
						{
							$width=$::photo_width;
							$height=$::photo_height;
						}
						elsif (!$width)
						{
							$height=$width=600;
						}

						debug("height=$height width=$width photo_height=$::photo_height photo_width=$::photo_width",4,__LINE__);
					}
					if (!detectBrowser())
					{
						$g_HTML_string.="<object class=\"photolink\" id=img_1 codebase=\"http://www.luratech.com/download/bin/jp2x.cab#Version=1,1,3,11\" border=0 ";
						if (!$auto_size)
						{
							$g_HTML_string.="height=\"$height\" width=\"$width\" ";
						}
						else
						{
							$g_HTML_string.=" width=\"\' + resize.w_newPWidth +";
							$g_HTML_string.="\'\"  height=\"\' + resize.w_newPHeight + \'\" ";
						}
						$g_HTML_string.="classid=\"CLSID:0D4B9606-1FEF-43B0-B76E-43150B060AEB\"><param name=\"SRC\" value=\"";
						$g_HTML_string.="$album_web/$myobject";
						$g_HTML_string.="\" ref><param name=\"progressive\" value=\"true\">";
						$g_HTML_string.="<param name=\"strict\" value=\"1\">";
						$g_HTML_string.="<param name=\"limit\" value=\"30000\">";
						$g_HTML_string.="<param name=\"href\" value=\"";
						$g_HTML_string.="$::albumprog?$objecttype=$myobject";
						$g_HTML_string.="\" ref>";
						$g_HTML_string.="</object>";
					}
					else
					{
						$g_HTML_string.="<embed type=\"image/jp2\" border=\"0\" ";
						if (!$auto_size)
						{
							$g_HTML_string.="height=\"$height\" width=\"$width\" ";
						}
						else
						{
							$g_HTML_string.=" width=\"\' + resize.w_newPWidth +";
							$g_HTML_string.="\'\"  height=\"\' + resize.w_newPHeight + \'\" ";
						}
						$g_HTML_string.="strict=\"1\" limit=\"30000\" ";
						$g_HTML_string.="src=\"";
						$g_HTML_string.="$::album_web/$myobject";
						$g_HTML_string.="\" progressive=\"1\" pluginurl=\"http://www.luratech.com/download/files/LuraTech_BrowserPlugins_win.exe\" ";
						$g_HTML_string.="href=\"";
						$g_HTML_string.="$::albumprog?$objecttype=$myobject";
						$g_HTML_string.="\"></embed>";
					}
				}

			}
		}
		else
		{
			$g_HTML_string.=showThumb($myobject);
		}
		if (!$auto_size)
		{
			$object_html.=$g_HTML_string;
		}
		else
		{
			$object_html.="g_HTMLstring = \'".$g_HTML_string."\'";
			$object_html.=<<HTML;

   document.write(g_HTMLstring);

   }
   -->
</SCRIPT>
HTML
		}

		# Restore vars
		$::file=$filetemp;

		# For SSI, don't display all the "fluff"
		if (!$::ssi)
		{
			# Get description for this photo
			openDescfile("$::album/");
			getDescription($path);
			close(DESC);

			# Set title to filename, if no title was found
			if (!$::shortdesc)
			{
				$::shortdesc=$path;
			}

			# Recent Uploads
			if ($mode)
			{
			my $photodesc=$::shortdesc;
			my $albumdir="$::album_dir/$::middle";

				# Get album description
				$albumdir=~s/(.*)\/(.*)/$1/;
				openDescfile("$albumdir/");
				getDescription("$2");
				close(DESC);

				# Set to album (directory) name if no description
				if (!$::shortdesc)
				{
				my $totaltemp=$::middle;
					$totaltemp=~s/.*\/(.*)/$1/;
					$::shortdesc=$totaltemp;
				}

				$object_html.="</a>";
				$object_html.="</div>\n";

				# Table it
				$object_html.="</td><td>";

				if ($mode eq 1)
				{
					$object_html.="<div class=\"recentuploads\">\n";
				}
				elsif ($mode eq 2)
				{
					$object_html.="<div class=\"popular\">\n";
				}

				$object_html.="$photodesc<br />\n";

				# Uploaded by
				if ($mode eq 1)
				{
					$object_html.="$::S{79} $uploaduser$::S{226}<br />\n";
				}

				# Uploaded into
				if (!(($::popular_flag eq 2) && ($mode eq 2)))
				{
					$object_html.="$::S{196} <a href=\"$::albumprog?album=$::middle$temp\" class=\"$classtype\">$::shortdesc</a><br />\n";
				}
				$object_html.="$uploadtime\n";
			}
			else
			# Display object info for "normal" viewing
			{

				# Display description
				if ($::descloc!=2)
				{
					if ($::descloc eq 1)
					{
						$object_html.="<br />";
					}
					else
					{
						$object_html.=" ";
					}
					$object_html.="$::shortdesc";

					# Is there a long description too?
					if ($::founddesc && $::longdesc)
					{
						$object_html.=" <sup>$::S{120}</sup>";
					}
				}
				$object_html.="</a>\n";

				# Increment counter
				$::searchresults++;
			}
		}

		# Close off tag for randompic
		if ($::randompic)
		{
			$object_html.="</a>\n";
		}

		if ($::ssi || $mode)
		{
			$object_html.="</div>\n";
		}

#		if (!$::ssi)
#		{
#			$object_html.="<br clear=\"all\">\n";
#		}

		# Close table
		if ($mode)
		{
			$object_html.="</td></tr></table>\n";
		}
		# Close page
		if ($::ssi eq 2)
		{
			$object_html.="</body></html>\n";
		}

	}
	elsif (!-r "$::album_dir/$myobject")
	{
		debug("Warning: $::album_dir/$myobject is not readable",4,__LINE__);
	}


	# Restore vars
	$::album=$albumtemp;
	$::middle=$middletemp;

	debug("Leaving subroutine: showObject($myobject,$mode);",4,__LINE__);

	return ($object_html);
}


##########################################################################

=head3 updateComment()

 $retcode=updateComment($myobject,$comment);

 $retcode - Return value: 0 = Success; 1 = Failure.
 $myobject - The path to the photo, relative to album_dir.
 $comment - The comment to add to the photo.

Adds/Updates the comment in $myobject to be $comment. Uses jhead to actually insert the comments into the photo.

=cut
sub updateComment
{
my $retcode;
my $output;
my $system_call;
my $myobject=shift;
my $comment=shift;
my $tempname;

	debug("Entering subroutine: updateComment($myobject,$comment);",4,__LINE__);

	$myobject="$::album_dir/$myobject";

	# Temp filename
	$tempname="$myobject.$$";

	# Check for base requirements
	if (!$::jhead || !$comment || !-e $myobject || !$::jhead_comments)
	{
		debug("Not happening: Jhead: [$::jhead] Comment: [$comment] MyObject: [$myobject] JheadComments: [$::jhead_comments]",4,__LINE__);
		debug("Leaving subroutine: updateComment($myobject,$comment);",4,__LINE__);
		return(1);
	}

	# Strip out HTML from the comments
	$comment=~s/<([^>]|\n)*>//g;

	# Write out comments
	open (FILE,">$tempname") || return(1);
	print FILE "$comment";
	close (FILE);

	$system_call="\"$::jhead\" -ci \"$tempname\" \"$myobject\"";

	# Add comments
	debug("JHEAD: $system_call",2,__LINE__);
	$output=`$system_call 2>&1`;
	debug("JHEAD RETURNED: $output",2,__LINE__);

	# Output is normal for jhead
#	if ($output)
#	{
#		print "$::S{214} $output<br /><br />";
#		$retcode=1;
#	}

	# Clean up
	unlink($tempname);

	debug("Leaving subroutine: updateComment($myobject,$comment);",4,__LINE__);

	return($retcode);
}


##########################################################################

=head3 detectBrowser()

 $type=detectBrowser();

 $type - The browser type: 0 = IE variant; 1 = Mozilla (Opera, Netscape, Phoenix, etc) variant

Detects the browser type, and returns the appropriate value

=cut
sub detectBrowser
{
my $type=$ENV{HTTP_USER_AGENT};

	debug("Entering subroutine: detectBrowser();",4,__LINE__);

	debug("Browser is: $type",2,__LINE__);

	if ($type=~/MSIE/)
	{
		$type=0;
	}
	else
	{
		$type=1;
	}

	debug("Returning: $type",2,__LINE__);

	debug("Leaving subroutine: detectBrowser();",4,__LINE__);

	return ($type);
}


##########################################################################

=head3 printHTMLHeader()

 printHTMLHeader();

Prints the HTML header if it hasn't already been printed.

=cut
sub printHTMLHeader
{
	if (!$::header_printed)
	{
		require $::display_module;
		display($::html_header);
		$::header_printed=1;
		debug("\$::header_printed is now set to 1",4,__LINE__);
	}
}


##########################################################################

=head3 DBICheck()

 $dbi_fail=DBICheck();

 $dbi_fail - 0 = DBI package was found, 1 = DBI package not found

Checks to see if the DBI Perl package was installed and returns a status accordingly.

=cut
sub DBICheck
{
my $dbi_fail;
my $eval_error;

	if ($::authentication_type eq 4)
	{
		# Check for DBI package, include if present
		my $pkg="DBI";
		my $method="available_drivers";

		eval("use ".$pkg.";\n".$pkg."::".$method."(1)");

		$eval_error=$@;

		if ($eval_error)
		{
			$::warning.="$::S{26} $eval_error";
		}

		debug("DBI Fail: [$eval_error]",2,__LINE__);

		if ($eval_error=~/Can't/i || $eval_error=~/no database driver/i)
		{
			$dbi_fail=1;
		}

		# If you're having "no database driver specified and DBI_DSN env var not set" errors, uncomment the line below:
		# $dbi_fail=1;
	}
	else
	{
		$dbi_fail=1;
	}

	debug("DBI Fail: [$dbi_fail]",2,__LINE__);

	return($dbi_fail);
}


##########################################################################

=head3 upgradeCfg()

 upgradeCfg();

Upgrade the album.pl configuration, if possible.

=cut
sub upgradeCfg
{
use Cwd;

# Download vars
my $oldCFG=$form->param('oldconfig');
my $newCFG=$form->param('newconfig');
my $updatedCFG=$oldCFG.".new";
my $adminCode=$form->param('adminCode');
my $fullpath;

	#################################
	#  Open and read in the old Parms
	#  keep all the old variables and
	#  values into an array .
	#################################

	printHTMLHeader();
	print<<HTML;
<head><title>$::S{95} $::S{319}</title>
HTML

	print printHeader();

	print<<HTML;
<h1>$::S{95} $::S{319}</h1>
HTML

	$fullpath=cwd;

	# Append trailing slash if there wasn't one
	if ($fullpath!~/\/$/)
	{
		$fullpath.="/";
	}

	# Move album.cfg.new to album.cfg
	if ($form->param('actuallyupgradecfg'))
	{
	use File::Copy;
		if (!copy($oldCFG.".new",$oldCFG))
		{
			error(__LINE__,"not_writable","Could not copy $oldCFG.new to $oldCFG: $!");
		}
		else
		{
			print<<HTML;
<b>$S{335}</b>
<br />
&nbsp;
<br />
$S{334}
<br />
&nbsp;
<br />
$S{336} <a href="$::albumprog">$::S{170}</a>
HTML
		}
		print showFooter(0);
		exit(0);
	}

	if (!$oldCFG)
	{
		print<<HTML;
$S{322}
<br />
&nbsp;
<br />
$S{320} $S{321} $fullpath$S{226}
<br />
&nbsp;
<br />
<form method="post">
<table><tr><td>
$S{323}</td><td><input type="text" name="oldconfig" value="album.cfg" /><br />
</td></tr>
<tr><td>
$S{324}</td><td><input type="text" name="newconfig" value="album.cfg.clean" /><br />
</td></tr>
<tr><td>
$S{326}</td><td><input type="text" name="adminCode" value="admin" /><br />
</td></tr>
<tr><td colspan="2"><center><input type="submit" value="$S{167}" name="$S{167}" /></center></td></tr>
</table>
<input type="hidden" name="upgradecfg" value="true" />
</form>
$S{327}
<br /><br />
HTML
		print showFooter(0);
		exit(0);
	}

	checkFile($oldCFG);
	checkFile($newCFG);
	checkFile($updatedCFG);

	$oldCFG=$fullpath.$oldCFG;
	$newCFG=$fullpath.$newCFG;
	$updatedCFG=$fullpath.$updatedCFG;

	if ($::admin ne $adminCode)
	{
		print <<HTML;
$S{328}<br />
HTML
		debug("$$::admin/$adminCode",3,__LINE__);
		exit(1);
	}

	print<<HTML;
$S{333}
<br />
&nbsp;
<br />
HTML

	open(OLDCFG, "$oldCFG") or error(__LINE__,"not_readable","Could not open file: $oldCFG ($!)");
	while ($line=<OLDCFG>)
	{
		$line=~s/[
\r\n]//g;
		chomp($line);

		# Skip any line that starts with a comment
		# or is empty
		if ($line=~/^$/ || $line=~/^#/)
		{
			##################################################
			# Usefull to output to HTML for debugging
			##################################################
			debug("$line",3,__LINE__);
		}
		else
		{
			##################################################
			# If this is a parm, load the parm name/value
			# pair into an array.
			##################################################
			#
			($cfgParmName, $cfgParmValue) = split(/=/,$line);
			debug("[$cfgParmName - $cfgParmValue]",3,__LINE__);

			$config{$cfgParmName} = $cfgParmValue;

			debug("<b>The parm is " . $cfgParmName . " = " . $cfgParmValue."</b>",3,__LINE__);
		}
	}
	close(OLDCFG);    # Close the file";

	debug("Done loading $oldCFG",3,__LINE__);

	##################################################
	# Now cycle thru the new file and look for common
	# Parms. If there is a match , replace the default
	# value with the value in memory
	##################################################
	#
	print <<HTML;
<table width="500" border="1" cellpadding="3" cellspacing="1">
<tr><td><b>$S{329}</b></td>
<td><b>$S{330}</b></td>
<td><b>$S{331}</b></td></tr>
HTML

	open(NEWCFG, "$newCFG") or error(__LINE__,"not_readable","Could not open file: $newCFG ($!)");
	open(NEWCFGOUT, ">$updatedCFG") or error(__LINE__,"not_writable","Could not open file: $updatedCFG ($!)");
	while ( $line = <NEWCFG>)
	{
		$line=~s/[
\r\n]//g;
		chomp($line);

		##################################################
		# Skip any line that does not have a = in it
		##################################################
		#
		if ($line=~/^$/ || $line=~/^#/)
		{
			print NEWCFGOUT "$line\n";
		}
		else
		{
			##################################################
			# If this is a Parm Line (=) and the
			# parm corresponds to a parm from the Old file
			# then print the OldParmValue
			# Otherwise, just keep the new stuff
			##################################################
			#
			($cfgParmName, $cfgParmValue) = split(/=/,$line);

			$colour="";

			if (!defined $config{$cfgParmName})
			{
				$colour="green";
				$config{$cfgParmName}="";
			}

			# Update the version from the "clean" file
			if ($cfgParmName=~/^cfgver$/)
			{
				$colour="red";
				$config{$cfgParmName}=$cfgParmValue;
			}

			if (($config{$cfgParmName} ne $cfgParmValue))
			{
				$colour="red";
				print NEWCFGOUT "$cfgParmName=$config{$cfgParmName}\n";
			}
			else
			{
				print NEWCFGOUT "$line\n";
			}

			print "<tr>";
			print "<td><b><font color=\"$colour\">$cfgParmName</font></b></td>";
			print "<td><font color=\"$colour\">$cfgParmValue</font></td>";
			print "<td><font color=\"$colour\">$config{$cfgParmName}</font></td>";
			print "</tr>\n";
		}
	}
	close(NEWCFG);
	close(NEWCFGOUT);

	print <<HTML;
</td></tr></table>
<br />
$S{325} <b>$updatedCFG</b>$S{226}<br />
$S{332}<br />
&nbsp;
<br />
<form method="post">
<center><input type="submit" value="$S{167}" name="$S{167}" /></center>
<input type="hidden" name="upgradecfg" value="true" />
<input type="hidden" name="actuallyupgradecfg" value="true" />
<input type="hidden" name="oldconfig" value="$oldCFG" />
</form>
HTML

	print showFooter(0);
	exit(0);
}


##########################################################################

=head3 checkFile()

 checkFile($filename);

 $filename - File name to check.

Confirms that the file name does not contain spaces or slashes. Used to keep upgradeCfg filenames clean.

=cut
sub checkFile
{
my $filename=shift;

	if ($filename=~/[\/\\ @]/ || $filename=~/%20/ || $filename=~/%2f/ || $filename=~/%5c/)
	{
		error(__LINE__,"sanity","Invalid filename ($filename)...");
	}
}


##########################################################################
=head3 isAJp2()

 isAJp2($photo_name);

 $photo_name - name of picture file

Returns 1 if the filename passed in is that of a valid "JPEG 2000 photo", 2 if it is a link, 0 otherwise.

=cut

sub isAJp2
{
my $flag=0;
my $photo_name=shift;
my $jp2ext;

	debug("Checking to see if $photo_name is a JPEG 2000...",4,__LINE__);

	# *** I may want to add a test to see if $photo_name is a readable file as well, but that might cause problems for relative paths, if they're used

	if ($photo_name=~/^$::thumbprefix/i)
	{
		$flag=0;
	}
	else
	{
		foreach $jp2ext (@::jp2exts)
		{
			if ($photo_name=~/.*\.$jp2ext$/i)
			{
				$flag=1;
				debug("Yep, it's a JPEG 2000.",4,__LINE__);
			}
		}
			# Check for link files
		if ($photo_name=~/.*\.$::linkext$/i)
		{
			$flag=2;
			debug("Yep, it's a photo (actually, a link to a photo).",4,__LINE__);
		}}
	return($flag);
}


##########################################################################

=head3 isViewable()   isViewable($viewdir,$viewfile,$mode);

  $viewdir - directory where we are checking permissions
  $viewfile - file on which to ckeck permissions

Checks the user level needed to view this an album/photo/movie against permissions of user who is logged in.
If building static pages, all objects are viewable.
=cut

sub isViewable
{
my $flag=0;
my $viewdir=shift;
my $viewfile=shift;
my $mode=shift;
my $pic_lev;
my $user_lev;


	debug("Entering subroutine isViewable for $viewdir/$viewfile...\$mode=$mode",4,__LINE__);
	if ($create_html_flag ge 1 || $authentication_type lt 1 || isAdmin() eq 1)
	{
 		$flag=1;
		debug("Leaving subroutine isViewable for $viewdir/$viewfile...\$mode=$mode...\$flag=$flag",4,__LINE__);
 		return $flag;
 	}
 	else
 	{
		close(INFO);
		if($mode eq "1")
		{
			$infofilename=$viewdir."/".$::descname;
		}
		elsif ($mode eq "2")
		{
			$infofilename=$::album_dir."/".$viewdir.$::descname;
		}
		else
		{
			$infofilename=$::album_dir."/".$viewdir."/".$::descname;
		}
		debug("Looking for InfoFile: [$infofilename]<br /><br />",3,__LINE__);
		if (-r $infofilename)
		{
			$::useinfo=1;
			open(INFO,"$infofilename");
			debug("Using InfoFile: [$infofilename]<br /><br />",3,__LINE__);
		}
		# Get Viewlevel
		getViewlevel($viewfile);
		close(INFO);

 		if (!$::info_level || $::info_level eq "anyone" || $::info_level eq 0)
 		{
 			$flag=1;
 			debug("Anyone has permission $flag.",4,__LINE__);
 		}
 		else
 		{
 			if (!$::authenticated)
 			{
 				$flag="";
 				debug("No one has permission, not logged in. flag is \"$flag\" ",4,__LINE__);
 			}
 			else
 			{
 				if ($::mem_level eq 0 || $::mem_level eq 1)
 				{
 					$user_lev=1;
 				}
 				else
 				{
 					$user_lev=2;
 				}
 				if ($::info_level eq "Family" || $::info_level eq 1)
 				{
 					$pic_lev=1;
 				}
 				elsif ($::info_level eq "Friend" || $::info_level eq 2)
 				{
 					$pic_lev=2;
 				}
 				elsif ($::info_level eq "owner" || $::info_level eq 3)
 				{
 					$pic_lev=3;
 				}
 				if (($user_lev ge $pic_lev) || ($pic_lev eq 3 && $::owner eq $::loggedin))
 				{
 					$flag=1;
 					debug("Permission granted on pic_lev $pic_lev with user_lev $user_lev flag $flag.",4,__LINE__);
 				}
 			}
 		}
		debug("Leaving subroutine isViewable for $viewdir/$viewfile...\$mode=$mode...\$flag=$flag",4,__LINE__);
 		return($flag);
 	}
 }


##########################################################################

=head3 getViewlevel()

 getViewlevel($leveltoget);

 $leveltoget - Photo or album to get view level for

Retrieves the view permission level in $::info_level (if present).

=cut

sub getViewlevel
{
my $leveltoget=shift;
my $infoline;
my $prevline;
my $filename;
my $temp_file;
my $leveltosearch;
my $owner;
my $foundinfo;

	debug("Entering subroutine: getViewlevel($leveltoget)",4,__LINE__);

	debug("Getting View permission level for [$leveltoget] --> \$::useinfo=[$::useinfo]",3,__LINE__);

	# Clear variables, in case they're being re-used
	$::owner=$::info_level="";

	# Haven't found a description yet.
	$foundinfo=0;

	# See if description exists
	if ($::useinfo && $leveltoget)
	{

		# Clear $leveltoget if it was just set as a placeholder
		if ($leveltoget eq "./")
		{
			$leveltoget="";
		}

		$leveltosearch=quotemeta($leveltoget);

		# Rewind description file
		seek(INFO,0,0);

		# Reset for search
		$prevline=$::desc_delim;

		while ($infoline=<INFO>)
		{
			chomp($infoline);

			# Block codes
			$infoline=~s/####/#\/###/sg;

			# Found the description we're looking for (not via the search screen)
			if ($infoline=~/^$leveltosearch$/i || $infoline=~/^$leveltosearch:.*$/i)
			{
				# Pull out owner and view level
				($temp_file,$::owner,$::info_level)=split(":",$infoline);
				debug("$::owner owns $infoline",2,__LINE__);
				debug("object level is $::info_level",2,__LINE__);
				$foundinfo=1;
				return();
			}
		}
		if (!$foundinfo)
		{
			$::info_level="anyone";
			debug("No view level found.",3,__LINE__);
		}
	}

	debug("Leaving subroutine: getViewlevel($leveltoget)",4,__LINE__);

}


##########################################################################
=head3 convertImg()

 $status=convertImg($myobject,$filetype);

 $status - 0 = Success, 1 = Failure
 $myobject - The full file system path to the object to be converted from one file type to jpg
 $filetype - (jp2, tif, etc.) = The input image file type

Converts image files, using ImageMagick from input image file type to jpg. Output is always "$::temp_loc/converted.jpg";

=cut
sub convertImg
{
my $myobject=shift;
my $filetype=shift;
my $system_call;
my $output;
my $retcode;
my $count;

	debug("Entering subroutine: convertImg($myobject,$filetype)",4,__LINE__);
	if (-e "$::temp_loc/converted.jpg")
	{
		unlink("$::temp_loc/converted.jpg")
	}
	$system_call="\"$::imagemagick/convert\" ";
	$system_call.="\"$filetype\:";
	$system_call.="$myobject\" \"$::temp_loc/converted.jpg\"";

	debug("IMAGEMAGICK: $system_call",2,__LINE__);
	$output=`$system_call 2>&1`;
	debug("IMAGEMAGICK RETURNED: $output",2,__LINE__);

	if ($output)
	{
		print "$::S{214} $output<br /><br />";
	}

	$retcode=1;

	# Keep checking for conversion, for 15 seconds
	for($count=0;$count ge 150;$count++)
	{
		if (!$retcode)
		{
			next;
		}
		sleep(.1);
		if (-r $::temp_loc/converted.jpg)
		{
			$retcode=0;
		}
	}
	if ($output)
	{
		$retcode=$output;
	}

	debug("Leaving subroutine: convertImg($myobject,$filetype)",4,__LINE__);

	return($retcode);

}


##########################################################################
=head3 isAPhotoOrJp2()

 isAPhotoOrJp2($photo_name);

 $photo_name - name of picture file

Returns 1 if the filename passed in is that of a valid photo or "JPEG 2000 photo", 2 if it is a link, 0 otherwise.

=cut

sub isAPhotoOrJp2
{
my $flag=0;
my $photo_name=shift;

	$flag=isAPhoto($photo_name);
	if (!$flag)
	{
		$flag=isAJp2($photo_name);
	}
	return($flag);
}


##########################################################################
=head3 translateLevel()

 translateLevel($item_level,$mode);

 $item_level - The string passed as a parameter when choosing a view level
 $mode - if 0 then translate string value to digit. If 1 then translate digit to string.

Returns the alternate representation of a photo's view level.

=cut

sub translateLevel
{
my $flag="";
my $item_level=shift;
my $mode=shift;

	debug("Entering subroutine: translateLevel($item_level,$mode)",4,__LINE__);
	if (!$mode)
	{
		if ($item_level eq $S{341})
		{
			$flag=0;
		}
		elsif ($item_level eq $S{299})
		{
			$flag=3;
		}
	}
	else
	{
		if ($item_level eq 0 || !$item_level)
		{
			$flag=$S{341};
		}
		elsif ($item_level eq 3)
		{
			$flag=$S{299};
		}
	}
	if ($::authentication_type eq 1 || $::authentication_type eq 2 || $::authentication_type eq 3 || $::authentication_type eq 4)
	{
		if (!$mode)
		{
			if ($item_level eq $S{345})
			{
				$flag=2;
			}
		}
		else
		{
			if ($item_level eq 2)
			{
				$flag=$S{345};
			}
		}
	}
	if ($::authentication_type eq 2)
	{
		if (!$mode)
		{
			if ($item_level eq $S{346})
			{
				$flag=1;
			}
		}
		else
		{
			if ($item_level eq 1)
			{
				$flag=$S{346};
			}
		}
	}
	if ($::authentication_type eq 5)
	{
		if (!$mode)
		{
			if ($item_level eq $S{342})
			{
				$flag=1;
			}
			elsif ($item_level eq $S{343})
			{
				$flag=2;
			}
		}
		else
		{
			if ($item_level eq 1)
			{
				$flag=$S{342};
			}
			elsif ($item_level eq 2)
			{
				$flag=$S{343};
			}
		}
	}
	debug("Exiting subroutine: translateLevel. \$flag=$flag",4,__LINE__);
	return($flag);
}


######################## END OF SUBROUTINES ########################

######################## END OF FILE ########################
