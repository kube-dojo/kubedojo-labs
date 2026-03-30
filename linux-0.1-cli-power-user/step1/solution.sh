#!/bin/bash
# Solution: Add ll alias to ~/.bashrc
echo "alias ll='ls -la'" >> ~/.bashrc
source ~/.bashrc
ll
