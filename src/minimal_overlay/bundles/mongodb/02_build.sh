#!/bin/sh

set -e

. ../../common.sh

cd $WORK_DIR/overlay/$BUNDLE_NAME

# Change to the mongodb source directory which ls finds, e.g. 'mongodb-2.8.7'.
cd $(ls -d mongodb-*)
cd bin

rm -rf $DEST_DIR

mkdir -p $DEST_DIR/usr/bin
mkdir -p $DEST_DIR/usr/mongo/db
mkdir -p $DEST_DIR/lib
mkdir -p $DEST_DIR/var/log/mongodb

cp /lib/x86_64-linux-gnu/libgcc_s.so.1 $DEST_DIR/lib

cp bsondump $DEST_DIR/usr/bin
cp mongo $DEST_DIR/usr/bin
cp mongod $DEST_DIR/usr/bin
cp mongodump $DEST_DIR/usr/bin
cp mongoexport $DEST_DIR/usr/bin
cp mongofiles $DEST_DIR/usr/bin
cp mongoimport $DEST_DIR/usr/bin
cp mongoreplay $DEST_DIR/usr/bin
cp mongorestore $DEST_DIR/usr/bin
cp mongostat $DEST_DIR/usr/bin
cp mongotop $DEST_DIR/usr/bin

echo "Reducing '$BUNDLE_NAME' size."
set +e
strip -g $DEST_DIR/usr/bin/*
set -e

# With '--remove-destination' all possibly existing soft links in
# '$OVERLAY_ROOTFS' will be overwritten correctly.
cp -r --remove-destination $DEST_DIR/* \
  $OVERLAY_ROOTFS

mkdir -p "$OVERLAY_ROOTFS/etc/autorun"
install -m 0755 "$SRC_DIR/30_mongod.sh" "$OVERLAY_ROOTFS/etc/autorun/"

echo "Bundle '$BUNDLE_NAME' has been installed."

cd $SRC_DIR
