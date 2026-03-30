#!/bin/bash
# Setup script for seccomp lab

apt-get update -qq
apt-get install -y -qq jq > /dev/null 2>&1

echo "Setup complete."
