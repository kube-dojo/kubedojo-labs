#!/bin/bash
# Setup for memory management lab
apt-get update -qq
apt-get install -y -qq procps > /dev/null 2>&1
echo "Setup complete."
