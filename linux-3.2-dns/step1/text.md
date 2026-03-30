# DNS Resolution Basics

Before Linux sends a DNS query to a remote server, it checks local sources first. The resolution order is controlled by `/etc/nsswitch.conf`, but the two key files are:

## /etc/hosts

A simple file mapping IP addresses to hostnames. Checked **before** DNS servers by default.

```
127.0.0.1   localhost
10.0.0.5    mydb.internal
```

## /etc/resolv.conf

Specifies which DNS servers to query and the search domains:

```
nameserver 8.8.8.8
nameserver 8.8.4.4
search example.com
```

## Resolution Order

1. `/etc/hosts` is checked first
2. If no match, the system queries nameservers listed in `/etc/resolv.conf`
3. The `search` directive appends domain suffixes to short names

## Task

Add a custom host entry to `/etc/hosts` so that `myapp.local` resolves to `10.0.0.99`.

<details>
<summary>Hint 1</summary>
Edit <code>/etc/hosts</code> and add a line with the IP and hostname.
</details>

<details>
<summary>Hint 2</summary>
<code>echo "10.0.0.99 myapp.local" >> /etc/hosts</code>
</details>
