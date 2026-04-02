# OOM Killer

When the system runs critically low on memory and cannot reclaim enough, the kernel's **OOM (Out Of Memory) killer** selects a process to terminate.

## OOM Score

Each process has an OOM score at `/proc/<PID>/oom_score`. Higher score = more likely to be killed.

The score is based on:
- Memory usage (biggest factor)
- Process age
- CPU time used
- The `oom_score_adj` value (-1000 to 1000)

## Viewing OOM Scores

```bash
# Check a specific process
cat /proc/1/oom_score
cat /proc/1/oom_score_adj

# List all processes with their OOM scores
for pid in /proc/[0-9]*; do
  p=$(basename $pid)
  score=$(cat $pid/oom_score 2>/dev/null)
  name=$(cat $pid/comm 2>/dev/null)
  [ -n "$score" ] && echo "$score $p $name"
done | sort -rn | head -10
```

## Your Task

1. Find the process with the highest `oom_score`
2. Save its PID and score to `~/oom-candidate.txt`:

```
PID: <pid>
Score: <score>
```

**Hint:**
```bash
for pid in /proc/[0-9]*; do
  p=$(basename $pid)
  score=$(cat $pid/oom_score 2>/dev/null)
  [ -n "$score" ] && echo "$score $p"
done | sort -rn | head -1 | awk '{printf "PID: %s\nScore: %s\n", $2, $1}' > ~/oom-candidate.txt
```
