#
# File:		Makefile.am
# Project:	LoginUtils 
# Desc:
#
#   automake source for Makefile.in
#
# Notes:
#
# Author(s):   Paul Houghton <paul4hough@gmail.com>
# Created:     06/06/2003 05:44
#

INSTALL_DIR=${prefix}${HOME}

hide = @

host 	= @hostname@
os   	= @build_os@
email	= @email@
cvsroot	= @cvsroot@

dotfiles	=				\
	Xdefaults

EXTRA_DIST	= $(dotfiles)

all:

install-data-hook:
	$(hide) for fn in $(dotfiles) ; do			 \
	  if test -f $$fn ; then				 \
	    if test -f "$(INSTALL_DIR)/.$$fn" ; then		 \
	      echo "+ Will NOT overwrite $(INSTALL_DIR)/.$$fn" ; \
	    else						 \
	      sed -e 's/@host_name@/$(host)/'			 \
	    	  -e 's/@os_name@/$(os)/'			 \
	          -e 's/@email_addr@/$(email)/'			 \
	          -e 's|@cvs_root@|$(cvsroot)|'			 \
	          < $$fn > "$(INSTALL_DIR)/.$$fn" || exit 1 ;	 \
	      echo "+ Installed $(INSTALL_DIR)/.$$fn" || exit 1; \
	    fi ;						 \
	  fi ;							 \
	done
