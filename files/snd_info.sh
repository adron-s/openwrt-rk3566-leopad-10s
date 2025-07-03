#!/bin/sh

for item in /sys/kernel/debug/asoc/rk817_ext/dapm/*; do
	item_bn=$(basename "${item}")
	[ "${item_bn}" = "bias_level" ] && continue
	echo "*** DARM - ${item_bn} ***"
	cat "${item}"
done
