## Pod Topology Spread

Topology spread constraints control how pods are distributed across failure domains (nodes, zones, regions).

### Task

Create a deployment named `spread-deploy` in the `practice` namespace with:

- Replicas: `3`
- Image: `nginx:1.25`
- Labels: `app: spread-app`
- Topology spread constraint:
  - `maxSkew: 1`
  - `topologyKey: kubernetes.io/hostname`
  - `whenUnsatisfiable: DoNotSchedule`
  - `labelSelector` matching `app: spread-app`

```bash
# Note: with a single-node cluster, only 1 node is available,
# but the constraint configuration is what matters for CKA
```

<details>
<summary>Hint: topologySpreadConstraints spec</summary>

```yaml
spec:
  replicas: 3
  selector:
    matchLabels:
      app: spread-app
  template:
    metadata:
      labels:
        app: spread-app
    spec:
      topologySpreadConstraints:
      - maxSkew: 1
        topologyKey: kubernetes.io/hostname
        whenUnsatisfiable: DoNotSchedule
        labelSelector:
          matchLabels:
            app: spread-app
      containers:
      - name: nginx
        image: nginx:1.25
```

Refer to: https://kubernetes.io/docs/concepts/scheduling-eviction/topology-spread-constraints/
</details>
