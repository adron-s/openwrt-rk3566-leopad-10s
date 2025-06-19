#!/bin/sh

NC_IP=172.29.0.19
. /get_new_fw_common.sh

[ "${NC_RESULT}" = "0" ] && {
	echo "Done. Reboot in 2 seconds!"
	sync
	sleep 2
	reboot
}
