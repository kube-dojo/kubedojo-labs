# Congratulations!

You have completed the AppArmor Mandatory Access Control lab.

## What You Practiced

- Inspecting AppArmor status and counting enforced profiles
- Writing custom AppArmor profiles from scratch
- Switching profiles between enforce and complain modes
- Reading denial logs for profile debugging

## Key Takeaway

Kubernetes uses AppArmor to add an extra layer of container isolation. When you specify an AppArmor profile in a pod's security context, the kubelet loads that profile on the node and applies it to the container process. Understanding how to create and debug profiles is essential for CKS-level security work.

## Next Steps

- Study how Kubernetes applies AppArmor profiles via pod annotations and `securityContext.appArmorProfile`
- Explore `bane` — a tool that generates AppArmor profiles for Docker containers
- Investigate how container runtimes (containerd, CRI-O) integrate with AppArmor

## Reference

Full curriculum module:
[Module 4.2 — AppArmor](https://kube-dojo.github.io/linux/security/hardening/module-4.2-apparmor/)
