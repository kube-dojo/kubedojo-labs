#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: path-routing ingress exists with 3 paths
PATH_COUNT=$(kubectl get ingress path-routing -n practice -o jsonpath='{.spec.rules[0].http.paths[*].path}' 2>/dev/null | wc -w)
[ "$PATH_COUNT" -ge 3 ] && exit 0 || exit 1
