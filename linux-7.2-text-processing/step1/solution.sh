#!/bin/bash
# Solution: Sum salary column
awk -F',' 'NR > 1 {sum += $3} END {print sum}' "$HOME"/data.csv > "$HOME"/awk-sum.txt
echo "Total salary: $(cat "$HOME"/awk-sum.txt)"
