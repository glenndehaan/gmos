#!/bin/sh

set -e

. ../../common.sh

cd $WORK_DIR/overlay/$BUNDLE_NAME

# Change to the sysklogd source directory which ls finds, e.g. 'sysklogd-2016.73'.
cd $(ls -d sysklogd-*)

if [ -f Makefile ] ; then
  echo "Preparing 'sysklogd' work area. This may take a while."
  make -j $NUM_JOBS clean
else
  echo "The clean phase for 'sysklogd' has been skipped."
fi

rm -rf $DEST_DIR

mkdir $DEST_DIR
mkdir $DEST_DIR/etc
mkdir $DEST_DIR/sbin
mkdir -p $DEST_DIR/usr/sbin

# Manual fixes
sed -i '/Error loading kernel symbols/{n;n;d}' ksym_mod.c
sed -i 's/union wait/int/' syslogd.c

echo "Building 'sysklogd'."
make -j $NUM_JOBS

echo "Installing 'sysklogd'."
make -j $NUM_JOBS install_exec prefix="$DEST_DIR"

cp -R $DEST_DIR/usr/sbin/* $DEST_DIR/sbin

echo "Reducing 'sysklogd' size."
set +e
strip -g $DEST_DIR/sbin/*
set -e

cat > $DEST_DIR/etc/syslog.conf << "EOF"
# Begin /etc/syslog.conf

auth,authpriv.* -/var/log/auth.log
*.*;auth,authpriv.none -/var/log/sys.log
daemon.* -/var/log/daemon.log
kern.* -/var/log/kern.log
mail.* -/var/log/mail.log
user.* -/var/log/user.log
*.emerg *

# End /etc/syslog.conf
EOF

# With '--remove-destination' all possibly existing soft links in
# '$OVERLAY_ROOTFS' will be overwritten correctly.
cp -r --remove-destination $DEST_DIR/etc \
  $OVERLAY_ROOTFS
cp -r --remove-destination $DEST_DIR/sbin \
  $OVERLAY_ROOTFS

mkdir -p "$OVERLAY_ROOTFS/etc/autorun"
install -m 0755 "$SRC_DIR/00_sysklogd.sh" "$OVERLAY_ROOTFS/etc/autorun/"

mkdir -p "$OVERLAY_ROOTFS/var/run"

echo "Bundle 'sysklogd' has been installed."

cd $SRC_DIR
