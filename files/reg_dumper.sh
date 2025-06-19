#!/bin/sh

RD=/sys/class/regulator
echo "Regulators dir: ${RD}"

for r in $(ls ${RD} | sort -V); do
	fn="${RD}/${r}/name"
	fs="${RD}/${r}/state"
	nu="${RD}/${r}/num_users"
	[ -f "${fn}" ] && {
		name=$(cat "${fn}")

		if [ -f "${fs}" ]; then
			state=" - $(cat ${fs})"
		else
			state=""
		fi

		if [ -f "${nu}" ]; then
			num_users=" - $(cat ${nu})"
		else
			num_users=""
		fi

		echo "$r - ${name}${state}${num_users}"
	}
done
