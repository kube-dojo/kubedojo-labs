#!/bin/bash
# Solution: Sum salary column
awk -F',' 'NR > 1 {sum += $3} END {print sum}' /root/data.csv > /root/awk-sum.txt
echo "Total salary: $(cat /root/awk-sum.txt)"
