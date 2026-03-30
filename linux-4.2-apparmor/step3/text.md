# Test Profile Enforcement

Once a profile is loaded, you can switch it between modes to test its effects.

## Mode Switching Commands

```bash
aa-enforce /etc/apparmor.d/usr.bin.curl    # Switch to enforce mode
aa-complain /etc/apparmor.d/usr.bin.curl   # Switch to complain mode
aa-disable /etc/apparmor.d/usr.bin.curl    # Unload the profile
```

## Checking Profile Status

```bash
aa-status | grep curl
```

## Enforcement Behaviour

In enforce mode:
- Actions matching `deny` rules are blocked
- Actions not covered by any `allow` rule are blocked
- All denials are logged

In complain mode:
- All actions are allowed
- Would-be denials are logged as warnings

## Task

1. Ensure the curl profile from Step 2 is loaded (run `apparmor_parser -r /etc/apparmor.d/usr.bin.curl` if needed)
2. Put the curl profile in **enforce** mode using `aa-enforce`
3. Verify with `aa-status` that the curl profile appears in the enforce section
4. Attempt to use curl to write to a restricted path (this should fail or be restricted)

<details>
<summary>Refer to: aa-enforce(8), aa-complain(8)</summary>
See <code>man aa-enforce</code>. You can pass either the profile file path or the profile name. Use <code>aa-status</code> to confirm the mode change.
</details>
