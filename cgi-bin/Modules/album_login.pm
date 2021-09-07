#!/usr/bin/perl --
# $Id: album_login.pm,v 1.2 2004/09/13 15:28:10 bobbitt Exp $

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


=head3 delCookie()

 delCookie($cookie1,$cookie2);

Deletes cookies of provided names. Deletion is handled by expiring the cookie immediately. Must be done before the content type header is sent to the browser.

=cut
sub delCookie
{	# By Scouter
use CGI qw(:standard);

my $cookie1=shift;
my $cookie2=shift;

		eval("use CGI::Cookie;");

	if ($@!~/^Can't locate/)
	{
	my $newcookie1;
	my $newcookie2;

		# undefines cookie
		undef $::cookie{$cookie1};
		undef $::cookie{$cookie2};

		eval("\$newcookie1=new CGI::Cookie(-name=>\$cookie1,-expires =>'-2d',);");
		eval("\$newcookie2=new CGI::Cookie(-name=>\$cookie2,-expires =>'-2d',);");

		eval("print header(-cookie=>[\$newcookie1,\$newcookie2]);");

		$::header_printed=1;
	}
}


##########################################################################

=head3 showLogin()

 showLogin();

Returns the login form as HTML, to be inserted into a template.

=cut
sub showLogin
{
my $data;
my $loginAlbum;

	debug("Entering subroutine: showLogin",4,__LINE__,$::login_module);
	$data="<form method=\"post\" action=\"$::albumprog\">\n";

	# If we were logging in to an album, keep that album name. (From J.P. Stewart [j.p.stewart@mindspring.com])
	$loginAlbum=$form->param('album');
	$data.="<td valign=\"top\">\n";
	if ($loginAlbum)
	{
		$data.="<input type=hidden name=album value=\"$loginAlbum\">\n";
	}

	# Failed to log in, show failure message
	if ($::password && !$::authenticated)
	{
		$data.="$::S{181}\n";
		# Make it a popup too
		require $::display_module;
		$data.=javaAlert($::S{181});
	}
	else
	{
		# Or show "please log in" message
		$data.="$::S{182}\n";
	}
	$data.="<p>";

	if (!$::album_password)
	{
		$data.="<b>$::S{55}</b> <input type=\"text\" name=\"username\" value=\"$::username\" size=\"10\" maxlength=\"63\" /><br />\n";
	}
	$data.="<b>$::S{57}</b> <input type=\"password\" name=\"password\" value=\"$::password\" size=\"10\" maxlength=\"63\" />\n";
	$data.="<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n";
	$data.="<input type=\"checkbox\" name=\"login_memory\" value=\"yes\"> Remember Login on this Machine \?\n";
	$data.="<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n";
	$data.="<input type=\"submit\" value=\" LOGIN \" class=\"button\" /><br />\n";
	$data.="</td>\n";
	$data.=passVars(1);

	$data.="</form>\n";

	debug("Leaving subroutine: showLogin",4,__LINE__,$::login_module);

	return($data);
}


##########################################################################
######################## END OF SUBROUTINES ########################

######################## END OF FILE ########################

1;