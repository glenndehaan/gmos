#!/bin/sh

set -e

. ../../common.sh

echo "Preparing 'Cron' work area. This may take a while."

rm -rf $DEST_DIR

mkdir -p $OVERLAY_ROOTFS/var/spool/cron/crontabs

mkdir -p "$OVERLAY_ROOTFS/etc/autorun"
install -m 0755 "$SRC_DIR/10_crond.sh" "$OVERLAY_ROOTFS/etc/autorun/"

echo "Bundle 'Cron' has been installed."

cd $SRC_DIR
