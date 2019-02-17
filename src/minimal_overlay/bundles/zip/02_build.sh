#!/bin/sh

set -e

. ../../common.sh

cd $WORK_DIR/overlay/$BUNDLE_NAME

# Change to the zip source directory which ls finds, e.g. 'zip30'.
cd $(ls -d zip*)
#cd unix

if [ -f Makefile ] ; then
  echo "Preparing '$BUNDLE_NAME' work area. This may take a while."
  make -j $NUM_JOBS clean
else
  echo "The clean phase for '$BUNDLE_NAME' has been skipped."
fi

rm -rf $DEST_DIR

#chmod 755 configure

#echo "Configuring '$BUNDLE_NAME'."
#CFLAGS="$CFLAGS" ./configure \
#    --prefix=/usr \
#    LDFLAGS=-L$DEST_DIR/usr/include

#cd ..

echo "Building '$BUNDLE_NAME'."
make -j $NUM_JOBS -f unix/Makefile generic_gcc

echo "Installing '$BUNDLE_NAME'."
make -j $NUM_JOBS -f unix/Makefile install DESTDIR=$DEST_DIR

echo "Reducing '$BUNDLE_NAME' size."
set +e
strip -g $DEST_DIR/usr/bin/*
set -e

# With '--remove-destination' all possibly existing soft links in
# '$OVERLAY_ROOTFS' will be overwritten correctly.
cp -r --remove-destination $DEST_DIR/* \
  $OVERLAY_ROOTFS

echo "Bundle '$BUNDLE_NAME' has been installed."

cd $SRC_DIR
