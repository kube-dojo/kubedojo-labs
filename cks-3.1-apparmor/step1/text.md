# Examine and Load AppArmor Profiles

Before applying profiles to pods, understand what profiles are available on the node.

## Task

1. Check if AppArmor is enabled on the node: `aa-status` or check `/sys/module/apparmor/parameters/enabled`. Save the status to `/root/apparmor-status.txt`.
2. List all loaded AppArmor profiles and save to `/root/loaded-profiles.txt`.
3. Create a simple AppArmor profile at `/etc/apparmor.d/k8s-deny-write`:
   ```
   #include <tunables/global>
   profile k8s-deny-write flags=(attach_disconnected) {
     #include <abstractions/base>
     file,
     deny /tmp/** w,
     deny /var/tmp/** w,
   }
   ```
4. Load the profile with `apparmor_parser -r /etc/apparmor.d/k8s-deny-write` and verify it appears in the loaded profiles list. Save verification to `/root/profile-loaded.txt`.

## Hint

Use `aa-status` to list profiles. The profile must be loaded on every node where pods might run.
