# Troubleshooting DNS

When DNS resolution fails, you need a systematic approach to identify where the problem lies.

## Troubleshooting Checklist

1. **Can you resolve anything?** — `dig google.com` (tests basic DNS)
2. **Is the nameserver reachable?** — `ping <nameserver-ip>` (tests network)
3. **Is it a specific domain?** — `dig problematic-domain.com` (tests the domain)
4. **Trace the resolution path** — `dig +trace example.com` (follows delegation chain)

## dig +trace

The `+trace` flag makes dig follow the DNS delegation chain from root servers down to the authoritative server, showing each step:

```bash
dig +trace kubernetes.io
```

This reveals where in the chain a failure occurs — root servers, TLD servers, or the authoritative server.

## nslookup Debug Mode

```bash
nslookup -debug kubernetes.io
```

## Task

Verify that DNS resolution works for `kubernetes.io`. Resolve its IP address and save it to `~/k8s-io-ip.txt`.

<details>
<summary>Hint 1</summary>
Use <code>dig +short kubernetes.io</code> to get just the IP address.
</details>

<details>
<summary>Hint 2</summary>
<code>dig +short kubernetes.io > ~/k8s-io-ip.txt</code>
</details>
