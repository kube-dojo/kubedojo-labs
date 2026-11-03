#!/bin/bash
if id "ubuntu" &>/dev/null; then USER_HOME="/home/ubuntu"; else USER_HOME="/root"; fi
KEY="$USER_HOME/.ssh/lab_key"
# pair: both files exist and describe the same key.
[ -f "$KEY" ] && [ -f "$KEY.pub" ] || exit 1
PRIVATE_FP=$(ssh-keygen -lf "$KEY" 2>/dev/null | awk '{print $2}') || exit 1
PUBLIC_FP=$(ssh-keygen -lf "$KEY.pub" 2>/dev/null | awk '{print $2}') || exit 1
[ -n "$PRIVATE_FP" ] && [ "$PRIVATE_FP" = "$PUBLIC_FP" ] || exit 1
# type: the public key is ed25519.
[ "$(awk '{print $1}' "$KEY.pub")" = ssh-ed25519 ] || exit 1
# passphrase: derive the public key using an explicitly empty passphrase.
DERIVED=$(ssh-keygen -y -P '' -f "$KEY" 2>/dev/null) || exit 1
[ "$(printf '%s\n' "$DERIVED" | awk '{print $1 " " $2}')" = "$(awk '{print $1 " " $2}' "$KEY.pub")" ] && echo "PASS" && exit 0
exit 1
