#!/bin/sh
rm -rf -- boot/sysroot
./jinx sysroot
mv sysroot boot
cd boot/sysroot
cp -r ../../base-files/* .
tar -cf ../boot/ramdisk.tar *
cd ..
