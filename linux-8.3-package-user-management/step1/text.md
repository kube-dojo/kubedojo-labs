# Package Management

## Installing Packages

```bash
apt-get update
apt-get install -y nginx
```

## Version Pinning (Hold)

Prevent a package from being upgraded:

```bash
# Hold a package
apt-mark hold nginx

# Check held packages
apt-mark showhold

# Unhold when you want to upgrade
apt-mark unhold nginx
```

This is critical in production to prevent unexpected upgrades from breaking things.

## Package Information

```bash
# Show installed version
dpkg -l nginx

# Show package details
apt-cache show nginx

# List files in a package
dpkg -L nginx
```

## Your Task

1. Install nginx
2. Hold its version with `apt-mark hold`
3. Verify the hold is in place with `apt-mark showhold`
