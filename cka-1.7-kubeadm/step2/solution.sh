#!/bin/bash
kubeadm certs check-expiration > /root/cert-expiry.txt 2>&1
echo "Certificate expiration dates:"
cat /root/cert-expiry.txt
