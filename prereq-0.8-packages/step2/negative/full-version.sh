#!/bin/bash
# Leave only requirement full-version unmet after replaying the earlier steps.
set -e
sudo apt install -y wget
echo "wget" > ~/wget-version.txt
