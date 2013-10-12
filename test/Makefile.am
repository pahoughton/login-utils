

$(PACKAGE)-$(VERSION)/configure:
	cd $(top_srcdir); automake && ./configure
	make -C $(top_srcdir) dist
	tar xf $(top_srcdir)/$(PACKAGE)-$(VERSION).tar.gz
	test -d $(TEST_INSTALL_BASE)/home/paul || 	\
	  $(MKDIR_P) $(TEST_INSTALL_BASE)/home/paul

test: $(PACKAGE)-$(VERSION)/configure
	chmod +x runtests.bash
	echo $(TEST_INSTALL_BASE)
	./runtests.bash $(top_srcdir) $(PACKAGE) $(VERSION) $(TEST_INSTALL_BASE)

check: test
