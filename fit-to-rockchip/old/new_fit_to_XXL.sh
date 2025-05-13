#dtc -I dtb -O dts -o YF-023D-stock-boot-XXL.dts ../../YF-023D/v6.0/dumps/mmcblk0p3-boot.bin
dtc -I dtb -O dts -o openwrt_new_fit-XXL.dts ./openwrt_new_fit.img
#dtc -I dtb -O dts -o openwrt_linux_t1-XXL.dts ../bins/linux_t1.fit
