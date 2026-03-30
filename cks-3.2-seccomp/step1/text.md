# Apply the Default RuntimeDefault Seccomp Profile

The RuntimeDefault profile blocks dangerous syscalls while allowing common ones.

## Task

1. Create a pod named `seccomp-default` in `seccomp-lab` with the RuntimeDefault seccomp profile:
   ```yaml
   securityContext:
     seccompProfile:
       type: RuntimeDefault
   ```
2. Create a second pod named `seccomp-unconfined` in `seccomp-lab` WITHOUT any seccomp profile (Unconfined).
3. Compare the syscall restrictions by trying `unshare --user` in both pods. Save the results:
   - `/root/default-unshare.txt` from seccomp-default
   - `/root/unconfined-unshare.txt` from seccomp-unconfined
4. Document the three seccomp profile types in `/root/seccomp-types.txt`.

## Hint

`unshare` creates new namespaces and may be blocked by RuntimeDefault. Use `kubectl exec` to run the test.
