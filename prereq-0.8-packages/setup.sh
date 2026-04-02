#!/bin/bash
if id "ubuntu" &>/dev/null; then
  TARGET_USER="ubuntu"
  USER_HOME="/home/ubuntu"
else
  TARGET_USER="root"
  USER_HOME="/root"
fi
apt-get update -qq > /dev/null 2>&1
apt-get install -y -qq curl > /dev/null 2>&1
mkdir -p "$USER_HOME"
chown -R $TARGET_USER:$TARGET_USER "$USER_HOME"
