# Drop a Capability and Watch Root Fail

Capability checks are independent of user identity. A UID 0 process without `CAP_CHOWN` cannot change file ownership — this is exactly how container runtimes weaken "root" inside containers: same UID, smaller capability set. `capsh --drop` lets you reproduce that in one command: it removes a capability from the bounding and inherited sets, then runs a program that can never get it back.

## Task

The setup seeded `/tmp/kd-caps/testfile` (owned by `root`).

1. With full capabilities, hand the file to `nobody`: `chown nobody /tmp/kd-caps/testfile` — this succeeds.
2. Now try to take it back **with `cap_chown` dropped**: run `chown root ...` under `capsh --drop=cap_chown`. It must fail with `Operation not permitted` even though you are root.
3. Record the failure message into `/tmp/kd-caps/drop-fail.txt`.

The verifier stats the live file: it must still belong to `nobody`, proving the dropped-capability attempt really failed.

<details>
<summary>Hint</summary>

```bash
sudo chown nobody /tmp/kd-caps/testfile
sudo capsh --drop=cap_chown -- -c 'chown root /tmp/kd-caps/testfile' 2> /tmp/kd-caps/drop-fail.txt || true
cat /tmp/kd-caps/drop-fail.txt
stat -c '%U' /tmp/kd-caps/testfile
```

Same binary, same UID 0, opposite outcomes — the only difference is one capability bit. This is the exact reasoning you need when a containerized process "is root" but still can't perform a privileged operation.

</details>
