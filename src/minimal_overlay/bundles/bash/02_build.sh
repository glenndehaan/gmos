#!/bin/sh

set -e

. ../../common.sh

cd $WORK_DIR/overlay/$BUNDLE_NAME

# Change to the bash source directory which ls finds, e.g. 'bash-2.8.7'.
cd $(ls -d bash-*)

if [ -f Makefile ] ; then
  echo "Preparing '$BUNDLE_NAME' work area. This may take a while."
  make -j $NUM_JOBS clean
else
  echo "The clean phase for '$BUNDLE_NAME' has been skipped."
fi

rm -rf $DEST_DIR

mkdir -p $DEST_DIR/bin
mkdir -p $DEST_DIR/etc

echo "Configuring '$BUNDLE_NAME'."
CFLAGS="$CFLAGS" ./configure \
    --prefix=/usr \
    --disable-unicode \
    LDFLAGS=-L$DEST_DIR/usr/include

echo "Building '$BUNDLE_NAME'."
make -j $NUM_JOBS

echo "Installing '$BUNDLE_NAME'."
make -j $NUM_JOBS install DESTDIR=$DEST_DIR

echo "Reducing '$BUNDLE_NAME' size."
set +e
strip -g $DEST_DIR/usr/bin/*
set -e

mv -vf $DEST_DIR/usr/bin/bash $DEST_DIR/bin

cat > $DEST_DIR/etc/shells << "EOF"
# List of acceptable shells for chpass(1).

/bin/bash
/bin/sh
EOF

# With '--remove-destination' all possibly existing soft links in
# '$OVERLAY_ROOTFS' will be overwritten correctly.
cp -r --remove-destination $DEST_DIR/* \
  $OVERLAY_ROOTFS

echo "Bundle '$BUNDLE_NAME' has been installed."

cd $SRC_DIR
