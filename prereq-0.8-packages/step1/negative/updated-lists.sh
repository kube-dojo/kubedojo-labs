#!/bin/bash
# Leave only requirement updated-lists unmet after replaying the earlier steps.
set -e
sudo apt update
sudo rm -f /var/lib/apt/lists/*_Packages*
apt show curl > ~/curl-info.txt
