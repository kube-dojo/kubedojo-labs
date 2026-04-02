#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if ! kubectl get pod web >/dev/null 2>&1; then echo "FAIL: Pod 'web' not found."; exit 1; fi
STATUS=$(kubectl get pod web -o jsonpath='{.status.phase}')
if [ "$STATUS" = "Running" ]; then echo "PASS: Pod 'web' is running!"; exit 0; fi
echo "FAIL: Pod 'web' is in state $STATUS. Wait for it to become Running."
exit 1
