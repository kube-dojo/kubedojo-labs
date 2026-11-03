#!/bin/bash
# Leave only requirement which-output unmet after replaying the earlier steps.
set -e
sudo apt remove -y wget
rm -f ~/wget-check.txt
