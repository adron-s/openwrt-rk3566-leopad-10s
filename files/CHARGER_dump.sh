#!/bin/sh

cat /sys/class/power_supply/bq25700-charger/uevent
echo ""
cat /sys/class/power_supply/bq25700-battery/uevent
