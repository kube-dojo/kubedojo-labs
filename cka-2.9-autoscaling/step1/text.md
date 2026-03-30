## Horizontal Pod Autoscaler

The HPA automatically scales the number of pod replicas based on observed metrics like CPU utilization.

### Task

A deployment named `scale-app` has been pre-created in the `practice` namespace with CPU requests of 50m.

1. Create an HPA for the `scale-app` deployment:
   - Target CPU utilization: `50%`
   - Minimum replicas: `1`
   - Maximum replicas: `5`

   ```bash
   kubectl autoscale deployment scale-app -n practice \
     --cpu-percent=50 --min=1 --max=5
   ```

2. Verify the HPA was created:
   ```bash
   kubectl get hpa -n practice
   kubectl describe hpa scale-app -n practice
   ```

   Note: The `TARGETS` column may show `<unknown>/50%` initially until metrics-server starts reporting data. This is normal.

<details>
<summary>Hint: HPA details</summary>

The HPA watches the CPU usage of pods in the deployment. When average CPU exceeds 50% of the requested amount (50m * 50% = 25m), it scales up. When it drops, it scales down (with a cooldown period).

You can also create HPA declaratively:
```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: scale-app
  namespace: practice
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: scale-app
  minReplicas: 1
  maxReplicas: 5
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 50
```

Refer to: https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/
</details>
