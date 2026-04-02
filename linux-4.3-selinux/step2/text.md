# File Contexts

Every file on an SELinux-enabled system has a security context stored in its extended attributes. The **type** field is the most important — it determines which processes can access the file.

## Viewing File Contexts

```bash
ls -Z /etc/passwd
# -rw-r--r--. root root system_u:object_r:passwd_file_t:s0 /etc/passwd

ls -Z /var/www/html/
# Shows httpd_sys_content_t for web content
```

## Changing Contexts

| Command | Purpose |
|---------|---------|
| `chcon` | Temporarily change a file's context (lost on relabel) |
| `restorecon` | Restore context to the policy default |
| `semanage fcontext` | Permanently define context rules |

```bash
# Temporary change
chcon -t httpd_sys_content_t /var/www/html/index.html

# Restore to default
restorecon -v /var/www/html/index.html

# Permanent rule + apply
semanage fcontext -a -t httpd_sys_content_t "/srv/web(/.*)?"
restorecon -Rv /srv/web
```

## Task

1. Create a test file: `touch ~/selinux-lab/testfile.txt`
2. Try to view its context with `ls -Z ~/selinux-lab/testfile.txt`
3. Try changing the context with `chcon -t httpd_sys_content_t ~/selinux-lab/testfile.txt`
4. Document what happened (success or error) in `~/selinux-lab/context-report.txt`
5. Include in the report:
   - The original context (or "no context available" if SELinux is disabled)
   - The command you ran
   - Whether it succeeded or failed, and why

<details>
<summary>Refer to: chcon(1), restorecon(8), semanage-fcontext(8)</summary>
See <code>man chcon</code> for temporary context changes. On systems without SELinux kernel support, <code>chcon</code> will fail — documenting this error is the expected outcome.
</details>
