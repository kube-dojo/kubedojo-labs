#!/bin/bash
# Solution: Set ACL for www-data
setfacl -m u:www-data:r /root/shared.txt
getfacl /root/shared.txt
