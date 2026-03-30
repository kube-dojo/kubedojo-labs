#!/bin/bash
# Setup for Users and Permissions lab

# Install sudo if not present
apt-get update -qq && apt-get install -y -qq sudo > /dev/null 2>&1

echo "Setup complete."
