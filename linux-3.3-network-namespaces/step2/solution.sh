#!/bin/bash
ip link add veth0 type veth peer name veth1
ip link set veth1 netns lab-ns
