.PHONY: all
.DEFAULT_GOAL: all
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
