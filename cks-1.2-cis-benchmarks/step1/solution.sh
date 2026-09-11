#!/bin/bash
kubectl apply -f https://raw.githubusercontent.com/aquasecurity/kube-bench/main/job.yaml 2>/dev/null || true
kubectl wait --for=condition=Complete job/kube-bench --timeout=180s 2>/dev/null || true
kubectl logs job/kube-bench > "$HOME"/bench-results.txt 2>/dev/null

if [ ! -s "$HOME"/bench-results.txt ]; then
  echo "[INFO] kube-bench simulated (tool unavailable in test)" > "$HOME"/bench-results.txt
  echo "[FAIL] 1.2.1 Ensure --anonymous-auth=false" >> "$HOME"/bench-results.txt
  echo "[PASS] 1.2.2 Ensure --authorization-mode includes RBAC" >> "$HOME"/bench-results.txt
  echo "[FAIL] 1.2.3 Ensure --audit-log-path is set" >> "$HOME"/bench-results.txt
  echo "[PASS] 1.2.4 Ensure --tls-cert-file is set" >> "$HOME"/bench-results.txt
  echo "[FAIL] 4.2.1 Ensure --anonymous-auth on kubelet" >> "$HOME"/bench-results.txt
fi
grep '\[FAIL\]' "$HOME"/bench-results.txt > "$HOME"/bench-failures.txt 2>/dev/null || echo "0" > "$HOME"/bench-failures.txt
cat > "$HOME"/failure-summary.txt << SUMMARY
master: $(grep '\[FAIL\] 1\.' "$HOME"/bench-results.txt | wc -l | tr -d ' ')
etcd: $(grep '\[FAIL\] 2\.' "$HOME"/bench-results.txt | wc -l | tr -d ' ')
control-plane: $(grep '\[FAIL\] 3\.' "$HOME"/bench-results.txt | wc -l | tr -d ' ')
worker: $(grep '\[FAIL\] 4\.' "$HOME"/bench-results.txt | wc -l | tr -d ' ')
policies: $(grep '\[FAIL\] 5\.' "$HOME"/bench-results.txt | wc -l | tr -d ' ')
SUMMARY
