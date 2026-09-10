# Build and Mount the Overlay Stack

An OverlayFS mount takes four pieces: `lowerdir` (read-only content — image layers), `upperdir` (where every write lands — the container layer), `workdir` (kernel scratch space, must be on the same filesystem as `upperdir`), and the merged mountpoint (what the process sees). The lab tmpfs at `/tmp/kd-ufs` is your backing filesystem.

## Task

1. Create the four directories: `/tmp/kd-ufs/lower`, `/tmp/kd-ufs/upper`, `/tmp/kd-ufs/work`, `/tmp/kd-ufs/merged`.
2. Seed the "image" (lower layer) with three files: `base.txt` containing `base file`, `modify.txt` containing `original content`, `delete.txt` containing `delete me`.
3. Mount the overlay.
4. Record the live mount evidence: the `FSTYPE,OPTIONS` line from `findmnt` into `/tmp/kd-ufs/evidence/mount-info.txt` and the merged listing into `/tmp/kd-ufs/evidence/merged-list.txt`.

The verifier reads the live mount table — creating directories and forging the evidence files without a real mount fails.

<details>
<summary>Hint</summary>

```bash
mkdir -p /tmp/kd-ufs/lower /tmp/kd-ufs/upper /tmp/kd-ufs/work /tmp/kd-ufs/merged
echo "base file" > /tmp/kd-ufs/lower/base.txt
echo "original content" > /tmp/kd-ufs/lower/modify.txt
echo "delete me" > /tmp/kd-ufs/lower/delete.txt
sudo mount -t overlay overlay -o lowerdir=/tmp/kd-ufs/lower,upperdir=/tmp/kd-ufs/upper,workdir=/tmp/kd-ufs/work /tmp/kd-ufs/merged
findmnt -no FSTYPE,OPTIONS /tmp/kd-ufs/merged > /tmp/kd-ufs/evidence/mount-info.txt
ls /tmp/kd-ufs/merged > /tmp/kd-ufs/evidence/merged-list.txt
cat /tmp/kd-ufs/evidence/mount-info.txt /tmp/kd-ufs/evidence/merged-list.txt
```

All three seeded files should appear in `merged/` even though `upper/` is empty — the kernel is presenting the lower layer through the union.

</details>
