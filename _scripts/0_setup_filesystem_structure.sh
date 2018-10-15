#!/bin/bash

echo "Creating filesystem..."

mkdir -pv ${GMOS}/{bin,boot/{,grub},dev,{etc/,}opt,home,lib/{firmware,modules},lib64,mnt}
mkdir -pv ${GMOS}/{proc,media/{floppy,cdrom},sbin,srv,sys}
mkdir -pv ${GMOS}/var/{lock,log,mail,run,spool}
mkdir -pv ${GMOS}/var/{opt,cache,lib/{misc,locate},local}
install -dv -m 0750 ${GMOS}/root
install -dv -m 1777 ${GMOS}{/var,}/tmp
install -dv ${GMOS}/etc/init.d
mkdir -pv ${GMOS}/usr/{,local/}{bin,include,lib{,64},sbin,src}
mkdir -pv ${GMOS}/usr/{,local/}share/{doc,info,locale,man}
mkdir -pv ${GMOS}/usr/{,local/}share/{misc,terminfo,zoneinfo}
mkdir -pv ${GMOS}/usr/{,local/}share/man/man{1,2,3,4,5,6,7,8}
for dir in ${GMOS}/usr{,/local}; do
  ln -sv share/{man,doc,info} ${dir}
done
install -dv ${GMOS}/cross-tools{,/bin}
