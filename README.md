## LoginUtils

[![Test Build Status](https://travis-ci.org/pahoughton/login-utils.png)](https://travis-ci.org/pahoughton/login-utils)


LoginUtils provides Unix multi host os login initialization files for
bash and X11.

## Features

* Feature: installes bash config files
*  - provides .bash_aliases
*  - provides .bash_profile
*  - provides .bash_profile_user
*  - provides .bashrc
*  - provides .bash_setldlibpath
* Feature: installes X11 config files
*  - provides .Xdefaults
* Feature: OSNAME set by config.
*  - provides OSNAME set to Linux

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

Login after install

## Contribute

[Github pahoughton/LoginUtils](https://github.com/pahoughton/LoginUtils)

## Licenses
1997-01-15 (cc)  Paul Houghton <paul4hough@gmail.com>
<a rel="license" href="http://creativecommons.org/licenses/by/4.0/">
<img alt="Creative Commons License" style="border-width:0"
src="https://i.creativecommons.org/l/by/4.0/80x15.png" />
</a><a rel="license"
href="http://creativecommons.org/licenses/by/4.0/">Creative Commons
Attribution 4.0 International License</a>.

[![endorse](https://api.coderwall.com/pahoughton/endorsecount.png)](https://coderwall.com/pahoughton)
