#!/usr/bin/bash

./make-ramdisk.sh
cp limine.cfg boot/boot/limine.cfg
cp build/subprojects/gaia/gaia.elf boot/boot/gaia.elf
ARCH="$ARCH" make run
