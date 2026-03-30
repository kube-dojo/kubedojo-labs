# Create ConfigMaps from Literals and Files

## Task

1. Create a ConfigMap named `app-config` in `cm-lab` from literals:
   ```
   kubectl create configmap app-config --from-literal=APP_ENV=production --from-literal=LOG_LEVEL=info -n cm-lab
   ```
2. Create a ConfigMap named `file-config` in `cm-lab` from the file `/root/app.properties`:
   ```
   kubectl create configmap file-config --from-file=/root/app.properties -n cm-lab
   ```
3. Verify both ConfigMaps exist and save the data of `app-config` to `/root/cm-data.txt`:
   ```
   kubectl get configmap app-config -n cm-lab -o jsonpath='{.data}'
   ```

## Hint

`--from-literal` creates key-value pairs. `--from-file` creates a key named after the filename with the file contents as the value.
