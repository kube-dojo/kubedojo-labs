#!/bin/bash
jq -r '.items[].name' /root/sample.json > /root/names.txt
echo "Names extracted:"
cat /root/names.txt
