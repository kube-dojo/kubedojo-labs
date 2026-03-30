# AppArmor Mandatory Access Control

AppArmor is a Linux Security Module (LSM) that confines programs to a limited set of resources. Unlike traditional discretionary access control (DAC) based on file permissions, AppArmor provides mandatory access control (MAC) — even root processes are restricted by their profile.

AppArmor is the default MAC system on Ubuntu and Debian. Kubernetes supports AppArmor natively: you can annotate pods with AppArmor profiles to restrict container processes beyond what the container runtime enforces.

## What You Will Learn

- Querying AppArmor status and understanding profile modes
- Creating custom AppArmor profiles for specific binaries
- Switching profiles between enforce and complain modes
- Reading AppArmor denial logs for troubleshooting

## Prerequisites

- Understanding of Linux file permissions (Module 1.4)
- Familiarity with process management (Module 1.2)

## Reference

This lab accompanies the KubeDojo curriculum module:
[Module 4.2 — AppArmor](https://kube-dojo.github.io/linux/security/hardening/module-4.2-apparmor/)
