# Page Cache and Buffers

Linux aggressively uses "free" memory for page cache. This is why `free` often shows very little free memory — the kernel caches recently read file data in RAM for faster access.

## Key Insight

"Free memory is wasted memory" — Linux intentionally fills available RAM with cache. This cached memory is instantly reclaimable when applications need it.

## Observing Cache Behavior

1. Check current cache size:
   ```bash
   free -m | awk '/^Mem:/ {print "Cache:", $6, "MB"}'
   ```

2. Write data to see cache grow:
   ```bash
   dd if=/dev/zero of=/tmp/testfile bs=1M count=100
   ```

3. Check cache size again — it should have increased.

## Your Task

1. Record the cache size before writing data
2. Write 100MB to `/tmp/testfile` using `dd`
3. Record the cache size after
4. Save both values to `~/cache-test.txt`:

```
Before: <value>MB
After: <value>MB
```

**Hint:**
```bash
BEFORE=$(free -m | awk '/^Mem:/ {print $6}')
dd if=/dev/zero of=/tmp/testfile bs=1M count=100 2>/dev/null
AFTER=$(free -m | awk '/^Mem:/ {print $6}')
echo -e "Before: ${BEFORE}MB\nAfter: ${AFTER}MB" > ~/cache-test.txt
```
