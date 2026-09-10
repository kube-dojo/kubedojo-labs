#!/bin/bash
set -e
hostname  >  /tmp/kd-ssh/local-context.txt
whoami    >> /tmp/kd-ssh/local-context.txt
pwd       >> /tmp/kd-ssh/local-context.txt
cat /tmp/kd-ssh/local-context.txt
