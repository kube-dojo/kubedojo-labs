#!/bin/bash
# Solution: Create virtual interface
ip link add dummy0 type dummy 2>/dev/null || true
ip link set dummy0 up
ip addr add 10.10.10.1/24 dev dummy0 2>/dev/null || true
ip addr show dummy0
