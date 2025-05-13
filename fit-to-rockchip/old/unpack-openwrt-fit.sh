#!/bin/sh

FIT_IMG=../bins/linux_t1_leo.fit

#dumpimage -l ${FIT_IMG}
#exit 0

rm ./kernel.img*
#dumpimage -T flat_dt ${FIT_IMG} -p 0 -o kernel.img.lzma
#lzcat kernel.img.lzma > kernel.img
dumpimage -T flat_dt ${FIT_IMG} -p 0 -o kernel.img

dumpimage -T flat_dt ${FIT_IMG} -p 1 -o dtb.img

dtc -I dtb -O dts -o openwrt_linux_t1-XXL.dts ../bins/linux_t1.fit
