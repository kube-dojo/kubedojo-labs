#!/bin/bash
sudo ls /etc/kubernetes/manifests/ > "$HOME"/static-pods.txt
echo "Static pod manifests:"
cat "$HOME"/static-pods.txt
