#!/bin/sh

# Use download command on uboot! This way is very convinient.

../rkdeveloptool wl 0x0008B000 ./openwrt_new_fit.img
../rkdeveloptool rd
