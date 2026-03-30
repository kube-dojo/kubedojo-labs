# TCP Connections

TCP (Transmission Control Protocol) provides reliable, ordered communication between hosts. Every TCP connection goes through a **three-way handshake**:

1. **SYN** — client sends a synchronize request
2. **SYN-ACK** — server acknowledges and synchronizes back
3. **ACK** — client acknowledges, connection is ESTABLISHED

## Connection States

| State        | Meaning                              |
|--------------|--------------------------------------|
| LISTEN       | Waiting for incoming connections     |
| ESTABLISHED  | Active connection, data flowing      |
| TIME_WAIT    | Connection closed, waiting to expire |
| CLOSE_WAIT   | Remote side closed, local hasn't yet |

## Key Commands

```bash
ss -tn          # Show TCP connections (no DNS resolution)
ss -tln         # Show listening TCP sockets
ss -tnp         # Show TCP connections with process info
```

Nginx has been started on port 80 for this step.

## Task

Make an HTTP connection to `localhost:80` and capture the established TCP connections to `/root/tcp-connections.txt`.

<details>
<summary>Hint 1</summary>
Use <code>curl</code> to make a request: <code>curl -s http://localhost:80 > /dev/null</code>
</details>

<details>
<summary>Hint 2</summary>
Capture connections while the request is active, or simply save the <code>ss</code> output:
<code>curl -s http://localhost:80 > /dev/null & ss -tn > /root/tcp-connections.txt</code>
</details>
