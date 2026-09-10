#!/bin/bash
readlink /proc/$$/ns/pid > /tmp/kd-ns/ns-baseline.txt
cat /tmp/kd-ns/ns-baseline.txt
