#!/bin/bash
kubectl create serviceaccount app-sa -n sa-lab
echo "app-sa" > "$HOME"/sa-name.txt
