#!/bin/bash
# Setup for CPU scheduling lab
apt-get update -qq
apt-get install -y -qq util-linux procps > /dev/null 2>&1
echo "Setup complete."
