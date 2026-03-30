# Exit Codes and Error Handling

## Exit Codes

Every command returns an exit code: 0 = success, non-zero = failure.

```bash
ls /tmp
echo $?    # 0 (success)

ls /nonexistent
echo $?    # 2 (failure)
```

## Strict Mode

The "unofficial bash strict mode" catches errors early:

```bash
set -euo pipefail
```

- `set -e` — exit immediately on any command failure
- `set -u` — treat unset variables as errors
- `set -o pipefail` — a pipeline fails if any command in it fails

## trap — Cleanup on Exit

```bash
trap cleanup EXIT

function cleanup() {
  echo "Cleaning up temporary files..."
  rm -f /tmp/myapp-*.tmp
}
```

## Your Task

Write `/root/safe-script.sh` that:

1. Uses `set -euo pipefail` for strict error handling
2. Has a `trap` that cleans up a temp file on exit
3. Creates a temp file, does some work, and exits cleanly

Make it executable.
