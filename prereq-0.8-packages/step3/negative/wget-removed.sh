#!/bin/bash
# Leave only requirement wget-removed unmet after replaying the earlier steps.
set -e
sudo apt install -y wget
: > ~/wget-check.txt
