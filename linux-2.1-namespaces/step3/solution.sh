#!/bin/bash
sudo ip netns add lab-net
sudo ip -n lab-net link set lo up
sudo ip -n lab-net -brief address show lo
