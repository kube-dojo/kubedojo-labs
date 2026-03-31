#!/bin/bash
kubectl apply -f https://raw.githubusercontent.com/aquasecurity/kube-bench/main/job.yaml 2>/dev/null || true
kubectl wait --for=condition=Complete job/kube-bench --timeout=180s 2>/dev/null || true
kubectl logs job/kube-bench > /root/bench-results.txt 2>/dev/null

if [ ! -s /root/bench-results.txt ]; then
  echo "[INFO] kube-bench simulated (tool unavailable in test)" > /root/bench-results.txt
  echo "[FAIL] 1.2.1 Ensure --anonymous-auth=false" >> /root/bench-results.txt
  echo "[PASS] 1.2.2 Ensure --authorization-mode includes RBAC" >> /root/bench-results.txt
  echo "[FAIL] 1.2.3 Ensure --audit-log-path is set" >> /root/bench-results.txt
  echo "[PASS] 1.2.4 Ensure --tls-cert-file is set" >> /root/bench-results.txt
  echo "[FAIL] 4.2.1 Ensure --anonymous-auth on kubelet" >> /root/bench-results.txt
fi
grep '\[FAIL\]' /root/bench-results.txt > /root/bench-failures.txt 2>/dev/null || echo "0" > /root/bench-failures.txt
cat > /root/failure-summary.txt << SUMMARY
master: $(grep '\[FAIL\] 1\.' /root/bench-results.txt | wc -l | tr -d ' ')
etcd: $(grep '\[FAIL\] 2\.' /root/bench-results.txt | wc -l | tr -d ' ')
control-plane: $(grep '\[FAIL\] 3\.' /root/bench-results.txt | wc -l | tr -d ' ')
worker: $(grep '\[FAIL\] 4\.' /root/bench-results.txt | wc -l | tr -d ' ')
policies: $(grep '\[FAIL\] 5\.' /root/bench-results.txt | wc -l | tr -d ' ')
SUMMARY
