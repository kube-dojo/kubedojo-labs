# Packet Capture with tcpdump

`tcpdump` captures network packets for deep inspection. It is the command-line equivalent of Wireshark.

## Basic Usage

```bash
# Capture 10 packets on any interface
tcpdump -c 10

# Capture on a specific interface
tcpdump -i eth0 -c 10

# Filter by port
tcpdump -c 10 port 80

# Filter by host
tcpdump -c 10 host 8.8.8.8

# Save to file for Wireshark analysis
tcpdump -c 10 -w /tmp/capture.pcap
```

## Reading Output

Each line shows: timestamp, protocol, source, destination, and packet info.

## Your Task

1. Capture 10 packets on any interface
2. Save a summary to `/root/tcpdump-output.txt`

```bash
tcpdump -c 10 -n 2>&1 | head -15 > /root/tcpdump-output.txt
```

If no traffic is flowing, generate some first:
```bash
# In background, generate traffic
curl -s http://localhost/ > /dev/null 2>&1 &
tcpdump -c 10 -n 2>&1 | head -15 > /root/tcpdump-output.txt
```
