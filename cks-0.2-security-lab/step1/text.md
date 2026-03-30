# Install and Configure Security Scanning Tools

The CKS exam expects you to work with security tools. Install and verify key scanning utilities.

## Task

1. Install **trivy** (container image scanner):
   ```bash
   curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin
   ```
2. Verify trivy is installed by running `trivy --version` and save the output to `/root/trivy-version.txt`.
3. Install **kubesec** by downloading its binary:
   ```bash
   curl -sSL https://github.com/controlplaneio/kubesec/releases/download/v2.14.0/kubesec_linux_amd64.tar.gz | tar xz -C /usr/local/bin kubesec
   ```
4. Verify kubesec works by running `kubesec version` and save the output to `/root/kubesec-version.txt`.

## Hint

If trivy install script fails, try downloading a specific release from the GitHub releases page.
