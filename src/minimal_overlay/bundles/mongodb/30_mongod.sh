#!/bin/sh

mongod --fork --logpath /var/log/mongodb/mongod.log --dbpath /usr/mongo/db --bind_ip 0.0.0.0

cat << CEOF
[1m  Mongod Started.[0m
CEOF
