#!/bin/bash
echo "insecure-pod" > "$HOME"/insecure-pod.txt
echo "safe-pod" > "$HOME"/secure-pod.txt
cat > "$HOME"/security-fixes.txt << 'FIXES'
Set privileged to false
Set runAsNonRoot to true and runAsUser to a non-zero UID
Set readOnlyRootFilesystem to true
FIXES
