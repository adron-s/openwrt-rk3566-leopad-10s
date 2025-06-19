#!/bin/sh

MODE=${1:-host}

echo "fcc00000.usb" | tee /sys/bus/platform/drivers/dwc3/unbind
sleep 2
echo "fcc00000.usb" | tee /sys/bus/platform/drivers/dwc3/bind
echo "${MODE}" > /sys/kernel/debug/usb/fcc00000.usb/mode
