#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: manual endpoint exists pointing to 10.0.0.100
EP_IP=$(kubectl get endpoints external-database -n practice -o jsonpath='{.subsets[0].addresses[0].ip}' 2>/dev/null)
EP_PORT=$(kubectl get endpoints external-database -n practice -o jsonpath='{.subsets[0].ports[0].port}' 2>/dev/null)
[ "$EP_IP" = "10.0.0.100" ] && [ "$EP_PORT" = "5432" ] && exit 0 || exit 1
