# dig and nslookup

`dig` (Domain Information Groper) is the go-to tool for querying DNS records. It provides detailed output showing the query, answer, and authority sections.

## DNS Record Types

| Type  | Purpose                          | Example                      |
|-------|----------------------------------|------------------------------|
| A     | IPv4 address                     | google.com -> 142.250.80.46  |
| AAAA  | IPv6 address                     | google.com -> 2607:f8b0:...  |
| MX    | Mail exchange server             | gmail.com -> alt1.gmail...   |
| NS    | Authoritative name server        | google.com -> ns1.google.com |
| CNAME | Canonical name (alias)           | www.google.com -> google.com |

## Using dig

```bash
dig google.com              # Query A record (default)
dig google.com AAAA         # Query IPv6 address
dig google.com MX           # Query mail servers
dig google.com NS           # Query name servers
dig +short google.com       # Compact output (IP only)
```

## Using nslookup

```bash
nslookup google.com         # Interactive-style query
nslookup -type=MX gmail.com # Query specific record type
```

## Task

Query the A record for `google.com` using `dig` and save the full output to `~/dig-output.txt`.

<details>
<summary>Hint 1</summary>
Run <code>dig google.com</code> and redirect the output to a file.
</details>

<details>
<summary>Hint 2</summary>
<code>dig google.com > ~/dig-output.txt</code>
</details>
