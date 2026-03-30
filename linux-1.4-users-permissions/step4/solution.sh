#!/bin/bash
# Solution: Create shared project directory
mkdir -p /opt/project
chown developer:devteam /opt/project
chmod 2770 /opt/project
stat /opt/project
