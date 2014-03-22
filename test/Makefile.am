# Makefile.am - 2013-09-20 03:18
#
# Copyright (c) 2013 Paul Houghton <paul4hough@gmail.com>
#

hide = @

TEST_INSTALL_BASE="${top_srcdir}/_test_temp"

$(PACKAGE)-$(VERSION)/configure:
	cd "$(top_srcdir)"; automake && ./configure

$(TEST_INSTALL_BASE)/$(HOME):
	$(mkdir_p) $@

test: $(PACKAGE)-$(VERSION)/configure $(TEST_INSTALL_BASE)/$(HOME)
	$(hide)make -C "$(top_srcdir)" dist
	$(hide)tar xf $(top_srcdir)/$(PACKAGE)-$(VERSION).tar.gz
	$(hide)test -d "$(TEST_INSTALL_BASE)/$(HOME)" || 	\
	  $(mkdir_p) "$(TEST_INSTALL_BASE)/$(HOME)"
	$(hide)echo $(TEST_INSTALL_BASE)
	$(hide)bash runtests.bash "$(PACKAGE)" "$(VERSION)" "$(TEST_INSTALL_BASE)"
	$(hide)rm -rf $(TEST_INSTALL_BASE)
check: test
