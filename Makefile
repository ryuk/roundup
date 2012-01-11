SHELL  = sh
BINDIR = /usr/local/bin

test:
	@ cd test; \
	$(SHELL) ../roundup.sh -fb

install:
	cp roundup.sh $(BINDIR)/roundup
	chmod 0755 $(BINDIR)/roundup

uninstall:
	rm $(BINDIR)/roundup

.PHONY: test
