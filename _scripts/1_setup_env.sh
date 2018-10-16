#!/bin/bash

echo "Please run as: . 1_setup_env.sh"
echo "Setting up env..."

set +h
umask 022
export GMOS=/mnt/gmos/gmos
export LC_ALL=POSIX
export PATH=${GMOS}/cross-tools/bin:/bin:/usr/bin
unset CFLAGS
unset CXXFLAGS
export GMOS_HOST=$(echo ${MACHTYPE} | sed "s/-[^-]*/-cross/")
export GMOS_TARGET=x86_64-unknown-linux-gnu
export GMOS_CPU=k8
export GMOS_ARCH=$(echo ${GMOS_TARGET} | sed -e 's/-.*//' -e 's/i.86/i386/')
export GMOS_ENDIAN=little

# Run these lines when cross compiler is setup
#export CC="${GMOS_TARGET}-gcc"
#export CXX="${GMOS_TARGET}-g++"
#export CPP="${GMOS_TARGET}-gcc -E"
#export AR="${GMOS_TARGET}-ar"
#export AS="${GMOS_TARGET}-as"
#export LD="${GMOS_TARGET}-ld"
#export RANLIB="${GMOS_TARGET}-ranlib"
#export READELF="${GMOS_TARGET}-readelf"
#export STRIP="${GMOS_TARGET}-strip"
