#!/bin/bash
curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin
trivy --version > /root/trivy-version.txt 2>&1
curl -sSL https://github.com/controlplaneio/kubesec/releases/download/v2.14.0/kubesec_linux_amd64.tar.gz | tar xz -C /usr/local/bin kubesec
kubesec version > /root/kubesec-version.txt 2>&1
