#!/bin/bash
# Solution: Add ll alias to ~/.bashrc
echo "alias ll='ls -la'" >> ~/.bashrc
# Non-interactive bash skips ~/.bashrc and does not expand aliases.
shopt -s expand_aliases
alias ll='ls -la'
ll
