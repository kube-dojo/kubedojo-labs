# Create and Use ServiceAccounts

## Task

1. List existing ServiceAccounts in `sa-lab`:
   ```
   kubectl get serviceaccounts -n sa-lab
   ```
2. Create a new ServiceAccount named `app-sa` in `sa-lab`:
   ```
   kubectl create serviceaccount app-sa -n sa-lab
   ```
3. Describe the ServiceAccount to see its details.
4. Save the ServiceAccount name to `/root/sa-name.txt`.

## Hint

Every namespace has a `default` ServiceAccount. Use `kubectl create serviceaccount` to create new ones.
