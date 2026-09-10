#!/bin/bash
# Solution: Set ACL for www-data
setfacl -m u:www-data:r "$HOME"/shared.txt
getfacl "$HOME"/shared.txt
