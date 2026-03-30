## Fix Scheduler Issues

The scheduler is responsible for assigning pods to nodes. When it fails, new pods stay in `Pending` state.

### Task

1. Break the scheduler by renaming its manifest, observe pods staying Pending
2. Create a test pod and verify it is Pending
3. Fix the scheduler by restoring the manifest
4. Verify the test pod gets scheduled

```bash
# Break the scheduler (move manifest out)
mv /etc/kubernetes/manifests/kube-scheduler.yaml /root/kube-scheduler-broken.yaml
sleep 10

# Create a test pod — it should stay Pending
kubectl run scheduler-test --image=nginx:1.25 -n practice
sleep 5
kubectl get pod scheduler-test -n practice
# Should show Pending

# Fix the scheduler — restore the manifest
cp /root/kube-scheduler-backup.yaml /etc/kubernetes/manifests/kube-scheduler.yaml
sleep 15

# Verify the pod gets scheduled
kubectl get pod scheduler-test -n practice
```

<details>
<summary>Hint: Scheduler troubleshooting</summary>

```bash
# Check if scheduler is running
kubectl get pods -n kube-system | grep scheduler
crictl ps | grep scheduler

# If scheduler is down, check the manifest
ls /etc/kubernetes/manifests/kube-scheduler.yaml

# Check scheduler logs
kubectl logs -n kube-system kube-scheduler-$(hostname)

# Restore from backup
cp /root/kube-scheduler-backup.yaml /etc/kubernetes/manifests/kube-scheduler.yaml
```
</details>
