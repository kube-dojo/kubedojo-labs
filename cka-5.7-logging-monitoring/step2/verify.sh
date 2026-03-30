#!/bin/bash
# Verify: events.txt exists with content
[ -f /root/events.txt ] && [ -s /root/events.txt ] && exit 0 || exit 1
