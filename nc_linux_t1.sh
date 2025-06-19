#!/bin/sh

RESULT_DIR3=/home/adron/rockchip/openwrt/bin/targets/rockchip/armv8
RESULT_FILE3_GEN=openwrt-rockchip-armv8-helix_rockchip-generic-initramfs-kernel.bin
RESULT_FILE3_LEO=openwrt-rockchip-armv8-adreamer_leopad-10s-initramfs-kernel.bin
#RESULT_FILE=openwrt-rockchip-armv8-helix_rockchip-generic-initramfs-kernel.bin
RESULT_DIR=/home/adron/rockchip/openwrt/build_dir/target-aarch64_generic_musl/linux-rockchip_armv8
#RESULT_FILE=helix_rockchip-generic-kernel.bin # FIT image!
RESULT_FILE=Image-initramfs # ARM64 image
RESULT_FILE2=image-rk3566-rockchip-generic.dtb # DTB

DEST_DIR=./ttt
RESULT_SIZE=$(du -b ${RESULT_DIR}/${RESULT_FILE} | awk '{print $1}')

if [ "${1}" = "leo" ]; then
	cat ${RESULT_DIR3}/${RESULT_FILE3_LEO} | nc -l -p 1111 -q 1
else
	cat ${RESULT_DIR3}/${RESULT_FILE3_GEN} | nc -l -p 1111 -q 1
fi

