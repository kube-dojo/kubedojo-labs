#!/bin/bash
kubectl create serviceaccount app-sa -n sa-lab
echo "app-sa" > /root/sa-name.txt
