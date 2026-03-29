#!/bin/bash
# Minimal setup -- just update package lists
apt-get update -qq > /dev/null 2>&1
apt-get install -y -qq curl > /dev/null 2>&1
mkdir -p /home/user
