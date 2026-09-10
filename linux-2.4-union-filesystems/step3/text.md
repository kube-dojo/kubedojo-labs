# Trigger Copy-on-Write

Modifying a file that lives in a read-only lower layer is the interesting case. The kernel cannot edit the lower file (other containers share it), so it *copies the file up* into `upperdir` first and applies your change to the copy. From then on, the upper version shadows the lower one. This is why appending one line to a multi-gigabyte lower-layer file can allocate the whole file's size in the writable layer — and why high-churn data belongs on volumes.

## Task

1. Through the **merged** view, overwrite `modify.txt` with `modified content`.
2. Record the upper copy's content into `/tmp/kd-ufs/evidence/upper-modify.txt` and the lower original's content into `/tmp/kd-ufs/evidence/lower-modify.txt`.

The verifier checks the live layers: `upper/modify.txt` must hold the new content while `lower/modify.txt` must still hold `original content`, byte-for-byte untouched.

<details>
<summary>Hint</summary>

```bash
echo "modified content" > /tmp/kd-ufs/merged/modify.txt
cat /tmp/kd-ufs/upper/modify.txt > /tmp/kd-ufs/evidence/upper-modify.txt
cat /tmp/kd-ufs/lower/modify.txt > /tmp/kd-ufs/evidence/lower-modify.txt
cat /tmp/kd-ufs/evidence/upper-modify.txt /tmp/kd-ufs/evidence/lower-modify.txt
```

Same path, two different files: the merged view now answers with the upper copy, while every other consumer of the lower layer still sees the original.

</details>
