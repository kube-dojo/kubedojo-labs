# Interface Configuration

## ip addr — View Interfaces

```bash
# Show all interfaces
ip addr show

# Show specific interface
ip addr show eth0
```

## Creating Virtual Interfaces

The `dummy` kernel module provides virtual interfaces for testing:

```bash
# Create a dummy interface
ip link add dummy0 type dummy

# Bring it up
ip link set dummy0 up

# Assign an IP address
ip addr add 10.10.10.1/24 dev dummy0

# Verify
ip addr show dummy0
```

## Your Task

1. Create a virtual interface named `dummy0`
2. Bring it up
3. Assign IP address `10.10.10.1/24` to it
4. Verify with `ip addr show dummy0`
