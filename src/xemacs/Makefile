#
# File:		Makefile
# Project:	Login 
# Desc:
#
#   Build rules and targets
#
# Notes:
#
# Author(s):   Paul Houghton <paul.houghton@wcom.com>
# Created:     05/16/2003 04:03
#
# Revision History: (See end of file for Revision Log)
#
#	$Author$
#	$Date$
#	$Name$
#	$Revision$
#	$State$
#
# $Id$
#

hide = @

EL_SOURCES	= $(wildcard *.el);

INSTALL_DIR	= $(HOME)/.xemacs

$(INSTALL_DIR)/%.el : %.el
	$(hide) [ ! -f $@ ] || mv $@ $@.`date +%F-%H%M%S`.bak
	$(hide) install -p -c -m 444 $^ $@
	@echo "+ Installed $@"

install : $(EL_SOURCES:%=$(INSTALL_DIR)/%)
