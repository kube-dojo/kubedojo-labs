# kubectl explain

`kubectl explain` is your built-in API reference. It shows the fields available for any resource type.

**Examples:**
```bash
kubectl explain pod                    # Top-level Pod fields
kubectl explain pod.spec               # Pod spec fields
kubectl explain pod.spec.containers    # Container fields
kubectl explain pod --recursive        # All fields (long output)
```

## Task

Run `kubectl explain pod.spec` and save the output to `/root/pod-spec-fields.txt`.

<details>
<summary>Hint</summary>

Simply redirect the output:
```bash
kubectl explain pod.spec > /root/pod-spec-fields.txt
```
</details>