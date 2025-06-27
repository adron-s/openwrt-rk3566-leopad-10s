#!/bin/sh

WORK_DIR=$(dirname $(readlink -f "$0"))
cd ${WORK_DIR}

[ "${1}" = "re" ] && {
	./manual_compile_dts.sh "do-not-compile"
	./rebuild_the_kernel.sh || exit 10
	./fit-to-rockchip/pack-it.sh && ./nc_linux_t1_leo_fit.sh
	exit 0
}

[ "${1}" = "nodt" ] && {
	./fit-to-rockchip/pack-it.sh && ./nc_linux_t1_leo_fit.sh
	exit 0
}

./make_and_pack_it.sh && ./nc_linux_t1_leo_fit.sh
