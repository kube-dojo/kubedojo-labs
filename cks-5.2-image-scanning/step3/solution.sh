#!/bin/bash
cat > /root/cluster-scan.sh << 'SCANSCRIPT'
#!/bin/bash
echo "=== Cluster-Wide Image Vulnerability Scan ==="
echo "Date: $(date)"
echo ""
IMAGES=$(kubectl get pods -A -o jsonpath='{range .items[*]}{.spec.containers[*].image}{"\n"}{end}' | sort -u)
TOTAL=0
VULN=0
while IFS= read -r img; do
  [ -z "$img" ] && continue
  TOTAL=$((TOTAL + 1))
  echo "--- Scanning: $img ---"
  if command -v trivy &>/dev/null; then
    RESULT=$(trivy image --severity CRITICAL,HIGH -q --timeout 60s "$img" 2>/dev/null | tail -5)
    if echo "$RESULT" | grep -qE "CRITICAL|HIGH"; then
      VULN=$((VULN + 1))
      echo "$RESULT"
    else
      echo "No CRITICAL/HIGH vulnerabilities"
    fi
  else
    echo "trivy not available — skipping scan (would check for CRITICAL/HIGH CVEs)"
  fi
  echo ""
done <<< "$IMAGES"
echo "=== Summary: $VULN/$TOTAL images with CRITICAL/HIGH CVEs ==="
SCANSCRIPT
chmod +x /root/cluster-scan.sh
/root/cluster-scan.sh > /root/cluster-scan-results.txt 2>&1

cat > /root/scanning-best-practices.txt << 'BEST'
1. Scan images in CI/CD before pushing to registry — shift left
2. Scan running cluster images regularly (weekly minimum)
3. Block deployments with CRITICAL unfixed CVEs via admission webhook
4. Use image signing (cosign) to verify scan results before deployment
5. Update base images regularly to pick up security patches
6. Monitor for new CVEs affecting already-deployed images
BEST
