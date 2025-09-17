#!/bin/sh

parec --device=rk_809_in | pacat --device=$(pactl get-default-sink)
