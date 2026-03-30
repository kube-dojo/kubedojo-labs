## Vertical Pod Autoscaler Concepts

The VPA adjusts CPU and memory requests/limits for containers based on actual usage. While VPA is not installed by default, understanding resource usage is essential.

### Task

1. Check if metrics-server is ready:
   ```bash
   kubectl get deployment metrics-server -n kube-system
   ```

2. Inspect current resource usage of pods:
   ```bash
   kubectl top pods -n practice
   ```

   If metrics-server is not yet ready, you may see an error. Wait a minute and try again.

3. Save the resource usage output to a file:
   ```bash
   kubectl top pods -n practice > /root/resource-usage.txt 2>&1 || \
     echo "Metrics not yet available — this is expected in some lab environments" > /root/resource-usage.txt
   ```

4. Also check node resource usage:
   ```bash
   kubectl top nodes >> /root/resource-usage.txt 2>&1 || true
   ```

5. Review the file:
   ```bash
   cat /root/resource-usage.txt
   ```

<details>
<summary>Hint: VPA in production</summary>

In production, you would install the VPA from https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler. It has three components:

- **Recommender**: Monitors resource usage and provides recommendations
- **Updater**: Evicts pods that need resource adjustments
- **Admission Controller**: Sets resources on new pods

VPA modes: `Off` (recommend only), `Initial` (set on creation), `Auto` (set and update).

Refer to: https://kubernetes.io/docs/concepts/workloads/autoscaling/#scaling-workloads-vertically
</details>
