#!/bin/bash
grep CapEff /proc/$$/status | awk '{print $2}' > /tmp/kd-caps/capeff.txt
capsh --decode=$(cat /tmp/kd-caps/capeff.txt) > /tmp/kd-caps/decoded.txt
cat /tmp/kd-caps/capeff.txt /tmp/kd-caps/decoded.txt
