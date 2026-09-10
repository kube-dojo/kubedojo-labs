# Create a Network Namespace

A network namespace isolates the whole network stack: interfaces, addresses, routes, and the listening-port space. Two processes can both bind TCP port 80 if they live in different network namespaces.

A newly created network namespace is intentionally lonely. It contains only a loopback interface — and even that starts **down**. There is no `eth0`, no default route, no path to the internet. Container runtimes add connectivity later with veth pairs; this step focuses on what isolation looks like before any of that.

`ip netns` manages *named* namespaces, registered under `/run/netns/`, which makes them easy to list, enter, and delete.

## Task

1. Create a named network namespace called `lab-net`.
2. Look at its interfaces (`ip -n lab-net -brief address show`) — observe loopback is DOWN.
3. Bring `lo` up inside the namespace and confirm it now carries `127.0.0.1/8`.

Remember: `127.0.0.1` always means "this network namespace", never "this machine". Bringing this `lo` up wires nothing to the outside world.

<details>
<summary>Hint</summary>

```bash
sudo ip netns add lab-net
sudo ip -n lab-net -brief address show
sudo ip -n lab-net link set lo up
sudo ip -n lab-net -brief address show lo
```

</details>
