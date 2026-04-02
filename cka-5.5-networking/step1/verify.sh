#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: dns-broken pod can resolve DNS
kubectl exec dns-broken -n practice -- nslookup kubernetes.default 2>/dev/null | grep -q "Address" && exit 0 || exit 1
