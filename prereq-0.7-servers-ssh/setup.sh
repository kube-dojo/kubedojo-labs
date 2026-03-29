#!/bin/bash
# Install openssh-server and nginx, create test data file
apt-get update -qq > /dev/null 2>&1
apt-get install -y openssh-server nginx -qq > /dev/null 2>&1

# Create the home directory
mkdir -p /home/user

# Create a file with known content for integrity verification
echo -n "kubedojo-integrity-test" > /home/user/important-data.bin
