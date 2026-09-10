#!/bin/bash
sudo iptables -L -v -n > "$HOME"/iptables-rules.txt
