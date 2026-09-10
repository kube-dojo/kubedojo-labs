#!/bin/bash
cat > "$HOME"/create-files.sh << 'SCRIPT'
#!/bin/bash
mkdir -p "$HOME"/timed
for i in $(seq 1 5); do
  echo "file $i" > "$HOME"/timed/test-${i}.txt
done
SCRIPT

chmod +x "$HOME"/create-files.sh
"$HOME"/create-files.sh
echo "Files created:"
ls -la "$HOME"/timed/
