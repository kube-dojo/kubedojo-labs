# Block Metadata Access with NetworkPolicy

Create a NetworkPolicy that blocks egress to the metadata endpoint IP.

## Task

1. Create a NetworkPolicy named `block-metadata` in the `metadata-lab` namespace that:
   - Applies to all pods (`podSelector: {}`)
   - Allows all egress EXCEPT to `169.254.169.254/32`
   - Use `ipBlock` with `except` to block the metadata IP
2. Save the NetworkPolicy YAML to `/root/block-metadata.yaml`.

## Hint

Use egress rules with `ipBlock.cidr: 0.0.0.0/0` and `ipBlock.except: ["169.254.169.254/32"]` to allow all traffic except the metadata endpoint.
