#!/bin/sh

MAC="33:10:35:A2:D1:3D"

echo "Connecting to mac ${MAC} ..."
bluetoothctl connect ${MAC}

#pactl set-card-profile 0 headset_head_unit
[ "${1}" = "99" ] && {
	pactl set-card-profile 0 handsfree_head_unit
}
