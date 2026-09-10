#!/bin/bash
# Configure host side
sudo ip addr add 10.200.1.1/24 dev veth0
sudo ip link set veth0 up

# Configure namespace side
sudo ip netns exec lab-ns ip addr add 10.200.1.2/24 dev veth1
sudo ip netns exec lab-ns ip link set veth1 up
sudo ip netns exec lab-ns ip link set lo up
