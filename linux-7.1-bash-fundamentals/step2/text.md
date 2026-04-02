# Loops

## for Loop

```bash
# Iterate over a list
for name in alice bob charlie; do
  echo "Hello $name"
done

# C-style for loop
for ((i=1; i<=5; i++)); do
  echo "Number $i"
done

# Iterate over files
for file in /etc/*.conf; do
  echo "Config: $file"
done
```

## while Loop

```bash
COUNT=0
while [[ $COUNT -lt 5 ]]; do
  echo "Count: $COUNT"
  COUNT=$((COUNT + 1))
done
```

## Your Task

Write `~/create-users.sh` that:

1. Uses a loop to create 5 users: `testuser1` through `testuser5`
2. Uses `useradd` to create each user
3. Make it executable

**Hint:**
```bash
for i in $(seq 1 5); do
  useradd -m "testuser${i}" 2>/dev/null
done
```
