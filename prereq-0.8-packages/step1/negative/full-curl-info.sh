#!/bin/bash
# Leave only requirement full-curl-info unmet after replaying the earlier steps.
set -e
sudo apt update
echo "Package: curl" > ~/curl-info.txt
