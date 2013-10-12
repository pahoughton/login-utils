TEST_INSTALL_BASE="${top_srcdir}/_test_temp"

$(PACKAGE)-$(VERSION)/configure:
	cd $(top_srcdir); automake && ./configure
	make -C $(top_srcdir) dist
	tar xf $(top_srcdir)/$(PACKAGE)-$(VERSION).tar.gz
	test -d "$(TEST_INSTALL_BASE)/$(HOME)" || 	\
	  $(mkdir_p) "$(TEST_INSTALL_BASE)/$(HOME)"

$(TEST_INSTALL_BASE)/$(HOME):
	$(mkdir_p) $@

test: $(PACKAGE)-$(VERSION)/configure $(TEST_INSTALL_BASE)/$(HOME)
	echo $(TEST_INSTALL_BASE)
	bash runtests.bash "$(top_srcdir)" \
	  "$(PACKAGE)" "$(VERSION)" "$(TEST_INSTALL_BASE)"

check: test
