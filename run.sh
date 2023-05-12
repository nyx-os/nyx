#!/bin/sh
ARCH="x86_64"
MEMORY="2G"
cmd="qemu-system-${ARCH} -enable-kvm -m ${MEMORY} -cdrom nyx.iso -debugcon stdio -cpu host -no-shutdown -no-reboot"

./make-ramdisk.sh
./install-limine.sh

$cmd
