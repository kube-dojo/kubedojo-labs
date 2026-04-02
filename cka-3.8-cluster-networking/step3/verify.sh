#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: iptables-rules.txt exists and contains data
[ -f $USER_HOME/iptables-rules.txt ] && [ -s $USER_HOME/iptables-rules.txt ] && exit 0 || exit 1
