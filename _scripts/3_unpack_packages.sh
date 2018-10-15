#!/bin/bash

echo "Unpack packages..."

cd ../_resources

tar xf binutils-2.30.tar.xz
tar xvjf busybox-1.28.3.tar.bz2
tar xvjf clfs-embedded-bootscripts-1.0-pre5.tar.bz2
tar xf gcc-7.3.0.tar.xz
tar xf glibc-2.27.tar.xz
tar xvjf gmp-6.1.2.tar.bz2
tar xf linux-4.16.3.tar.xz
tar xf mpc-1.1.0.tar.gz
tar xf mpfr-4.0.1.tar.xz
tar xf zlib-1.2.11.tar.gz
