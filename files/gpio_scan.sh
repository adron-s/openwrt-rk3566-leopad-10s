#!/bin/sh

START=${1}
END=${2:-${1}}
VALUE=${3:-0}

[ -z "${START}" ] && {
	echo -e "Usage example:\n  \$ SKIP_REG=true SCAN_DELAY=1 /gpio_scan.sh 96 127 1\n"
	cat /sys/kernel/debug/gpio
	exit 0
}

for N in $(seq ${START} ${END}); do
	echo "Processing GPIO-${N}"
	[ "${SKIP_REG}" != "true" ] && {
		echo ${N} > /sys/class/gpio/export
		echo out > /sys/class/gpio/gpio${N}/direction
	}
	echo ${VALUE} > /sys/class/gpio/gpio${N}/value
	[ -n "${SCAN_DELAY}" ] && sleep "${SCAN_DELAY}"

done
