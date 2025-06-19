#!/bin/sh

get_cro_assigned_clock_rates() {
	xxd -g4 -c4 -p /proc/device-tree/clock-controller@fdd20000/assigned-clock-rates
}

echo "*** Video ***"
echo -n "    CRO assigned clock rates:"
for freq in $(get_cro_assigned_clock_rates); do
	echo -n " $((0x${freq}))"
done
echo ""
cat /sys/kernel/debug/clk/clk_summary | grep -E 'vpll|dclk_vop1'
