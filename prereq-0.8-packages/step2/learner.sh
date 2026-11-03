#!/bin/bash
# text.md:2-3
# expect-exit: 0
sudo apt install -y wget
# expect-exit: 0
wget --version > ~/wget-version.txt
