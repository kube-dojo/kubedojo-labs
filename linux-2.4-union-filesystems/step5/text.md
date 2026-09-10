# Read the Writable Layer Like docker diff

`docker diff` prints `A` (added), `C` (changed), `D` (deleted) for a container — and now you know where that answer comes from: it is a walk over the container's `upperdir`. A regular file that also exists in lower = changed (copy-up). A regular file with no lower counterpart = added. A character device = deleted (whiteout). You will reconstruct the report by hand, then unmount and confirm the "image" survived everything untouched.

## Task

1. Walk `/tmp/kd-ufs/upper` and write a sorted report to `/tmp/kd-ufs/evidence/diff-report.txt`: one line per entry, `A`/`C`/`D` followed by the filename (`A new.txt`, `C modify.txt`, `D delete.txt`).
2. Unmount the merged view: `sudo umount /tmp/kd-ufs/merged`.

The verifier recomputes the report from the live upper layer, compares it to yours, confirms the unmount, and checks the lower layer still holds all three original files with original content.

<details>
<summary>Hint</summary>

```bash
for f in /tmp/kd-ufs/upper/*; do n=$(basename "$f"); if [ -c "$f" ]; then echo "D $n"; elif [ -e "/tmp/kd-ufs/lower/$n" ]; then echo "C $n"; else echo "A $n"; fi; done | sort > /tmp/kd-ufs/evidence/diff-report.txt
cat /tmp/kd-ufs/evidence/diff-report.txt
sudo umount /tmp/kd-ufs/merged
```

Expected report: `A new.txt`, `C modify.txt`, `D delete.txt` — the complete story of everything this "container" ever did to its filesystem, in three lines.

</details>
