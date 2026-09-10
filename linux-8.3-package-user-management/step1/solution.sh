#!/bin/bash
# Solution: Install and hold nginx
sudo apt-get install -y -qq nginx > /dev/null 2>&1
sudo apt-mark hold nginx
echo "Held packages:"
sudo apt-mark showhold
