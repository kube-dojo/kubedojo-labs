#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify alias ll is in ~/.bashrc
grep -q "alias ll='ls -la'" ~/.bashrc 2>/dev/null || grep -q 'alias ll="ls -la"' ~/.bashrc 2>/dev/null
if [ $? -ne 0 ]; then
  echo "alias ll='ls -la' not found in ~/.bashrc"
  exit 1
fi
echo "Great! The alias is persisted in ~/.bashrc."
exit 0
