# Install Helm

Helm can be installed using the official install script or by downloading the binary directly.

**Installation methods:**
```bash
# Official script (recommended)
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Or download binary
wget https://get.helm.sh/helm-v3.16.0-linux-amd64.tar.gz
tar -zxvf helm-v3.16.0-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/
```

## Task

Install Helm and verify it works by running `helm version`.

<details>
<summary>Hint</summary>

The easiest way is: 
```bash
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```
</details>