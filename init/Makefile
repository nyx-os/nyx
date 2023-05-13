CFLAGS ?= -O2 --Wall -Wextra -Werror

all: init

init: init.c
	$(CC) $(CFLAGS) $< -o $@

.PHONY: install
install: all
	install -d $(DESTDIR)$(PREFIX)/bin
	install --strip-program=$(STRIP) -s init $(DESTDIR)$(PREFIX)/bin/init