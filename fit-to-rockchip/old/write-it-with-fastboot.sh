#!/bin/sh

fastboot erase backup
fastboot flash backup ./openwrt_new_fit.img
fastboot reboot
# Yes, really - 2 times!
fastboot reboot
