# System Maintenance

Regular maintenance keeps systems healthy and secure.

## Cleaning Up

```bash
# Clean apt cache (frees disk space)
apt-get clean

# Remove unused packages
apt-get autoremove -y

# Check cache size
du -sh /var/cache/apt/
```

## Checking for Updates

```bash
# Update package lists
apt-get update

# List upgradable packages
apt list --upgradable
```

## Your Task

1. Clean the apt cache
2. List upgradable packages
3. Save the maintenance results to `/root/maintenance.txt`:
   - Cache size after cleaning
   - List of upgradable packages (or "none")

```bash
apt-get clean
apt-get update -qq
{
  echo "Cache size after cleaning:"
  du -sh /var/cache/apt/
  echo ""
  echo "Upgradable packages:"
  apt list --upgradable 2>/dev/null || echo "none"
} > /root/maintenance.txt
```
