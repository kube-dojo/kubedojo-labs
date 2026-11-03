#!/bin/bash
# Leave only requirement server-typos unmet after replaying the earlier steps.
set -e
sed -i "s/listn/listen/g" ~/configs/nginx.conf
