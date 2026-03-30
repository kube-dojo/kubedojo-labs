#!/bin/bash
ls /etc/kubernetes/manifests/ > /root/static-pods.txt
echo "Static pod manifests:"
cat /root/static-pods.txt
