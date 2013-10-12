## LoginUtils

[![Test Build Status](https://travis-ci.org/pahoughton/LoginUtils.png)](https://travis-ci.org/pahoughton/LoginUtils)

 
LoginUtils provides Unix multi host os login initialization
files for bash and X11.

## Features

* Feature: installes bash config files
*  provides .bash_aliases
*  provides .bash_profile
*  provides .bash_profile_user
*  provides .bashrc
*  provides .bash_setldlibpath
* Feature: installes X11 config files
*  provides .Xdefaults
* Feature: OSNAME set by config.
*  provides OSNAME set to Linux

## Install

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

## Usage

Just login after install

## Contribute

[Github pahoughton/LoginUtils](https://github.com/pahoughton/LoginUtils)

## Licenses

Copyright (c) 2013 Paul Houghton <paul4hough@gmail.com>

[![LICENSE](http://i.creativecommons.org/l/by/3.0/88x31.png)](http://creativecommons.org/licenses/by/3.0/)

[![endorse](https://api.coderwall.com/pahoughton/endorsecount.png)](https://coderwall.com/pahoughton)

