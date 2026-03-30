# Plan and Verify the Upgrade Path

Before upgrading, assess the current version and plan the upgrade path.

## Task

1. Save the current Kubernetes version (client and server) to `/root/current-version.txt`.
2. Run `kubeadm upgrade plan` and save the output to `/root/upgrade-plan.txt`.
3. Check for available kubeadm versions: `apt list -a kubeadm 2>/dev/null` and save to `/root/available-versions.txt`.
4. Create `/root/upgrade-checklist.txt` with a pre-upgrade checklist (at least 5 items).

## Hint

Always upgrade one minor version at a time (e.g., 1.28 -> 1.29, not 1.28 -> 1.30). Check `kubeadm upgrade plan` for the recommended version.
