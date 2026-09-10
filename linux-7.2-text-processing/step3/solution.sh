#!/bin/bash
# Solution: Find top 10 most frequent words
awk '{for(i=3;i<=NF;i++) print tolower($i)}' "$HOME"/sample.log | sort | uniq -c | sort -rn | head -10 > "$HOME"/word-freq.txt
cat "$HOME"/word-freq.txt
