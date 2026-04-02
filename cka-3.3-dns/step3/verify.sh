#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: debug pod exists and both output files created
POD_EXISTS=$(kubectl get pod dnsutils -n frontend -o jsonpath='{.metadata.name}' 2>/dev/null)
FILE1=$(test -f $USER_HOME/dns-debug.txt && echo "yes")
FILE2=$(test -f $USER_HOME/coredns-logs.txt && echo "yes")
[ "$POD_EXISTS" = "dnsutils" ] && [ "$FILE1" = "yes" ] && [ "$FILE2" = "yes" ] && exit 0 || exit 1
