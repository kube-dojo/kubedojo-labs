#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if ! kubectl get pod nonroot-pod -n secctx-lab &>/dev/null; then
  echo "FAIL: Pod nonroot-pod not found"
  exit 1
fi
NONROOT=$(kubectl get pod nonroot-pod -n secctx-lab -o jsonpath='{.spec.securityContext.runAsNonRoot}')
if [ "$NONROOT" != "true" ]; then
  echo "FAIL: nonroot-pod should have runAsNonRoot=true"
  exit 1
fi
for f in nonroot-id.txt root-fail.txt fixed-pod.yaml; do
  if [ ! -f "$USER_HOME/$f" ] || [ ! -s "$USER_HOME/$f" ]; then
    echo "FAIL: $USER_HOME/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
