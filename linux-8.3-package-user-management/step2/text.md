# User Management Automation

Batch user creation is common when onboarding teams.

## Key Commands

```bash
# Create a group
groupadd ops-team

# Create user with group and home directory
useradd -m -g ops-team -s /bin/bash username

# Add user to supplementary group
usermod -aG ops-team existing-user
```

## Your Task

Write `/root/create-team.sh` that:

1. Creates a group called `ops-team`
2. Creates 3 users: `ops-alice`, `ops-bob`, `ops-charlie`
3. Each user should:
   - Have a home directory (`-m`)
   - Be a member of the `ops-team` group
   - Use `/bin/bash` as their shell

Make it executable and run it.
