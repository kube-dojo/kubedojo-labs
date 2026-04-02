#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for f in /etc/kubernetes/admission/image-policy.yaml /etc/kubernetes/admission/image-policy-kubeconfig.yaml; do
  if [ ! -f "$f" ] || [ ! -s "$f" ]; then
    echo "FAIL: $f missing or empty"
    exit 1
  fi
done
if ! grep -q "defaultAllow" /etc/kubernetes/admission/image-policy.yaml; then
  echo "FAIL: image-policy.yaml should contain defaultAllow"
  exit 1
fi
if [ ! -f $USER_HOME/image-policy-notes.txt ] || [ ! -s $USER_HOME/image-policy-notes.txt ]; then
  echo "FAIL: $USER_HOME/image-policy-notes.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
