#!/bin/sh

WORK_DIR=$(dirname $(readlink -f "$0"))
cd ${WORK_DIR}

./make_and_pack_it.sh && ./nc_linux_t1_leo_fit.sh
