#!/bin/sh

get_bat_cap() {
	cat /sys/class/power_supply/bq25700-battery/capacity
}

get_bat_volt() {
	cat /sys/class/power_supply/bq25700-battery/voltage_avg
}

get_bat_cur() {
	cat /sys/class/power_supply/bq25700-battery/current_avg
}

while true; do
	echo "$(get_bat_volt) - $(get_bat_cur) - $(get_bat_cap) - $(date)"
	#echo "********************************************************"
	sleep $((60*3))
done
