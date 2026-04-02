#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify /opt/project has correct ownership and permissions
if [ ! -d /opt/project ]; then
  echo "/opt/project does not exist"
  exit 1
fi

# Check owner
owner=$(stat -c '%U' /opt/project)
if [ "$owner" != "developer" ]; then
  echo "Owner should be 'developer', got '$owner'"
  exit 1
fi

# Check group
group=$(stat -c '%G' /opt/project)
if [ "$group" != "devteam" ]; then
  echo "Group should be 'devteam', got '$group'"
  exit 1
fi

# Check permissions (2770 = SGID + rwxrwx---)
perms=$(stat -c '%a' /opt/project)
if [ "$perms" = "2770" ]; then
  echo "Permissions correct: $perms (SGID + rwxrwx---)"
  exit 0
else
  echo "Expected permissions 2770, got $perms"
  exit 1
fi
