# Record Your Local Context

Local means the command runs on the machine in front of you; remote means it runs somewhere else over the network. Before any SSH connection, record where you are — so that after login you have something to compare. Three commands give independent evidence: `hostname` (which machine), `whoami` (which account), `pwd` (which directory). A prompt can be customized to say anything; these ask the operating system directly.

## Task

Record your local context — the output of `hostname`, `whoami`, and `pwd`, one line each in that order — into `/tmp/kd-ssh/local-context.txt`.

The verifier compares your file against the live system: a made-up hostname or the wrong account fails.

<details>
<summary>Hint</summary>

```bash
hostname  >  /tmp/kd-ssh/local-context.txt
whoami    >> /tmp/kd-ssh/local-context.txt
pwd       >> /tmp/kd-ssh/local-context.txt
cat /tmp/kd-ssh/local-context.txt
```

This is the "before" snapshot. A good operator's notes always start with it — in a real incident, this block pasted into the team channel proves everyone is looking at the same machine.

</details>
