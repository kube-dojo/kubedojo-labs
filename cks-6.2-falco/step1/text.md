# Install Falco on the Cluster Node

Install Falco and verify it can detect runtime events.

## Task

1. Install Falco using the official repository:
   ```bash
   curl -fsSL https://falco.org/repo/falcosecurity-packages.asc | gpg --dearmor -o /usr/share/keyrings/falco-archive-keyring.gpg
   echo "deb [signed-by=/usr/share/keyrings/falco-archive-keyring.gpg] https://download.falco.org/packages/deb stable main" | tee /etc/apt/sources.list.d/falcosecurity.list
   apt-get update && apt-get install -y falco
   ```
   (If installation fails, create the configuration files manually for the remaining exercises.)
2. Check if Falco is running: `systemctl status falco` and save to `/root/falco-status.txt`.
3. List the default Falco rules file locations and save to `/root/falco-rules-paths.txt`.
4. Save a sample of the default rules to `/root/default-rules-sample.txt` (first 50 lines of `/etc/falco/falco_rules.yaml`).

## Hint

Falco rules are in `/etc/falco/falco_rules.yaml` (default) and `/etc/falco/falco_rules.local.yaml` (custom). If apt install fails, you can still create custom rule files.
