#!/bin/sh

# A script for quickly recompiling dtb without having to rebuild the entire kernel.

OPENWRT_DIR=/home/adron/rockchip/openwrt

export PATH="${OPENWRT_DIR}/staging_dir/toolchain-aarch64_generic_gcc-14.2.0_musl/bin:${PATH}"
OPENWRT_BUILD_DIR=${OPENWRT_DIR}/build_dir/target-aarch64_generic_musl/linux-rockchip_armv8
OPENWRT_KERNEL_DIR=${OPENWRT_DIR}/build_dir/target-aarch64_generic_musl/linux-rockchip_armv8/linux-6.6.87
KERNEL_DTS_DIR=${OPENWRT_KERNEL_DIR}/arch/arm64/boot/dts/rockchip
PATCH_DTS_DIR=${OPENWRT_DIR}/target/linux/rockchip/my-rk3566/b/arch/arm64/boot/dts/rockchip

#DTB_PREFIX=image-rk3566-rockchip-generic
#DTB_PREFIX=image-rk3566-leopad-10s
DTB_PREFIX=image-rk3568-k3-arj10x

DTB_FILE="${DTB_PREFIX}.dtb"
KERNEL_DTB_PREFIX=$(echo "${DTB_PREFIX}" | sed 's/image-//')
KERNEL_DTB_FILE="${KERNEL_DTB_PREFIX}.dtb"
KERNEL_DTS_FILE="${KERNEL_DTB_PREFIX}.dts"

rm -f ${OPENWRT_BUILD_DIR}/${DTB_FILE}
rm -f ${KERNEL_DTS_DIR}/${KERNEL_DTB_FILE}
cat ${PATCH_DTS_DIR}/${KERNEL_DTS_FILE} > ${KERNEL_DTS_DIR}/${KERNEL_DTS_FILE}

[ "${1}" = "do-not-compile" ] && {
	echo "The new dts is copied to the kernel dir:\n  ${KERNEL_DTS_DIR}/${KERNEL_DTS_FILE}"
	exit 0
}

# I just made a mistake in the dts file and copied the last command that OpenWrt ran to build the kernel.
make -C ${OPENWRT_KERNEL_DIR} \
	KCFLAGS="-fmacro-prefix-map=${OPENWRT_DIR}/build_dir/target-aarch64_generic_musl=target-aarch64_generic_musl -fno-caller-saves " \
	HOSTCFLAGS="-O2 -I${OPENWRT_DIR}/staging_dir/host/include  -Wall -Wmissing-prototypes -Wstrict-prototypes" \
	CROSS_COMPILE="aarch64-openwrt-linux-musl-" ARCH="arm64" KBUILD_HAVE_NLS=no KBUILD_BUILD_USER="" KBUILD_BUILD_HOST="" \
	KBUILD_BUILD_TIMESTAMP="Tue May 13 05:45:30 2025" KBUILD_BUILD_VERSION="0" KBUILD_HOSTLDFLAGS="-L${OPENWRT_DIR}/staging_dir/host/lib" \
	CONFIG_SHELL="bash" V=''  cmd_syscalls=  CC="aarch64-openwrt-linux-musl-gcc" KERNELRELEASE=6.6.87 dtbs && {

	cat ${KERNEL_DTS_DIR}/${KERNEL_DTB_FILE} > ${OPENWRT_BUILD_DIR}/${DTB_FILE}
	echo ""
	echo "The compilation of DTS file to ${DTB_FILE} is done."
	exit 0
}

exit 78
