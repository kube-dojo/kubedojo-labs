#!/bin/bash
# Setup script for Kernel Security Hardening lab

apt-get update -qq
apt-get install -y -qq procps kmod > /dev/null 2>&1

# Ensure sysctl.d directory exists
mkdir -p /etc/sysctl.d
mkdir -p /etc/modprobe.d

echo "Setup complete."
