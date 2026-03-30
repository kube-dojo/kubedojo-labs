# Use emptyDir and hostPath Volumes

`emptyDir` creates a temporary directory that exists for the life of a pod. `hostPath` mounts a directory from the node.

## Task

1. Create a pod named `temp-storage` in `volumes-lab` with:
   - Container: `writer` using `busybox:1.36`, command: `sh -c "echo hello > /cache/greeting.txt; sleep 3600"`
   - An `emptyDir` volume named `cache-vol` mounted at `/cache`

2. Create a pod named `host-storage` in `volumes-lab` with:
   - Container: `reader` using `busybox:1.36`, command: `sh -c "cat /host-data/test.txt || sleep 3600"`
   - A `hostPath` volume named `host-vol` of type `DirectoryOrCreate` pointing to `/data/hostpath-demo`, mounted at `/host-data`

3. Write "hostpath-works" to `/data/hostpath-demo/test.txt` on the node.

## Hint

`hostPath` type `DirectoryOrCreate` creates the directory if it does not exist. Use `echo "hostpath-works" > /data/hostpath-demo/test.txt` on the node.
