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
	Xdefaults				\
	xinitrc					\
	xmodmap

EXTRA_DIST	= $(dotfiles)

all:

${HOME}/.fvwm:
	$(hide) ${mkdir_p} "$@"

install-data-hook: ${HOME}/.fvwm
	$(hide) for fn in $(dotfiles) ; do				\
	  if test -f $$fn.$$HOSTNAME ; then				\
	    sed -e 's/@host_name@/$(host)/'				\
	  	-e 's/@os_name@/$(os)/'					\
	        -e 's/@email_addr@/$(email)/'				\
	        -e 's|@cvs_root@|$(cvsroot)|'				\
	        < $$fn.$$HOSTNAME > "$(INSTALL_DIR)/.$$fn" || exit 1 ;	\
	     echo "+ Installed $(INSTALL_DIR)/.$$fn" || exit 1;		\
	  elif test -f $$fn ; then					\
	    sed -e 's/@host_name@/$(host)/'				\
	  	-e 's/@os_name@/$(os)/'					\
	        -e 's/@email_addr@/$(email)/'				\
	        -e 's|@cvs_root@|$(cvsroot)|'				\
	        < $$fn > "$(INSTALL_DIR)/.$$fn" || exit 1 ;		\
	     echo "+ Installed $(INSTALL_DIR)/.$$fn" || exit 1;		\
	  fi ;								\
	done
	$(hide) if [ -e /sys/module/hid_apple/parameters ] ; then	\
	  cat xmodmap.apple >> $(INSTALL_DIR)/.xmodmap || exit 1;	\
	fi
	$(hide) sed -e 's/@host_name@/$(host)/'		 \
	  -e 's/@os_name@/$(os)/'			 \
	  -e 's/@email_addr@/$(email)/'			 \
	  -e 's|@cvs_root@|$(cvsroot)|'			 \
	  < fvwm.config > "$(INSTALL_DIR)/.fvwm/config" || exit 1
	$(hide) echo Installed $(INSTALL_DIR)/.fvwm/config
	$(hide) [ ! -f fvwm.host.${host} ] || 		 \
	  ${INSTALL_DATA} -T fvwm.host.${host}  	 \
	  $(INSTALL_DIR)/.fvwm/${host}.cfg
	$(hide)for fn in ConfigFvwm*[a-z] ; do		\
	  $(INSTALL_DATA) $$fn $(INSTALL_DIR)/.fvwm;	\
	  echo + Installed $$INSTALL_DIR/.fvwm/$$fn;	\
	done
