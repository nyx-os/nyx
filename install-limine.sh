#!/bin/sh

cp -r $(find build -name '*.elf') boot/boot
make -C limine
rm -rf iso_root
mkdir -p iso_root
cp -r boot/boot/* \
	limine/limine-bios.sys limine/limine-bios-cd.bin limine/limine-uefi-cd.bin iso_root/
xorriso -as mkisofs -b limine-bios-cd.bin \
		-no-emul-boot -boot-load-size 4 -boot-info-table \
		--efi-boot limine-uefi-cd.bin \
		-efi-boot-part --efi-boot-image --protective-msdos-label \
		iso_root -o nyx.iso
	limine/limine-deploy nyx.iso
	rm -rf iso_root
