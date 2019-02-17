#!/bin/bash

mkdir /opt/gmos
cp -R /mnt/gmos/src/. /opt/gmos
cd /opt/gmos
./repackage.sh

cd /mnt/gmos
cp /opt/gmos/minimal_linux_live.iso /mnt/gmos/build
