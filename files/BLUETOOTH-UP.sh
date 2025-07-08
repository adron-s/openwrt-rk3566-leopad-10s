#!/bin/sh

rfkill unblock bluetooth
hciattach -s 1500000 /dev/ttyBT0 sprd # она просто все проинитит и превратится в демона. в armbian его запускают как systemd сервис.
hciconfig hci0 up
