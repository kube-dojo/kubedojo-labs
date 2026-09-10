#!/bin/bash
# Solution: Create shared project directory
sudo mkdir -p /opt/project
sudo chown developer:devteam /opt/project
sudo chmod 2770 /opt/project
stat /opt/project
