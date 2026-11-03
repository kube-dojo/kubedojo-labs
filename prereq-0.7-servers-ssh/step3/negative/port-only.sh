#!/bin/bash
# Leave only requirement port-only unmet after replaying the earlier steps.
set -e
echo "port=22" > ~/ssh-port.txt
