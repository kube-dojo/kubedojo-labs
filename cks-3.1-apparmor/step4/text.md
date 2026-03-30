# Troubleshoot AppArmor Denials

When AppArmor blocks operations, you need to identify and fix the denials.

## Task

1. Check the system log for AppArmor denials: `dmesg | grep -i apparmor` or `journalctl | grep -i apparmor`. Save to `/root/apparmor-denials.txt`.
2. Create `/root/troubleshooting-guide.txt` with steps to troubleshoot AppArmor issues:
   - How to identify which profile is denying
   - How to put a profile in complain mode for debugging
   - How to generate a profile from observed behavior
3. Put the `k8s-deny-write` profile in complain mode and save the status to `/root/complain-mode.txt`.

## Hint

Use `aa-complain /etc/apparmor.d/k8s-deny-write` to switch to complain mode. Use `aa-logprof` to analyze denials and update profiles.
