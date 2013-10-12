TEST_INSTALL_BASE="${top_srcdir}/_test_temp"

$(PACKAGE)-$(VERSION)/configure:
	cd $(top_srcdir); automake && ./configure
	make -C $(top_srcdir) dist
	tar xf $(top_srcdir)/$(PACKAGE)-$(VERSION).tar.gz
	test -d $(TEST_INSTALL_BASE)/home/paul || 	\
	  $(MKDIR_P) $(TEST_INSTALL_BASE)/home/paul

$(TEST_INSTALL_BASE)/$(HOME):
	$(mkdir_p) $@

test: $(PACKAGE)-$(VERSION)/configure $(TEST_INSTALL_BASE)/$(HOME)
	echo $(TEST_INSTALL_BASE)
	bash runtests.bash $(top_srcdir) $(PACKAGE) $(VERSION) $(TEST_INSTALL_BASE)

check: test
