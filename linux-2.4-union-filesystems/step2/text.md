# Read Through, Write New

Two facts make image sharing scale. First: reads are answered by the highest layer that has the file — reading a lower file copies nothing. Second: writes never touch the lower layer — a brand-new file is created in `upperdir` only. One image layer on disk can therefore serve a thousand containers, each with its own thin writable layer.

## Task

Work only through the **merged** view:

1. Read `base.txt` through the merged view into `/tmp/kd-ufs/evidence/read-through.txt`.
2. Create `new.txt` containing `new file` in the merged view.
3. Record the upper layer's listing into `/tmp/kd-ufs/evidence/upper-after-new.txt`.

The verifier checks the live layers: `new.txt` must exist in `upper/` and must NOT exist in `lower/`, and reading `base.txt` must not have copied it up.

<details>
<summary>Hint</summary>

```bash
cat /tmp/kd-ufs/merged/base.txt > /tmp/kd-ufs/evidence/read-through.txt
echo "new file" > /tmp/kd-ufs/merged/new.txt
ls /tmp/kd-ufs/upper > /tmp/kd-ufs/evidence/upper-after-new.txt
cat /tmp/kd-ufs/evidence/read-through.txt /tmp/kd-ufs/evidence/upper-after-new.txt
```

`upper/` should now contain exactly one entry: `new.txt`. If `base.txt` appeared there too, something wrote to it — reads alone never trigger a copy-up.

</details>
