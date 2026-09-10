# Well Done

You just operated the storage machinery under every container on every node:

- **Mounted** a real OverlayFS stack and read it back from the live mount table — the same `lowerdir`/`upperdir`/`workdir` triple Docker assembles under `/var/lib/docker/overlay2`.
- **Proved** the write path: reads come straight from the lower layer, new files exist only in the upper layer. One image, many containers, no duplication.
- **Triggered** copy-on-write and saw why appending one line to a large lower-layer file can cost a full copy — the reason high-churn data belongs on volumes, not in the container layer.
- **Created** a whiteout and inspected it: deletion is a character-device *marker* in the upper layer. The lower bytes are hidden, not gone — which is exactly why `RUN rm` in a later Dockerfile layer does not shrink an image.
- **Reconstructed** `docker diff` (A/C/D) straight from the upper directory, then unmounted with the lower layer bit-for-bit intact.

Clean up if you want to rerun: `sudo umount /tmp/kd-ufs/merged; sudo umount /tmp/kd-ufs`, or just re-run the setup.

## Next

Return to [Module 2.4: Union Filesystems](https://kube-dojo.github.io/linux/foundations/container-primitives/module-2.4-union-filesystems/) for the Docker layer-ordering, build-cache and storage-driver material, then continue to [Module 3.1: TCP/IP Essentials](https://kube-dojo.github.io/linux/foundations/networking/module-3.1-tcp-ip-essentials/) — you have now traced what a container sees, consumes, may do, and stores; next comes how it talks.
