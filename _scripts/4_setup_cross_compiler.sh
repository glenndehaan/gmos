#!/bin/bash

echo "Setup cross compiler..."

# Kernel Headers
cd ../_resources/linux-4.16.3
#make mrproper
#make ARCH=${GMOS_ARCH} headers_check && make ARCH=${GMOS_ARCH} INSTALL_HDR_PATH=dest headers_install
#cp -rv dest/include/* ${GMOS}/usr/include

# Binutils
#cd ..
#mkdir binutils-build
#cd binutils-build/
#../binutils-2.30/configure --prefix=${GMOS}/cross-tools --target=${GMOS_TARGET} --with-sysroot=${GMOS} --disable-nls --enable-shared --disable-multilib
#make configure-host && make
#ln -sv lib ${GMOS}/cross-tools/lib64
#make install
#cp -v ../binutils-2.30/include/libiberty.h ${GMOS}/usr/include

# GCC (Static)
#cd ..
#mv gmp-6.1.2 gcc-7.3.0/gmp
#mv mpfr-4.0.1 gcc-7.3.0/mpfr
#mv mpc-1.1.0 gcc-7.3.0/mpc
#mkdir gcc-static
#cd gcc-static/
#AR=ar LDFLAGS="-Wl,-rpath,${GMOS}/cross-tools/lib" ../gcc-7.3.0/configure --prefix=${GMOS}/cross-tools --build=${GMOS_HOST} --host=${GMOS_HOST} --target=${GMOS_TARGET} --with-sysroot=${GMOS}/target --disable-nls --disable-shared --with-mpfr-include=$(pwd)/../gcc-7.3.0/mpfr/src --with-mpfr-lib=$(pwd)/mpfr/src/.libs --without-headers --with-newlib --disable-decimal-float --disable-libgomp --disable-libmudflap --disable-libssp --disable-threads --enable-languages=c,c++ --disable-multilib --with-arch=${GMOS_CPU}
#make all-gcc all-target-libgcc && make install-gcc install-target-libgcc
#ln -vs libgcc.a `${GMOS_TARGET}-gcc -print-libgcc-file-name | sed 's/libgcc/&_eh/'`

# Glibc
#cd ..
#mkdir glibc-build
#cd glibc-build/
#echo "libc_cv_forced_unwind=yes" > config.cache
#echo "libc_cv_c_cleanup=yes" >> config.cache
#echo "libc_cv_ssp=no" >> config.cache
#echo "libc_cv_ssp_strong=no" >> config.cache
#BUILD_CC="gcc" CC="${GMOS_TARGET}-gcc" AR="${GMOS_TARGET}-ar" RANLIB="${GMOS_TARGET}-ranlib" CFLAGS="-O2" ../glibc-2.27/configure --prefix=/usr --host=${GMOS_TARGET} --build=${GMOS_HOST} --disable-profile --enable-add-ons --with-tls --enable-kernel=2.6.32 --with-__thread --with-binutils=${GMOS}/cross-tools/bin --with-headers=${GMOS}/usr/include --cache-file=config.cache
#make && make install_root=${GMOS}/ install

# GCC (Final)
cd ..
mkdir gcc-build
cd gcc-build/
AR=ar LDFLAGS="-Wl,-rpath,${GMOS}/cross-tools/lib" ../gcc-7.3.0/configure --prefix=${GMOS}/cross-tools --build=${GMOS_HOST} --target=${GMOS_TARGET} --host=${GMOS_HOST} --with-sysroot=${GMOS} --disable-nls --enable-shared --enable-languages=c,c++ --enable-c99 --enable-long-long --with-mpfr-include=$(pwd)/../gcc-7.3.0/mpfr/src --with-mpfr-lib=$(pwd)/mpfr/src/.libs --disable-multilib --with-arch=${GMOS_CPU}
make && make install
cp -v ${GMOS}/cross-tools/${GMOS_TARGET}/lib64/libgcc_s.so.1 ${GMOS}/lib64
