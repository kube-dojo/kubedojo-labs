## Step 3: Read and Search File Contents

In the `~/documents` directory, there is a file called `services.txt`. It lists several services and their current status.

### Your task
1. List all services that are **stopped**.
2. Save the list of stopped services to `~/projects/lab-results/stopped.txt`.

### Hint
Use `grep` to filter for lines containing "stopped".

<details>
<summary>Hint</summary>

```bash
grep "stopped" ~/documents/services.txt > ~/projects/lab-results/stopped.txt
```
</details>
