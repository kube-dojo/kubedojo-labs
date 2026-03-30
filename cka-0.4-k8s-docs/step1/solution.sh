#!/bin/bash
kubectl explain pod.spec > /root/pod-spec-fields.txt
echo "Saved pod.spec fields to /root/pod-spec-fields.txt"
head -20 /root/pod-spec-fields.txt
