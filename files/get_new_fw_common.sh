#!/bin/sh

PART_NAME=${1:-"recovery"}

get_boot_part() {
	blkid | grep -E "\"${PART_NAME}" | head -n 1 | sed 's/: .*//'
}

get_real_part_name() {
	blkid "${1}" | sed 's/.*PARTLABEL="//;s/" .*//'
}

FW_PART=$(get_boot_part)
if [ -n "${FW_PART}" ]; then
	PART_NAME=$(get_real_part_name ${FW_PART})
	echo "FW ${PART_NAME} partition is: ${FW_PART}"
#	exit 0
else
	echo "Can't find FW partition: ${PART_NAME}"
	exit 10
fi

#dd if=/dev/zero of=${FW_PART} bs=1M count=100
nc ${NC_IP} 1111 > ${FW_PART}
