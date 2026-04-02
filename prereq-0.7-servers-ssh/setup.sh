#!/bin/bash
if id "ubuntu" &>/dev/null; then
  TARGET_USER="ubuntu"
  USER_HOME="/home/ubuntu"
else
  TARGET_USER="root"
  USER_HOME="/root"
fi
apt-get update -qq > /dev/null 2>&1
apt-get install -y openssh-server nginx -qq > /dev/null 2>&1
mkdir -p "$USER_HOME"
echo -n "kubedojo-integrity-test" > "$USER_HOME/important-data.bin"
chown -R $TARGET_USER:$TARGET_USER "$USER_HOME/important-data.bin"
