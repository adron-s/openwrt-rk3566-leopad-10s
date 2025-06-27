#!/bin/sh

NC_IP=172.29.0.19

lsmod | grep ax88179_178a >/dev/null || {
	insmod /lib/modules/6.6.87/usbnet.ko
	insmod /lib/modules/6.6.87/ax88179_178a.ko
}

for a in $(seq 1 30); do
	ping -w 1 ${NC_IP} && break
	sleep 1
done

. /get_new_fw_common.sh

[ "${NC_RESULT}" = "0" ] && {
	echo "Done. Reboot in 2 seconds!"
	sync
	sleep 2
	reboot
}
