# Delete Creates a Whiteout

Deleting a lower-layer file cannot remove it — the lower layer is shared, read-only history. Instead OverlayFS records a **whiteout** in the upper layer: a character device with device number 0/0 at the deleted path. The merged view treats it as "this file does not exist", while the lower bytes remain fully intact. This is exactly why a `RUN rm` in a later Dockerfile layer hides files without making the image smaller.

## Task

1. Delete `delete.txt` through the **merged** view.
2. Record the long listing of the upper layer into `/tmp/kd-ufs/evidence/upper-after-delete.txt` — look for the `c` (character device) entry.

The verifier checks live state on all three levels: gone from merged, still present in lower, whiteout device in upper.

<details>
<summary>Hint</summary>

```bash
rm /tmp/kd-ufs/merged/delete.txt
ls -la /tmp/kd-ufs/upper > /tmp/kd-ufs/evidence/upper-after-delete.txt
cat /tmp/kd-ufs/evidence/upper-after-delete.txt
ls /tmp/kd-ufs/lower
```

The upper `delete.txt` line should start with `c` and show `0, 0` as the device numbers — that is the whiteout. The lower directory still lists all three original files.

</details>
