#!/bin/bash
kubectl apply -f https://raw.githubusercontent.com/aquasecurity/kube-bench/main/job.yaml
kubectl wait --for=condition=Complete job/kube-bench --timeout=120s
kubectl logs job/kube-bench > /root/kube-bench-results.txt
grep -c '\[FAIL\]' /root/kube-bench-results.txt > /root/kube-bench-fails.txt
grep -c '\[PASS\]' /root/kube-bench-results.txt > /root/kube-bench-passes.txt
