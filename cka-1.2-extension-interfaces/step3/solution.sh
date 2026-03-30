#!/bin/bash
SC_OUTPUT=$(kubectl get storageclass 2>&1)
if echo "$SC_OUTPUT" | grep -q "No resources"; then
  echo "no storage classes found" > /root/storage-classes.txt
else
  echo "$SC_OUTPUT" > /root/storage-classes.txt
fi
echo "Storage classes:"
cat /root/storage-classes.txt
