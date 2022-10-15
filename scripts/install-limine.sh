#! /usr/bin/bash

rm -rf iso_root
mkdir -p iso_root
cp -r boot/* \
	limine/limine.sys limine/limine-cd.bin limine/limine-cd-efi.bin iso_root/
xorriso -as mkisofs -b limine-cd.bin \
		-no-emul-boot -boot-load-size 4 -boot-info-table \
		--efi-boot limine-cd-efi.bin \
		-efi-boot-part --efi-boot-image --protective-msdos-label \
		iso_root -o nyx.iso
	limine/limine-deploy nyx.iso
	rm -rf iso_root
