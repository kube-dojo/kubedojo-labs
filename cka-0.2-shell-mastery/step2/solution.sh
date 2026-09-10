#!/bin/bash
jq -r '.items[].name' "$HOME"/sample.json > "$HOME"/names.txt
echo "Names extracted:"
cat "$HOME"/names.txt
