# Create a Pod with an Init Container

Init containers run to completion before any app containers start. They are used for setup tasks like waiting for dependencies or downloading configuration.

## Task

Create a pod named `web-init` in the `multi-lab` namespace with:

1. An init container named `init-config` using image `busybox:1.36` that writes "Initialized" to `/work-dir/status.txt`.
   - Command: `sh -c "echo Initialized > /work-dir/status.txt"`
2. A main container named `web` using image `nginx:1.25` that mounts the same volume at `/usr/share/nginx/html`.
3. Both containers share an `emptyDir` volume named `shared-data`.

The pod should reach Running state with the init container showing as completed.

## Hint

Define `initContainers` and `containers` both mounting the same volume. The init container runs its command then exits, and the main container starts.
