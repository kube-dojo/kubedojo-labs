#!/bin/bash
SC_OUTPUT=$(kubectl get storageclass 2>&1)
if echo "$SC_OUTPUT" | grep -q "No resources"; then
  echo "no storage classes found" > "$HOME"/storage-classes.txt
else
  echo "$SC_OUTPUT" > "$HOME"/storage-classes.txt
fi
echo "Storage classes:"
cat "$HOME"/storage-classes.txt
