#!/bin/bash
# Leave only requirement nginx-running unmet after replaying the earlier steps.
set -e
sudo service nginx stop
ss -tlnp > ~/ports.txt
