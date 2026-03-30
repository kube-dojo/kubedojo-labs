#!/bin/bash
mkdir -p /etc/falco
cat > /etc/falco/falco_rules.local.yaml << 'RULES'
- rule: Kubectl Exec into Pod
  desc: Detect kubectl exec into a container
  condition: >
    spawned_process and container and
    proc.pname = runc:[2:INIT] and
    proc.name in (bash, sh, zsh)
  output: >
    Exec into container detected (user=%user.name container=%container.name
    command=%proc.cmdline namespace=%k8s.ns.name pod=%k8s.pod.name)
  priority: WARNING
  tags: [cks, exec]

- rule: Read Sensitive File in Container
  desc: Detect reading of sensitive files like /etc/shadow
  condition: >
    open_read and container and
    fd.name in (/etc/shadow, /etc/gshadow)
  output: >
    Sensitive file read (file=%fd.name user=%user.name container=%container.name
    image=%container.image.repository)
  priority: CRITICAL
  tags: [cks, sensitive_files]

- rule: Write to /etc in Container
  desc: Detect writes to /etc directory in containers
  condition: >
    open_write and container and
    fd.directory = /etc
  output: >
    Write to /etc detected (file=%fd.name user=%user.name container=%container.name
    command=%proc.cmdline)
  priority: ERROR
  tags: [cks, filesystem]

- rule: Container Running as Root
  desc: Detect containers with processes running as root
  condition: >
    spawned_process and container and
    user.uid = 0 and
    not proc.name in (pause)
  output: >
    Process running as root in container (user=%user.name uid=%user.uid
    container=%container.name command=%proc.cmdline)
  priority: WARNING
  tags: [cks, privilege]
RULES

cp /etc/falco/falco_rules.local.yaml /root/custom-rules.yaml
