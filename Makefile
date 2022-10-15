.DEFAULT_GOAL: all

ifeq (,$(wildcard ./limine))
.PHONY: all
all:
	@echo "Looks like limine is not cloned locally. Limine is the recommended bootloader for Nyx."
	@echo "Run 'make get-limine' to clone the limine binaries."
	@exit 1
endif

ifeq (,$(wildcard ./gaia/.config))
.PHONY: all
all:
	@echo "Looks like Gaia is not configured."
	@echo "Run 'make menuconfig' to configure it." 
	@exit 1
endif


.PHONY: all
all:
	$(MAKE) -C gaia
	$(MAKE) -C srv/olympus
	cp gaia/build/kernel.elf srv/olympus/build/*.elf boot
	./scripts/install-limine.sh


.PHONY: run
run:
	$(MAKE) -C gaia run ISO=../nyx.iso

.PHONY: menuconfig
menuconfig:
	$(MAKE) -C gaia menuconfig

.PHONY: get-limine
get-limine:
	git clone -b v4.x-branch-binary https://github.com/limine-bootloader/limine
	$(MAKE) -C limine
	cp limine/limine.h gaia/src/
