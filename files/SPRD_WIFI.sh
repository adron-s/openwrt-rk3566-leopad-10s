#!/bin/sh

ACTION=${1:-nc}
DEV_HOST=172.29.0.19
MODULES_DIR=/lib/modules/6.6.87

[ "${ACTION}" = "nc" ] && {
	nc ${DEV_HOST} 1111 > ${MODULES_DIR}/sprdwl_ng_tmp.ko || exit 10

	cat ${MODULES_DIR}/sprdwl_ng_tmp.ko > ${MODULES_DIR}/sprdwl_ng.ko
	rm ${MODULES_DIR}/sprdwl_ng_tmp.ko

	sync
}

lsmod | grep sprdwl_ng > /dev/null && {
	wifi down
	rmmod sprdwl_ng || exit 70
}

insmod  ${MODULES_DIR}/cfg80211.ko
insmod  ${MODULES_DIR}/sprdwl_ng.ko
