#!/bin/sh

OPENWRT_DIR=/home/adron/rockchip/openwrt
KERNEL_DIR=${OPENWRT_DIR}/build_dir/target-aarch64_generic_musl/linux-rockchip_armv8/linux-6.6.87/
KERNEL_VZLINUX=${KERNEL_DIR}/vmlinux
cp ${KERNEL_VZLINUX} ./
