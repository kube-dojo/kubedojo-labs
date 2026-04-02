#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: host-routing ingress exists with two hosts
HOSTS=$(kubectl get ingress host-routing -n practice -o jsonpath='{.spec.rules[*].host}' 2>/dev/null)
echo "$HOSTS" | grep -q "app.example.com" && echo "$HOSTS" | grep -q "blog.example.com" && exit 0 || exit 1
