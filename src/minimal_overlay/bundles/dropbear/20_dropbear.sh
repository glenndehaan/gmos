#!/bin/sh

dropbear -p 0.0.0.0:22

cat << CEOF
[1m  Dropbear SSH server has been started.[0m
CEOF
