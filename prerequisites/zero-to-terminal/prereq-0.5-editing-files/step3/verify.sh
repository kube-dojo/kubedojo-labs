#!/bin/bash
# Verify nginx.conf has correct values and no typos
[ -f /home/user/configs/nginx.conf ] || exit 1
grep -q "listen 80" /home/user/configs/nginx.conf || exit 1
grep -q "server_name" /home/user/configs/nginx.conf || exit 1
# Ensure typos are gone
grep -q "listn" /home/user/configs/nginx.conf && exit 1
grep -q "sever" /home/user/configs/nginx.conf && exit 1
exit 0
