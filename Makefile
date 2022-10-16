.DEFAULT_GOAL: all
.PHONY: all

ifeq (,$(wildcard ./limine))
all:
	@echo "Looks like limine is not cloned locally. Limine is the recommended bootloader for Nyx."
	@echo "Run 'make get-limine' to clone the limine binaries."
	@exit 1

else
all:
	@echo -e "\033[1m-> Building kernel\033[0m"
	$(MAKE) -C gaia
	@echo -e "\033[1m-> Configuring chadlibc\033[0m"
	@cd chadlibc && ./configure --target nyx-x86_64
	@echo -e "\033[1m-> Building chadlibc \033[0m"
	$(MAKE) -C chadlibc
	@echo -e "\033[1m-> Installing chadlibc \033[0m"
	@cp chadlibc/libc.a chadlibc/crt0.o usr/lib
	@cp -r chadlibc/include/* usr/include
	@echo -e "\033[1m-> Building Olympus \033[0m"
	$(MAKE) -C srv/olympus
	cp gaia/build/kernel.elf srv/olympus/build/*.elf boot
	@echo -e "\033[1m-> Installing limine \033[0m"
	./scripts/install-limine.sh
endif

.PHONY: run
run:
	$(MAKE) -C gaia run ISO=../nyx.iso

.PHONY: menuconfig
menuconfig:
	$(MAKE) -C gaia menuconfig

.PHONY: clean
clean:
	$(MAKE) -C chadlibc clean
	$(MAKE) -C gaia clean
	$(MAKE) -C srv/olympus clean

.PHONY: get-limine
get-limine:
	git clone -b v4.x-branch-binary https://github.com/limine-bootloader/limine
	$(MAKE) -C limine
	cp limine/limine.h gaia/src/
