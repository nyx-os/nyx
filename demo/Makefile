CFLAGS ?= -O2 --Wall -Wextra -Werror

all: demo

demo: demo.c
	$(CC) $(CFLAGS) $< -o $@

.PHONY: install
install: all
	install -d $(DESTDIR)$(PREFIX)/bin
	install demo $(DESTDIR)$(PREFIX)/bin
