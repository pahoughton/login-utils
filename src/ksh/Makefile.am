#
# File:		Makefile.am
# Project:	LoginUtils 
# Desc:
#
#   automake source for Makefile.in
#
# Notes:
#
# Author(s):   Paul Houghton <paul.houghton@mci.com>
# Created:     06/08/2003 16:15
#
# Revision Info: (See ChangeLog or cvs log for revision history)
#
#	$Author$
#	$Date$
#	$Name$
#	$Revision$
#	$State$
#
# $Id$
#

hide 	= @

host 	= @hostname@
os   	= @build_os@
email	= @email@
cvsroot	= @cvsroot@

dotfiles	=				\
	kshrc

target_dotfiles	=				\
	profile.solaris2.8			\


EXTRA_DIST	=				\
	$(dotfiles)				\
	$(target_dotfiles)			\


install-data-hook:
	$(hide) for fn in $(dotfiles)			    \
			  profile			    \
			  profile_$(host) ;		    \
	do						    \
	  if test -f $$fn.$(os) ; then			    \
	    if test -f $(HOME)/.$$fn ; then		    \
	      echo "+ Will NOT overwrite $(HOME)/.$$fn" ;   \
	    else					    \
	      sed -e 's/@host_name@/$(host)/'		    \
	    	  -e 's/@os_name@/$(os)/'		    \
	          -e 's/@email_addr@/$(email)/'		    \
	          -e 's|@cvs_root@|$(cvsroot)|'		    \
	          < $$fn.$(os) > $(HOME)/.$$fn || exit 1 ;  \
	      echo "+ Installed $(HOME)/.$$fn" || exit 1;   \
	    fi ;					    \
	  else						    \
	    if test -f $$fn ; then			    \
	      if test -f $(HOME)/.$$fn ; then		    \
	        echo "+ Will NOT overwrite $(HOME)/.$$fn" ; \
	      else					    \
	        sed -e 's/@host_name@/$(host)/'		    \
	    	    -e 's/@os_name@/$(os)/'		    \
	            -e 's/@email_addr@/$(email)/'	    \
	            -e 's|@cvs_root@|$(cvsroot)|'	    \
	            < $$fn > $(HOME)/.$$fn || exit 1 ;	    \
	        echo "+ Installed $(HOME)/.$$fn" || exit 1; \
	      fi ;					    \
	    fi ;					    \
	  fi ;						    \
	done
