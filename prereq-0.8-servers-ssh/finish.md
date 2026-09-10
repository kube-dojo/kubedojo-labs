# Lifecycle Complete

You ran the full SSH lifecycle against a real server: recorded local context first, generated an Ed25519 key pair and placed the public half in `authorized_keys`, trusted a host key deliberately on first contact, authenticated with the key, worked through the session, and disconnected cleanly — with every claim checked against the live hostname, the live host key, and the server's own log.

Carry two habits forward:

- **Context before commands.** `hostname`, `whoami`, `pwd` after every login. A prompt is a hint; these are evidence. The same reflex later becomes "which cluster, which namespace" with `kubectl`.
- **Private key stays private.** You share the lock (`.pub`, `authorized_keys`), never the key. Anyone holding your private key can be you.

The command you built in the last step — `ssh -p 2222 -i ~/.ssh/work_key admin@10.0.0.5` — is exactly the shape you will use for real cloud servers: only the user, host, port, and key file change. Continue with [Module 0.9: Software and Packages](https://kube-dojo.github.io/prerequisites/zero-to-terminal/module-0.9-software-and-packages/).
