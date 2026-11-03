#!/bin/bash
# Leave only requirement wget-installed unmet after replaying the earlier steps.
set -e
sudo apt install -y wget
wget --version > ~/wget-version.txt
sudo apt remove -y wget
