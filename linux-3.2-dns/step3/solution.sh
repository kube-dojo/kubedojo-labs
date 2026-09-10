#!/bin/bash
grep "^nameserver" /etc/resolv.conf | awk '{print $2}' > "$HOME"/nameservers.txt
