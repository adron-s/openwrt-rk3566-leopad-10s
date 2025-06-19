#!/bin/sh

#RESULT_DIR3=/home/adron/rockchip/openwrt/bin/targets/rockchip/armv8
#RESULT_FILE3_LEO=openwrt-rockchip-armv8-adreamer_leopad-10s-initramfs-kernel.bin
#RESULT_FILE=openwrt-rockchip-armv8-helix_rockchip-generic-initramfs-kernel.bin
RESULT_DIR3=./fit-to-rockchip/bins
RESULT_FILE3_LEO=openwrt_new_fit.img

cat ${RESULT_DIR3}/${RESULT_FILE3_LEO} | nc -l -p 1111 -q 1
