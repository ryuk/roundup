SHELL  = sh
BINDIR = /usr/local/bin

test:
	@ cd test; \
	$(SHELL) ../roundup -fb

install:
	cp roundup $(BINDIR)/roundup
	chmod 0755 $(BINDIR)/roundup

uninstall:
	rm $(BINDIR)/roundup

.PHONY: test
