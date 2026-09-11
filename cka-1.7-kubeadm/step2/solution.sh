#!/bin/bash
sudo kubeadm certs check-expiration > "$HOME"/cert-expiry.txt 2>&1
echo "Certificate expiration dates:"
cat "$HOME"/cert-expiry.txt
