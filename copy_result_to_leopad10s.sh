#!/bin/sh

HOST=7.70.117.249

RESULT_DIR3=/home/adron/rockchip/openwrt/bin/targets/rockchip/armv8
RESULT_FILE3=openwrt-rockchip-armv8-helix_rockchip-generic-initramfs-kernel.bin
RESULT_DIR=/home/adron/rockchip/openwrt/build_dir/target-aarch64_generic_musl/linux-rockchip_armv8
#RESULT_FILE=helix_rockchip-generic-kernel.bin # FIT image!
RESULT_FILE=Image-initramfs # ARM64 image
#RESULT_FILE2=image-rk3566-rockchip-generic.dtb # DTB
RESULT_FILE2=image-rk3566-leopad-10s.dtb # DTB

#SSH_OPTS="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
#SSH_OPTS="-i ssh_authorized_keys"
#scp -P 22 ${SSH_OPTS} ${RESULT_DIR}/${RESULT_FILE} root@${HOST}:/mnt/linux_t1.bin
echo "linux_t1.bin nc ready!"
cat ${RESULT_DIR}/${RESULT_FILE} | nc -l -p 1111 -q 1
#scp -P 22 ${SSH_OPTS} ${RESULT_DIR}/${RESULT_FILE2} root@${HOST}:/mnt/linux_t1.dtb
echo "linux_t1.dtb nc ready!"
cat ${RESULT_DIR}/${RESULT_FILE2} | nc -l -p 1111 -q 1
#sleep 5
#ssh -p 22 ${SSH_OPTS} -l root ${HOST} sudo reboot
echo "Done"
