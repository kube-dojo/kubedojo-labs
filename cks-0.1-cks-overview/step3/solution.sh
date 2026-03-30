#!/bin/bash
echo "insecure-pod" > /root/insecure-pod.txt
echo "safe-pod" > /root/secure-pod.txt
cat > /root/security-fixes.txt << 'FIXES'
Set privileged to false
Set runAsNonRoot to true and runAsUser to a non-zero UID
Set readOnlyRootFilesystem to true
FIXES
