#!/usr/bin/perl --
# $Id: album_display.pm,v 1.3 2004/09/13 15:28:10 bobbitt Exp $

######################## START OF POD ########################

=head1 NAME

display.pm - error, display and debug functions for album.pl.

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


=head3 error_sub()

 error_sub($line,$error,$extra_info,$module);

 $line - Line number, where error occurred.
 $error - Pre-defined error code that prints a canned message.
 $extra_info - Additional information that can be passed in.
 $module - Module name (optional).

Displayes the error message associated with $error along with the $extra_info. Then halts execution.

=cut
sub error_sub
{
my $error;
my $error_header;
my $errstring;
my $line=shift;
my $error=shift;
my $extra_info=shift;
my $module=shift;

	printHTMLHeader();

	# Fill in some vars if strings weren't loaded properly
	if (!$::S{18})
	{
		$::S{18}="ERROR! (No stringtable loaded)";
		$::S{19}="Error: Line";
	}

	$error_header="<head><title>album.pl - $::S{18}</title>\n";
	$error_header.=printHeader();
	$error_header.="<h1>$::S{19} $line ($module)</h1><br />\n";

	# Print error header
	display($error_header);

	# Build error info, depending on error code
	if ($error eq "not_readable")
	{
		$errstring="$::S{20} <b>$extra_info</b> ($!)\n";
	}
	elsif ($error eq "tempdesc_not_writable")
	{
		$errstring="$::S{21} <b>$extra_info</b> ($!)<p>\n$::S{22}";
	}
	elsif ($error eq "not_writable")
	{
		$errstring="$::S{23} <b>$extra_info</b> ($!)\n";
	}
	elsif ($error eq "stringtable")
	{
		$errstring="String table is not found! Cannot continue execution. <b>$extra_info</b>\n";
	}
	elsif ($error eq "sanity")
	{
		$errstring="$::S{24} <b>$extra_info</b>\n";
	}
	elsif ($error eq "upload_error")
	{
		$errstring="$::S{25} <b>$extra_info</b>\n";
	}
	elsif ($error eq "open_db")
	{
		$errstring="$::S{26} <b>$extra_info</b> ($!)\n";
	}
	elsif ($error eq "short_stringtable")
	{
		$errstring="Your string table ($::stringtable) is too short: <b>$extra_info</b>\n";
	}
	elsif ($error eq "cant_append")
	{
		$errstring="$::S{27} <b>$extra_info</b> ($!)\n";
	}
	elsif ($error eq "upload_dir")
	{
		$errstring="$::S{28} <b>$extra_info</b> ($!)\n";
	}
	elsif ($error eq "reg_error")
	{
		$errstring="$::S{30} <b>$extra_info</b>\n";
	}
	elsif ($error eq "no_config")
	{
		$errstring="$::S{31} ($extra_info).\n<p>$::S{32} <b>$0</b> $::S{33}\n";
	}
	elsif ($error eq "cant_fork")
	{
		$errstring="Cannot fork: $extra_info.\n";
	}
	else
	{
		# Handle error codes not listed above
		$errstring="$::S{34} $error ($extra_info)<p>\n$::S{35}\n";
	}

	# Print error info
	display("$errstring<p>\n");
	display("<hr />\n");

	# Strip out any HTML for js popup
	$errstring=~s/<([^>]|\n)*>//g;

	# Put up a javascript popup
	display(javaAlert($errstring));

	# Print error footer
	showFooter(1);

	# End of error
	exit(0);
}


##########################################################################

=head3 display()

 display($display_message);

 $display_message - String to print (to STDOUT or to static file)

Prints a message to the designated output steam

=cut
sub display
{
	print {$::create_html_flag ? "STATIC" : \*STDOUT } "@_";

#	if ($::debug || ($::create_html_flag eq 1))
	if ($::create_html_flag eq 1)
	{
		print "@_";
	}
}


##########################################################################

=head3 debug_sub()

 debug($debug_message,$debug_level,$line,$module);

 $debug_message - String to print if debugging is on
 $debug_level - Only pring string if current debug level is $debug_level or higher (current debug level is set by $debug)
 $line - The line number of the debug statement.
 $module - Module name (optional).

Prints a message, if $::debug has a value.

=cut
sub debug_sub
{
my $debug_message=shift;
my $debug_level=shift;
my $line=shift;
my $module=shift;

	if (($debug_level le $::debug) && $::debug)
	{
		# Entering subroutine
		if ($debug_message=~/^Entering subroutine:/i)
		{
			display("<ul>");
		}
		display("<pre>");
		if ($module)
		{
			display("[$module] ");
		}
		if ($line)
		{
			display("$line: ");
		}
		display("$debug_message</pre>\n");

		# Leaving subroutine
		if ($debug_message=~/^Leaving subroutine:/i)
		{
			display("</ul>");
		}
	}
}


##########################################################################

=head3 javaAlert()

 $javastuff=javaAlert($message);

 $message - Message to display
 $javastuff - HTML/JavaScript code to display a popup.

Returns HTML/JavaScript code to display $message as a javascript "alert" popup.

=cut
sub javaAlert
{
my $message=shift;
my $javastuff;

	$javastuff="<script language=\"JavaScript\">\n";
	$javastuff.="<!--\n";
	$message=~s/[\n\r]//g;
	$javastuff.="alert('$message');\n";
	$javastuff.="//-->\n";
	$javastuff.="</script>\n";
	return($javastuff);
}


##########################################################################
######################## END OF SUBROUTINES ########################

######################## END OF FILE ########################

1;