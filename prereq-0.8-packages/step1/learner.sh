#!/bin/bash
# text.md:2-3
# expect-exit: 0
sudo apt update
# expect-exit: 0
apt show curl > ~/curl-info.txt
