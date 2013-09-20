
TEST_INSTALL_BASE = $(srcdir)/tinstall
VDOMAIN=tfedora19
VUSER=tester
VUSER_IDRSA=/var/lib/libvirt/sshkeys/tfedora19.user.tester.id_rsa
VHOST_KEY=/var/lib/libvirt/sshkeys/tfedora19.host.key

$(PACKAGE)-$(VERSION)/configure:
	cd $(top_srcdir); automake && configure
	make -C $(top_srcdir) dist
	tar xf $(top_srcdir)/$(PACKAGE)-$(VERSION).tar.gz
	test -d $(TEST_INSTALL_BASE)/home/paul || 	\
	  $(MKDIR_P) $(TEST_INSTALL_BASE)/home/paul

test: $(PACKAGE)-$(VERSION)/configure
	chmod +x runtests.bash
	echo $(TEST_INSTALL_BASE)
	./runtests.bash $(top_srcdir) $(PACKAGE) $(VERSION) $(TEST_INSTALL_BASE)

check: test

virttest:
	echo "$(VDOMAIN) $(VUSER) $(VUSER_IDRSA)"
	./virttest.py $(VDOMAIN) $(VUSER) $(VUSER_IDRSA) $(VHOST_KEY) > virttest.out 2>&1
	cat virttest.out
