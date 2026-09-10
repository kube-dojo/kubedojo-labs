#!/bin/bash
sudo apt install -y htop
htop --version > /tmp/kd-pkg/htop-version.txt
cat /tmp/kd-pkg/htop-version.txt
