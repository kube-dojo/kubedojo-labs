# Apply Security Contexts to a Multi-Container Pod

Apply different security contexts to containers within the same pod.

## Task

1. Create a pod named `multi-secure` in `secctx-lab` with:
   - Pod-level: `runAsNonRoot: true`, `fsGroup: 2000`, seccomp RuntimeDefault
   - Container `app` (busybox, sleep 3600): `runAsUser: 1000`, drop ALL caps, readOnlyRootFilesystem: true
   - Container `sidecar` (busybox, sleep 3600): `runAsUser: 1001`, drop ALL caps, readOnlyRootFilesystem: true
   - Shared emptyDir volume at `/data`
2. Verify both containers run as different UIDs. Save the `id` output from each to `/root/multi-ids.txt`.
3. Verify both containers can read/write to the shared `/data` volume (fsGroup makes it writable). Save to `/root/shared-volume-test.txt`.

## Hint

Pod-level security context applies to all containers. Container-level context overrides pod-level for that container. fsGroup sets the group ownership of volume files.
