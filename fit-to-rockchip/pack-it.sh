#!/bin/sh

VARIANT=${1:-legacy}
BINS_DIR=./bins
WORK_DIR=$(dirname ${0})
RESOURCE_DIR=${BINS_DIR}/resource_tmp
RESOURCE_IMG=${BINS_DIR}/resource.img
RESULT_FILE=${BINS_DIR}/openwrt_new_fit.img
KERNEL_FILE=Image-initramfs # ARM64 image
DTB_FILE_GEN=image-rk3566-rockchip-generic.dtb
DTB_FILE_LEO=image-rk3566-leopad-10s.dtb
DTB_FILE=${DTB_FILE_LEO}
#DTB_FILE=${DTB_FILE_GEN}
OPENWRT_DIR=/home/adron/rockchip/openwrt
OPENWRT_KERNEL_BUILD_DIR=${OPENWRT_DIR}/build_dir/target-aarch64_generic_musl/linux-rockchip_armv8
OPENWRT_KERNEL_DIR=${OPENWRT_KERNEL_BUILD_DIR}/linux-6.6.87
OPENWRT_KERNEL_VZLINUX=${OPENWRT_KERNEL_DIR}/vmlinux
OPENWRT_ARM64_KERNEL_IMG=${OPENWRT_KERNEL_BUILD_DIR}/${KERNEL_FILE}

cd ${WORK_DIR}
pwd

rm -Rf ${BINS_DIR}
mkdir ${BINS_DIR}
rm -Rf ${RESOURCE_DIR}
mkdir ${RESOURCE_DIR}

if [ "${VARIANT}" = "vmlinux" ]; then
	echo "Doing vmlinux (ELF) to ARM64 Image repack!"
	aarch64-linux-gnu-objcopy -O binary -R .note -R .comment -S \
		${OPENWRT_KERNEL_VZLINUX} ${OPENWRT_ARM64_KERNEL_IMG}
fi

ls -l ${OPENWRT_ARM64_KERNEL_IMG}

cat ${OPENWRT_ARM64_KERNEL_IMG} > ${BINS_DIR}/kernel.img
cat ${OPENWRT_KERNEL_BUILD_DIR}/${DTB_FILE} > ${BINS_DIR}/dtb.img
cat ${BINS_DIR}/dtb.img > ${RESOURCE_DIR}/rk-kernel.dtb

./resource_tool --pack --dtbname --root=${RESOURCE_DIR} --image=${RESOURCE_IMG} $(find ${RESOURCE_DIR} -type f|sort)
#./mkimage -E -p 0x1000 -f fit8-1.its ${RESULT_FILE} # работает и так
./mkimage -E -p 0x800 -f fit8-1.its ${RESULT_FILE} # и вот так (у IF-023D именно так).

dtc -I dtb -O dts -o ${BINS_DIR}/openwrt_new_fit-XXL.dts ${RESULT_FILE} 2>/dev/null
dtc -I dtb -O dts -o ${BINS_DIR}/openwrt_kernel_fdt-XXL.dts ${BINS_DIR}/dtb.img 2>/dev/null

echo ""
echo "The result (FIT image) file is: ${RESULT_FILE}"
