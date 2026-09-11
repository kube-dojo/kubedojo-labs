#!/bin/bash
cat > "$HOME"/block-metadata.yaml << 'YAML'
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: block-metadata
  namespace: metadata-lab
spec:
  podSelector: {}
  policyTypes:
  - Egress
  egress:
  - to:
    - ipBlock:
        cidr: 0.0.0.0/0
        except:
        - 169.254.169.254/32
YAML
kubectl apply -f "$HOME"/block-metadata.yaml
