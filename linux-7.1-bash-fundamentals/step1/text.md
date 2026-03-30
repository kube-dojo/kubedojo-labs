# Variables and Conditionals

## Variables

```bash
# Assignment (no spaces around =)
NAME="world"
COUNT=42

# Usage
echo "Hello $NAME"
echo "Count is ${COUNT}"

# Command substitution
TODAY=$(date +%Y-%m-%d)
```

## Conditionals

```bash
# if/else with [[ ]]
if [[ $COUNT -gt 10 ]]; then
  echo "Greater than 10"
elif [[ $COUNT -eq 10 ]]; then
  echo "Equal to 10"
else
  echo "Less than 10"
fi

# String comparison
if [[ "$NAME" == "world" ]]; then
  echo "Match!"
fi

# File tests
if [[ -f /etc/hosts ]]; then
  echo "File exists"
fi
```

## Your Task

Write `/root/check-disk.sh` that:

1. Gets the disk usage percentage of the root filesystem
2. If usage > 80%, outputs `WARNING: Disk usage is above 80%`
3. Otherwise outputs `OK: Disk usage is normal`

Make it executable with `chmod +x`.

**Hint:** Extract disk usage with:
```bash
USAGE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
```
