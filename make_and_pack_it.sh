#!/bin/sh

#make -j32 && \
./manual_compile_dts.sh && \
	./fit-to-rockchip/pack-it.sh
