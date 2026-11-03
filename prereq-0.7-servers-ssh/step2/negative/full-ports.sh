#!/bin/bash
# Leave only requirement full-ports unmet after replaying the earlier steps.
set -e
sudo service nginx start
ss -tlnp | grep :80 > ~/ports.txt
