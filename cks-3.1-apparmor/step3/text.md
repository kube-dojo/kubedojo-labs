# Create a Custom AppArmor Profile for Nginx

Create a tailored AppArmor profile that allows nginx to function while restricting unnecessary access.

## Task

1. Create an AppArmor profile at `/etc/apparmor.d/k8s-nginx` that:
   - Allows reading files in `/etc/nginx/`, `/usr/share/nginx/`, `/var/log/nginx/`
   - Allows network access (TCP bind and listen)
   - Denies writing outside of `/var/log/nginx/` and `/var/cache/nginx/`
   - Denies executing other binaries
2. Load the profile.
3. Create a pod named `nginx-hardened` in `apparmor-lab` using this profile.
4. Verify nginx starts and serves traffic. Save the test to `/root/nginx-test.txt`.

## Hint

AppArmor network rules use `network inet tcp,` and `network inet udp,`. File rules use path patterns with `r` (read), `w` (write), `x` (execute).
