#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: connectivity file exists and pod-a service exists
[ -f $USER_HOME/connectivity.txt ] && [ -s $USER_HOME/connectivity.txt ] && kubectl get svc pod-a -n practice -o name 2>/dev/null | grep -q "service" && exit 0 || exit 1
