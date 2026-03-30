#!/bin/bash
# Solution: Start background process, save PID, kill it
sleep 600 &
echo $! > /root/bg-pid.txt
kill $(cat /root/bg-pid.txt)
echo "Process $(cat /root/bg-pid.txt) killed."
