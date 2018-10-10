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
# Created:     06/06/2003 04:25
#

INSTALL_DIR = ${prefix}${HOME}

hide 	 = @

host 	 = @hostname@
os   	 = @osname@
#email	 = @email@
username = @username@
cvsroot	 = @cvsroot@

dotfiles	=				\
	bash_profile				\
	bashrc					\
	bash_setldlibpath			\
	bash_aliases				\
	gitconfig				\
	gdbinit

target_dotfiles	=				\
	bash_profile_solaris2.9			\
	bash_profile_Darwin			\
	bash_profile_SunOS

user_dotfiles	=				\
	bash_profile_user			\
	bash_profile_user_cscape

EXTRA_DIST	=				\
	$(dotfiles)				\
	$(target_dotfiles)			\
	$(user_dotfiles)

wacko:

$(INSTALL_DIR):
	$(hide)$(mkdir_p) $@

install-data-hook: $(INSTALL_DIR)
	$(hide) for fn in $(dotfiles)			  \
			  bash_profile_$(host)		  \
			  bash_profile_$(os) ;		  \
	do						  \
	  if test -f "$$fn" ; then			  \
	    rm -f "$(INSTALL_DIR)/.$$fn" ;		  \
	    sed -e 's/@host_name@/$(host)/g'		  \
	    	-e 's/@os_name@/$(os)/g'			  \
	        -e 's/@email_addr@/$(email)/g'		  \
	        -e 's/@user_name@/$(username)/g'		  \
	        -e 's|@cvs_root@|$(cvsroot)|g'		  \
	        < $$fn > "$(INSTALL_DIR)/.$$fn" || exit 1 ; \
	    chmod -w "$(INSTALL_DIR)/.$$fn" || exit 1 ;	  \
	    echo "+ Installed $(INSTALL_DIR)/.$$fn" ;	  \
	  fi ;						  \
	done
	$(hide) for fn in bash_profile_user bash_profile_user_$(host) ; do \
	  if test -f "$$fn" ; then					   \
	    if test -f "$(INSTALL_DIR)/.$$fn" ; then			   \
	      echo "+ Will NOT overwrite $(INSTALL_DIR)/.$$fn" ;	   \
	    else							   \
	      sed -e 's/@host_name@/$(host)/g'				   \
	    	  -e 's/@os_name@/$(os)/g'				   \
	          -e 's/@email_addr@/$(email)/g'				   \
	          -e 's|@cfg_http_proxy@|$(http_proxy)|g'			   \
	          -e 's|@cfg_https_proxy@|$(https_proxy)|g'			   \
	          -e 's|@cvs_root@|$(cvsroot)|g'				   \
	          < $$fn > "$(INSTALL_DIR)/.$$fn" || exit 1 ;		   \
	      echo "+ Installed $(INSTALL_DIR)/.$$fn" || exit 1;	   \
	    fi ;							   \
	  fi ;								   \
	done
