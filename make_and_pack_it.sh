#!/bin/sh

ACTION=${1:-nc}

[ "${ACTION}" = "full" ] && {
	make -j32 || exit $?
	ACTION="nc"
}

[ "${ACTION}" = "kernel" ] && {
	#make target/linux/compile -j32 V=s || exit $?
	sh ./openwrt_cur_kernel_compile.sh || exit $?
	ACTION="nc"
}

./manual_compile_dts.sh && \
	./fit-to-rockchip/pack-it.sh ${ACTION}
