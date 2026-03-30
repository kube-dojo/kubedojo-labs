#!/bin/bash
# Solution: Install and hold nginx
apt-get install -y -qq nginx > /dev/null 2>&1
apt-mark hold nginx
echo "Held packages:"
apt-mark showhold
