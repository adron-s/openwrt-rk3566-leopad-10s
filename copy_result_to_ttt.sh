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

cat ${RESULT_DIR}/${RESULT_FILE} | pv -s ${RESULT_SIZE} > ${DEST_DIR}/linux_t1.bin
cat ${RESULT_DIR}/${RESULT_FILE2} | pv -s ${RESULT_SIZE} > ${DEST_DIR}/linux_t1.dtb
#cat ${RESULT_DIR}/${RESULT_FILE} ${RESULT_DIR}/${RESULT_FILE2} | pv -s ${RESULT_SIZE} > ${DEST_DIR}/linux_t1.dtb-tail.bin
cat ${RESULT_DIR3}/${RESULT_FILE3_GEN} > ${DEST_DIR}/linux_t1.fit
cat ${RESULT_DIR3}/${RESULT_FILE3_LEO} > ${DEST_DIR}/linux_t1_leo.fit

tar -cv -C ./ttt . | nc -l -p 1111 -q 1
