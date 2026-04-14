# Diagnose a Control Plane Failure

The scheduler has already been broken for you in `setup.sh`. Its **static pod manifest** now points at an invalid kubeconfig, so the scheduler cannot start correctly. A smoke pod named `scheduler-smoke` was created in the `practice` namespace and should still be unscheduled.

## Task

Diagnose why the scheduler is failing, then restore it.

Your recovery must include:

1. Prove the symptom from the workload side by inspecting `scheduler-smoke`
2. Check scheduler logs or events to identify the failure
3. Inspect `/etc/kubernetes/manifests/kube-scheduler.yaml` and find the bad `--kubeconfig` flag
4. Restore the scheduler by fixing the manifest or copying back `/var/tmp/cka-1.1-kube-scheduler.yaml.backup`
4. Confirm `scheduler-smoke` receives a node assignment and reaches `Running`

Useful commands:

```bash
kubectl get pod scheduler-smoke -n practice -o wide
kubectl describe pod scheduler-smoke -n practice
kubectl logs -n kube-system kube-scheduler-$(hostname) --previous
grep kubeconfig /etc/kubernetes/manifests/kube-scheduler.yaml
cp /var/tmp/cka-1.1-kube-scheduler.yaml.backup /etc/kubernetes/manifests/kube-scheduler.yaml
```

<details>
<summary>Hint</summary>

The healthy manifest should reference `/etc/kubernetes/scheduler.conf`, not `/etc/kubernetes/broken-scheduler.conf`.
</details>
