# Port Scanning

Port scanning reveals which services are listening on a host.

## nmap — Network Mapper

```bash
# Scan common ports on localhost
nmap localhost

# Scan specific ports
nmap -p 22,80,443 localhost

# Scan a range
nmap -p 1-1000 localhost
```

## netcat (nc) — Quick Port Check

```bash
# Check if a specific port is open
nc -zv localhost 80

# Scan a range
nc -zv localhost 1-100 2>&1 | grep succeeded
```

## ss / netstat — View Listening Ports

```bash
# Show all listening ports
ss -tlnp
```

## Your Task

Nginx was started during setup. Scan localhost for open ports and save to `~/port-scan.txt`.

```bash
nmap localhost > ~/port-scan.txt
```

or

```bash
ss -tlnp > ~/port-scan.txt
```
