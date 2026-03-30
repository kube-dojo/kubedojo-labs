# AppArmor Status

AppArmor profiles can be in one of two modes:

| Mode | Behaviour |
|------|-----------|
| **enforce** | Violations are blocked and logged |
| **complain** | Violations are logged but allowed (useful for profile development) |

## Key Commands

```bash
aa-status                    # Show loaded profiles and their modes
aa-enabled                   # Check if AppArmor is enabled
cat /sys/module/apparmor/parameters/enabled   # Kernel-level check
```

The `aa-status` output shows:
- Number of profiles loaded
- Number in enforce mode
- Number in complain mode
- Processes with profiles

## Task

1. Verify AppArmor is enabled on the system
2. Run `aa-status` to list all loaded profiles
3. Count the number of profiles in **enforce** mode
4. Save that count (just the number) to `/root/enforce-count.txt`

<details>
<summary>Refer to: aa-status(8)</summary>
See <code>man aa-status</code>. The output line format is: <code>N profiles are in enforce mode.</code> — extract the number N.
</details>
