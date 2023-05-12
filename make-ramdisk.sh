#!/bin/sh
rm -rf -- boot/sysroot
mkdir -p boot/sysroot
./jinx sysroot
cd boot/sysroot
cp -r ../../base-files/* .
cp -r ../../sysroot/* .
tar -cf ../boot/ramdisk.tar *
cd ..
