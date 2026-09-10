# Union Filesystems: Mount, Copy-Up, Whiteout, Diff

Every container you have ever run sits on this trick: read-only image layers stacked under one thin writable layer, merged by the kernel into a single view. Docker's `overlay2`, containerd's overlay snapshotter and Podman all drive the same kernel feature — OverlayFS. Build the stack by hand once, without runtime ceremony, and container storage stops being folklore: you will know exactly where a write lands, why editing a big lower file costs a full copy, and what a deletion really stores.

This lab accompanies [Module 2.4: Union Filesystems](https://kube-dojo.github.io/linux/foundations/container-primitives/module-2.4-union-filesystems/) and practices its core workflow: **merged view for what the process sees, layer directories for what the system stores — debug across both**.

## Objectives

- Mount a real OverlayFS stack from `lowerdir`, `upperdir`, `workdir` into a merged view and verify it in the live mount table.
- Prove reads come straight from the lower layer while new files land only in the upper layer.
- Trigger copy-on-write: modify a lower file through the merged view and find the modified copy in the upper layer with the lower original untouched.
- Delete a lower file and inspect the whiteout — a character device that hides, but does not remove, the lower bytes.
- Reconstruct `docker diff` semantics (A/added, C/changed, D/deleted) directly from the writable layer, then unmount cleanly.

The stack lives on a dedicated tmpfs at `/tmp/kd-ufs` (overlay's `upperdir` cannot sit on another overlayfs, so the setup provides a deterministic backing filesystem). Evidence goes to `/tmp/kd-ufs/evidence/`; the verifier checks the **live** mount table and layer contents alongside it. Mount operations need `sudo`.
