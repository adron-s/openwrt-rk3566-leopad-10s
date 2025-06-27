#!/bin/sh

DTB_FILE_LEO=image-rk3566-leopad-10s.dtb
KERNEL_FILE=Image-initramfs # ARM64 image
OPENWRT_DIR=/home/adron/rockchip/openwrt
OPENWRT_KERNEL_BUILD_DIR=${OPENWRT_DIR}/build_dir/target-aarch64_generic_musl/linux-rockchip_armv8
OPENWRT_KERNEL_DIR=${OPENWRT_KERNEL_BUILD_DIR}/linux-6.6.87
OPENWRT_KERNEL_VZLINUX=${OPENWRT_KERNEL_DIR}/vmlinux
OPENWRT_ARM64_KERNEL_IMG=${OPENWRT_KERNEL_BUILD_DIR}/${KERNEL_FILE}
OPENWRT_KERNEL_DTB_DIR=${OPENWRT_KERNEL_DIR}/arch/arm64/boot/dts/rockchip
TARGET_MODULE1=${OPENWRT_KERNEL_DIR}/drivers/net/wireless/uwe5622/unisocwifi/sprdwl_ng.ko

rm -f ${TARGET_MODULE1}
make target/linux/compile -j32 V=s || exit 10
[ -f ${TARGET_MODULE1} ] && {
	echo "Doing NC for $(basename ${TARGET_MODULE1})"
	cat ${TARGET_MODULE1} | nc -l -p 1111 -q 1
}
