#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify curl output file exists and contains nginx content
# If file doesn't exist yet, wait up to 60s for the service to become reachable
# (pods backing the service may still be starting)
if [ -f $USER_HOME/curl-output.txt ]; then
  grep -qi "nginx\|welcome" $USER_HOME/curl-output.txt 2>/dev/null && exit 0
fi
# File missing or empty — wait for service pods to be ready, then check again
for i in $(seq 1 30); do
  if [ -f $USER_HOME/curl-output.txt ]; then
    grep -qi "nginx\|welcome" $USER_HOME/curl-output.txt 2>/dev/null && exit 0
  fi
  sleep 2
done
exit 1
