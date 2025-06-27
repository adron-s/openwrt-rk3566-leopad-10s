#!/bin/sh

DTB_FILE_LEO=image-rk3566-leopad-10s.dtb
KERNEL_FILE=Image-initramfs # ARM64 image
OPENWRT_DIR=/home/adron/rockchip/openwrt
OPENWRT_KERNEL_BUILD_DIR=${OPENWRT_DIR}/build_dir/target-aarch64_generic_musl/linux-rockchip_armv8
OPENWRT_KERNEL_DIR=${OPENWRT_KERNEL_BUILD_DIR}/linux-6.6.87
OPENWRT_KERNEL_VZLINUX=${OPENWRT_KERNEL_DIR}/vmlinux
OPENWRT_ARM64_KERNEL_IMG=${OPENWRT_KERNEL_BUILD_DIR}/${KERNEL_FILE}
OPENWRT_KERNEL_DTB_DIR=${OPENWRT_KERNEL_DIR}/arch/arm64/boot/dts/rockchip
#OPENWRT_EXTRACTED_INITRAMFS=${OPENWRT_DIR}/fit-to-rockchip/dig-initramfs/_Image-initramfs.extracted/E7F19C.7z

#make target/linux/compile -j32 V=s || exit 10
#make target/linux/install -j32 V=s || exit 11
sh ${OPENWRT_DIR}/openwrt_cur_kernel_compile.sh

cut_image_head() {
	echo ${1} | sed 's/^image-//'
}

#echo "Doing vmlinux (ELF) to ARM64 Image repack!"
#rm -f ${OPENWRT_ARM64_KERNEL_IMG}

#aarch64-linux-gnu-readelf -S ${OPENWRT_KERNEL_VZLINUX}
#aarch64-linux-gnu-readelf -S ${OPENWRT_KERNEL_BUILD_DIR}/vmlinux-initramfs.elf > ${OPENWRT_KERNEL_BUILD_DIR}/vmlinux-initramfs.elf.txt
#aarch64-linux-gnu-readelf -S ${OPENWRT_KERNEL_BUILD_DIR}/vmlinux.elf > ${OPENWRT_KERNEL_BUILD_DIR}/vmlinux.elf.txt
#exit 0

#aarch64-linux-gnu-objcopy -O binary -R .note -R .comment -S \
#	--add-section .initramfs=${OPENWRT_EXTRACTED_INITRAMFS} \
#	${OPENWRT_KERNEL_VZLINUX} ${OPENWRT_ARM64_KERNEL_IMG} || exit 20

#ls -l ${OPENWRT_KERNEL_VZLINUX}
#ls -l ${OPENWRT_ARM64_KERNEL_IMG}
#binwalk ${OPENWRT_ARM64_KERNEL_IMG}

SRC_DTB_FILE=${OPENWRT_KERNEL_DTB_DIR}/$(cut_image_head ${DTB_FILE_LEO})
DST_DTB_FILE=${OPENWRT_KERNEL_BUILD_DIR}/${DTB_FILE_LEO}
ls -l ${SRC_DTB_FILE} || exit 30
cat ${SRC_DTB_FILE} > ${DST_DTB_FILE}
#vbindiff ${SRC_DTB_FILE} ${DST_DTB_FILE}
ls -l ${DST_DTB_FILE} || exit 40

#echo "Doing NC"
#cat ${OPENWRT_ARM64_KERNEL_IMG} | nc -l -p 1111 -q 1
