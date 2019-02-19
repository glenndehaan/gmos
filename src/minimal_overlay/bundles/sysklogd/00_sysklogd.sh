#!/bin/sh

syslogd -n &

cat << CEOF
[1m  Syslogd Started.[0m
CEOF
