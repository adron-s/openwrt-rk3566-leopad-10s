#!/bin/sh

get_boot_part() {
	blkid | grep '\"boot' | head -n 1 | sed 's/: .*//'
}

BOOT_PART=$(get_boot_part)
echo "Boot partition is: ${BOOT_PART}"

#dd if=/dev/zero of=${BOOT_PART} bs=1M count=100
nc 172.20.1.77 1111 > ${BOOT_PART}
