#!/bin/bash
cat > /root/selinux-workflow.txt << 'WORKFLOW'
=== SELinux Troubleshooting Workflow ===

STEP 1: IDENTIFY THE DENIAL
  Command: ausearch -m avc -ts recent
  Command: grep "avc:  denied" /var/log/audit/audit.log
  Purpose: Find Access Vector Cache (AVC) denial messages in the audit log.
  The log entry shows: source context, target context, permission denied, and object class.

STEP 2: UNDERSTAND THE DENIAL
  Command: audit2why < /var/log/audit/audit.log
  Purpose: Explains WHY the denial occurred in human-readable form.
  Common reasons:
  - Wrong file context (need restorecon)
  - Boolean needs to be enabled
  - No policy exists (need custom module)

  Command: sealert -a /var/log/audit/audit.log
  Purpose: Provides detailed analysis with suggested fixes (requires setroubleshoot).

STEP 3: FIX THE DENIAL (three strategies)

  Strategy A — Fix File Context (most common):
    restorecon -Rv /path/to/files
    Use when files were moved/copied and lost their correct labels.

  Strategy B — Toggle Boolean:
    setsebool -P httpd_can_network_connect on
    Use when a known boolean controls the denied permission.

  Strategy C — Create Custom Policy (last resort):
    audit2allow -M mypolicy < /var/log/audit/audit.log
    semodule -i mypolicy.pp
    Use when no existing context or boolean covers the use case.
    WARNING: Review the generated policy carefully — audit2allow can be overly permissive.

STEP 4: VERIFY THE FIX
  - Repeat the operation that was denied
  - Check that no new AVC denials appear: ausearch -m avc -ts recent
  - Confirm the service works as expected

=== Kubernetes Relevance ===
On RHEL-based Kubernetes nodes (EKS with Amazon Linux, OpenShift with RHEL):
- Container processes run with container_t or spc_t contexts
- Volume mounts may need context relabeling (:Z or :z flags in Docker/Podman)
- The container_manage_cgroup boolean must be on for systemd-based containers
- OpenShift SCCs (Security Context Constraints) integrate with SELinux contexts
- Pod securityContext.seLinuxOptions allows setting level, role, type, user

Common Kubernetes SELinux denial pattern:
  Container tries to write to a volume labeled with the wrong type.
  Fix: Use seLinuxOptions in pod spec or relabel the volume.
WORKFLOW
