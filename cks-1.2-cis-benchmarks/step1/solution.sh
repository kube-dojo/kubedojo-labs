#!/bin/bash
kubectl apply -f https://raw.githubusercontent.com/aquasecurity/kube-bench/main/job.yaml
kubectl wait --for=condition=Complete job/kube-bench --timeout=180s
kubectl logs job/kube-bench > /root/bench-results.txt
grep '\[FAIL\]' /root/bench-results.txt > /root/bench-failures.txt
cat > /root/failure-summary.txt << SUMMARY
master: $(grep '\[FAIL\] 1\.' /root/bench-results.txt | wc -l | tr -d ' ')
etcd: $(grep '\[FAIL\] 2\.' /root/bench-results.txt | wc -l | tr -d ' ')
control-plane: $(grep '\[FAIL\] 3\.' /root/bench-results.txt | wc -l | tr -d ' ')
worker: $(grep '\[FAIL\] 4\.' /root/bench-results.txt | wc -l | tr -d ' ')
policies: $(grep '\[FAIL\] 5\.' /root/bench-results.txt | wc -l | tr -d ' ')
SUMMARY
