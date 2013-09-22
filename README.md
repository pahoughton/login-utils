
* Introduction
==============

LoginUtils provides Unix multi host os login initialization
files for bash and X11. See test/LastestResults.md for a complete
feature list.

* Installation
==============

Run ./configure use --help for detailed argument information. The
default installation directory is the user's home dir (i.e.
$(HOME)/.bash_profile). Significant options are:

  --prefix=DIR	    install in DIR/$(HOME)
  --with-email      your email address
  --with-hostname   this systems hostname
  --with-osname     this systems os name (Linux,Darwin...
  --with-cvsroot    value for CVSROOT env var

  $ ./configure
  $ make install


* File Information
==================

#
# File:		README
# Project:	LoginUtils 
# Desc:
#
#   Project Information
#
# Notes:
#
# Author(s):   Paul Houghton paul4hough@gmail.com
# Created:     06/08/2003 17:26
#

# Local Variables:
# mode:outline
# End:
