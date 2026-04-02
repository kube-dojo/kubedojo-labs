#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: PriorityClass exists with correct value
VALUE=$(kubectl get priorityclass high-priority -o jsonpath='{.value}' 2>/dev/null)
[ "$VALUE" = "1000000" ] && exit 0 || exit 1
