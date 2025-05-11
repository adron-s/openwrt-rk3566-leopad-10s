#!/bin/sh

RESULT_DIFF=131-arm64-dts-rockchip-rk3566-add-helix-rockchips.patch
TARGET_WATCH_DIR=./b
ACTION=${1:-watch}

do_diff() {
	diff -rNu a b > ./${RESULT_DIFF}
	cat ./${RESULT_DIFF} > /home/adron/rockchip/openwrt/target/linux/rockchip/patches-6.6/${RESULT_DIFF}
}

if [ "${ACTION}" = "watch" ]; then
	while true; do
		do_diff
		echo "Waiting for changes on dir: ${TARGET_WATCH_DIR}"
		inotifywait -q -e modify ${TARGET_WATCH_DIR} -r
	done
else
	do_diff
fi
