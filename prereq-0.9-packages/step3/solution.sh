#!/bin/bash
sudo apt install -y tree
tree ~/kubedojo-practice > /tmp/kd-pkg/tree-output.txt
cat /tmp/kd-pkg/tree-output.txt
