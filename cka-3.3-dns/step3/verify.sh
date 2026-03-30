#!/bin/bash
# Verify: debug pod exists and both output files created
POD_EXISTS=$(kubectl get pod dnsutils -n frontend -o jsonpath='{.metadata.name}' 2>/dev/null)
FILE1=$(test -f /root/dns-debug.txt && echo "yes")
FILE2=$(test -f /root/coredns-logs.txt && echo "yes")
[ "$POD_EXISTS" = "dnsutils" ] && [ "$FILE1" = "yes" ] && [ "$FILE2" = "yes" ] && exit 0 || exit 1
