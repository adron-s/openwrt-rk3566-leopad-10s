#!/bin/sh

mount -t auto /dev/mmcblk0p1 /mnt/ && {
	cd /mnt
	sh ./do_update.sh
	sync
	cd /
	umount /mnt
}
