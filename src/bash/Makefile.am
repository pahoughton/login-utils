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
# Created:     06/06/2003 04:25
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
	bash_profile				\
	bashrc					\
	bash_setldlibpath			\
	bash_aliases

target_dotfiles	=				\
	bash_profile_solaris2.6			\
	bash_profile_solaris2.8			\
	bash_profile_solaris2.9			\
	bash_profile_soundwave
	bash_profile_mirage
	bash_profile_sideswipe
	bash_profile_cscape
 
user_dotfiles	=				\
	bash_profile_user			\
	bash_profile_user_soundwave
	bash_profile_user_sideswipe
	bash_profile_user_mirage
	bash_profile_user_cscape

EXTRA_DIST	=				\
	$(dotfiles)				\
	$(target_dotfiles)			\
	$(user_dotfiles)


install-data-hook:
	$(hide) for fn in $(dotfiles)		   \
			  bash_profile_$(host)	   \
			  bash_profile_$(os) ;	   \
	do					   \
	  if test -f $$fn ; then		   \
	    rm -f $(HOME)/.$$fn ;		   \
	    sed -e 's/@host_name@/$(host)/'	   \
	    	-e 's/@os_name@/$(os)/'		   \
	        -e 's/@email_addr@/$(email)/'	   \
	        -e 's|@cvs_root@|$(cvsroot)|'	   \
	        < $$fn > $(HOME)/.$$fn || exit 1 ; \
	    chmod -w $(HOME)/.$$fn || exit 1 ;	   \
	    echo "+ Installed $(HOME)/.$$fn" ;	   \
	  fi ;					   \
	done
	$(hide) for fn in bash_profile_user bash_profile_user_$(host) ; do \
	  if test -f $$fn ; then					   \
	    if test -f $(HOME)/.$$fn ; then				   \
	      echo "+ Will NOT overwrite $(HOME)/.$$fn" ;		   \
	    else							   \
	      sed -e 's/@host_name@/$(host)/'				   \
	    	  -e 's/@os_name@/$(os)/'				   \
	          -e 's/@email_addr@/$(email)/'				   \
	          -e 's|@cvs_root@|$(cvsroot)|'				   \
	          < $$fn > $(HOME)/.$$fn || exit 1 ;			   \
	      echo "+ Installed $(HOME)/.$$fn" || exit 1;		   \
	    fi ;							   \
	  fi ;								   \
	done
