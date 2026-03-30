#!/bin/bash
# Solution: Find top 10 most frequent words
awk '{for(i=3;i<=NF;i++) print tolower($i)}' /root/sample.log | sort | uniq -c | sort -rn | head -10 > /root/word-freq.txt
cat /root/word-freq.txt
