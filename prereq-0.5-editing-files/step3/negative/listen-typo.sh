#!/bin/bash
# Leave only requirement listen-typo unmet after replaying the earlier steps.
set -e
sed -i "s/sever/server/g" ~/configs/nginx.conf
printf "    listn 81;\n" >> ~/configs/nginx.conf
sed -i "s/listn 80/listen 80/g" ~/configs/nginx.conf
