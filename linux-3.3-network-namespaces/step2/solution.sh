#!/bin/bash
sudo ip link add veth0 type veth peer name veth1
sudo ip link set veth1 netns lab-ns
