# Prevent Privilege Escalation Through RBAC

Understand and prevent RBAC-based privilege escalation attacks.

## Task

1. Create a Role named `restricted-role-creator` in `rbac-lab` that allows:
   - `create`, `get`, `list` on `roles` and `rolebindings`
   - This demonstrates a potential escalation vector
2. Verify that a ServiceAccount with this role could potentially escalate privileges by creating new roles. Save the `can-i` check to `/root/escalation-check.txt`.
3. Create a more secure version named `safe-role-creator` that:
   - Allows only `get`, `list` on `roles` and `rolebindings` (no create)
4. Document in `/root/escalation-prevention.txt` three strategies to prevent RBAC escalation.

## Hint

A user who can create Roles and RoleBindings can create a Role with any permissions and bind it to themselves. The RBAC escalation prevention API requires the `escalate` verb.
