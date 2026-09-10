#!/bin/bash
apt show htop > /tmp/kd-pkg/htop-metadata.txt
apt-cache depends htop > /tmp/kd-pkg/htop-depends.txt
cat /tmp/kd-pkg/htop-metadata.txt
cat /tmp/kd-pkg/htop-depends.txt
