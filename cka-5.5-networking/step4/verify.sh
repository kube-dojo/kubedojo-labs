#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: allow policies exist in isolated namespace
INGRESS_NP=$(kubectl get networkpolicy allow-web-ingress -n isolated -o jsonpath='{.metadata.name}' 2>/dev/null)
DNS_NP=$(kubectl get networkpolicy allow-dns-egress -n isolated -o jsonpath='{.metadata.name}' 2>/dev/null)
[ "$INGRESS_NP" = "allow-web-ingress" ] && [ "$DNS_NP" = "allow-dns-egress" ] && exit 0 || exit 1
