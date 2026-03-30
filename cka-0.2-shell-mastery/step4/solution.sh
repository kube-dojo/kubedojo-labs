#!/bin/bash
cat > /root/create-files.sh << 'SCRIPT'
#!/bin/bash
mkdir -p /root/timed
for i in $(seq 1 5); do
  echo "file $i" > /root/timed/test-${i}.txt
done
SCRIPT

chmod +x /root/create-files.sh
/root/create-files.sh
echo "Files created:"
ls -la /root/timed/
