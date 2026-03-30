#!/bin/bash
# Setup for I/O performance lab
apt-get update -qq
apt-get install -y -qq sysstat > /dev/null 2>&1
echo "Setup complete."
