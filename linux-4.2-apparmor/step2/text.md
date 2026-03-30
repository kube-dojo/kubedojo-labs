# Create a Profile

AppArmor profiles are text files stored in `/etc/apparmor.d/`. Each profile specifies what a program is allowed to access.

## Profile Structure

```
#include <tunables/global>

/path/to/binary {
  #include <abstractions/base>

  # Allow reading specific files
  /etc/hosts r,

  # Allow writing to specific paths
  /tmp/** rw,

  # Deny network access
  deny network,
}
```

## Access Modes

| Mode | Meaning |
|------|---------|
| `r` | Read |
| `w` | Write |
| `x` | Execute |
| `m` | Memory map executable |
| `k` | Lock |
| `l` | Link |

## Profile Naming

The profile file name replaces `/` with `.` in the binary path. For `/usr/bin/curl`, the profile file is named `usr.bin.curl`.

## Task

Create an AppArmor profile for `/usr/bin/curl` at `/etc/apparmor.d/usr.bin.curl` that:

1. Includes `<tunables/global>` and `<abstractions/base>`
2. Allows reading `/etc/hosts`, `/etc/resolv.conf`, and `/etc/ssl/**`
3. Allows reading files in `/usr/share/**`
4. Denies write access to `/etc/**`
5. Load the profile with `apparmor_parser -r /etc/apparmor.d/usr.bin.curl`

<details>
<summary>Refer to: apparmor.d(5), apparmor_parser(8)</summary>
See <code>man apparmor.d</code> for profile syntax. Use <code>apparmor_parser -r</code> to reload a profile. The <code>abstractions/base</code> include provides common library access.
</details>
