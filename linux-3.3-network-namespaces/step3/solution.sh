#!/bin/bash
# Configure host side
ip addr add 10.200.1.1/24 dev veth0
ip link set veth0 up

# Configure namespace side
ip netns exec lab-ns ip addr add 10.200.1.2/24 dev veth1
ip netns exec lab-ns ip link set veth1 up
ip netns exec lab-ns ip link set lo up
