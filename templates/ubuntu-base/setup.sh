#!/bin/bash
# Setup script — runs before user starts
# Install common tools
apt-get update -qq && apt-get install -y -qq jq tree curl > /dev/null 2>&1
echo "Environment ready."
