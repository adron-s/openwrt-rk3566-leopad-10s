#!/bin/sh

#RESULT_DIR=/home/adron/rockchip/openwrt/bin/targets/rockchip/armv8
#RESULT_FILE=openwrt-rockchip-armv8-helix_rockchip-generic-initramfs-kernel.bin
RESULT_DIR=/home/adron/rockchip/openwrt/build_dir/target-aarch64_generic_musl/linux-rockchip_armv8
#RESULT_FILE=helix_rockchip-generic-kernel.bin # FIT image!
RESULT_FILE=Image-initramfs # ARM64 image
RESULT_FILE2=image-rk3566-rockchip-generic.dtb # DTB

SMB_DIR=/mnt/floppy/backups/embedded/tftpboot
RESULT_SIZE=$(du -b ${RESULT_DIR}/${RESULT_FILE} | awk '{print $1}')

cat ${RESULT_DIR}/${RESULT_FILE} | pv -s ${RESULT_SIZE} > ${SMB_DIR}/linux_t1.bin
cat ${RESULT_DIR}/${RESULT_FILE2} | pv -s ${RESULT_SIZE} > ${SMB_DIR}/linux_t1.dtb
cat ${RESULT_DIR}/${RESULT_FILE} ${RESULT_DIR}/${RESULT_FILE2} | pv -s ${RESULT_SIZE} > ${SMB_DIR}/linux_t1.dtb-tail.bin
