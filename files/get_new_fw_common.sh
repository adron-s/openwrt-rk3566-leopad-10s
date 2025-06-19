#!/bin/sh

NC_RESULT=99
PART_NAME=${1:-"recovery"}
FW_FILE=/tmp/fw.bin

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

nc ${NC_IP} 1111 > ${FW_FILE} && {
	FW_SIZE=$(du -b ${FW_FILE} | awk '{print $1}')
	FW_MD5=$(md5sum ${FW_FILE} | awk '{print $1}')

	cat ${FW_FILE} > ${FW_PART} && {
		PART_MD5=$(dd if=${FW_PART} bs=${FW_SIZE} count=1 2>/dev/null | md5sum | awk '{print $1}')

		if [ "${PART_MD5}" != "${FW_MD5}" ]; then
			echo "Warning! MD5 mismatch detected. Please run this script again!"
			echo "  FW MD5: ${FW_MD5}"
			echo "PART MD5: ${PART_MD5}"
			dd if=/dev/zero of=${FW_PART} bs=1M count=100 2>/dev/null
			NC_RESULT=55
		else
			NC_RESULT=0
		fi
	}
}

rm -f ${FW_FILE}
