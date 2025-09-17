#!/bin/sh

KERNEL_FILE=Image-initramfs # ARM64 image
OPENWRT_DIR=/home/adron/rockchip/openwrt
OPENWRT_STAGING_DIR=${OPENWRT_DIR}/staging_dir
OPENWRT_KERNEL_BUILD_DIR=${OPENWRT_DIR}/build_dir/target-aarch64_generic_musl/linux-rockchip_armv8
OPENWRT_KERNEL_DIR=${OPENWRT_KERNEL_BUILD_DIR}/linux-6.6.87
OPENWRT_KERNEL_VZLINUX=${OPENWRT_KERNEL_DIR}/vmlinux
OPENWRT_ARM64_KERNEL_IMG=${OPENWRT_KERNEL_BUILD_DIR}/${KERNEL_FILE}

export STAGING_DIR=${OPENWRT_STAGING_DIR}
export PATH="${OPENWRT_STAGING_DIR}/toolchain-aarch64_generic_gcc-14.2.0_musl/bin:${OPENWRT_STAGING_DIR}/host/bin:${PATH}"

get_config_initramfs_source() {
	cat ${OPENWRT_KERNEL_DIR}/.config | grep -E "^CONFIG_INITRAMFS_SOURCE=" | \
	sed 's/CONFIG_INITRAMFS_SOURCE=//g;s/"//g'
}

[ -z "$(get_config_initramfs_source)" ] && {
	echo "Please check CONFIG_INITRAMFS_SOURCE in ${OPENWRT_KERNEL_DIR}/.config"
	exit 20
}

echo "Compilling the current kernel with the current .config"

make -C ${OPENWRT_KERNEL_DIR} \
	KCFLAGS="-fmacro-prefix-map=${OPENWRT_DIR}/build_dir/target-aarch64_generic_musl=target-aarch64_generic_musl -fno-caller-saves " \
	HOSTCFLAGS="-O2 -I${OPENWRT_DIR}/staging_dir/host/include  -Wall -Wmissing-prototypes -Wstrict-prototypes" \
	CROSS_COMPILE="aarch64-openwrt-linux-musl-" ARCH="arm64" KBUILD_HAVE_NLS=no KBUILD_BUILD_USER="" \
	KBUILD_BUILD_HOST="" KBUILD_BUILD_TIMESTAMP="Fri Jun 20 14:24:38 2025" KBUILD_BUILD_VERSION="0" \
	KBUILD_HOSTLDFLAGS="-L${OPENWRT_DIR}/staging_dir/host/lib" CONFIG_SHELL="bash" V=2 \
	cmd_syscalls=  CC="aarch64-openwrt-linux-musl-gcc" KERNELRELEASE=6.6.87 Image dtbs || exit 50

#exit 0

#aarch64-openwrt-linux-musl-objcopy -O binary -R .reginfo -R .notes -R .note -R .comment -R .mdebug -R .note.gnu.build-id -S \
#	${OPENWRT_KERNEL_VZLINUX} \
#	${OPENWRT_KERNEL_BUILD_DIR}/vmlinux-initramfs

#aarch64-openwrt-linux-musl-objcopy -R .reginfo -R .notes -R .note -R .comment -R .mdebug -R .note.gnu.build-id -S \
#	${OPENWRT_KERNEL_VZLINUX} \
#	${OPENWRT_KERNEL_BUILD_DIR}/vmlinux-initramfs.elf

#cp -fpR ${OPENWRT_KERNEL_VZLINUX} \
#	${OPENWRT_KERNEL_BUILD_DIR}/vmlinux-initramfs.debug

cp -fpR ${OPENWRT_KERNEL_DIR}/arch/arm64/boot/Image \
	${OPENWRT_KERNEL_BUILD_DIR}/Image-initramfs
