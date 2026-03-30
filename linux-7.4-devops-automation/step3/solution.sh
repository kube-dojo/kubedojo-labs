#!/bin/bash
# Solution: Create CI/CD pipeline script
cat > /root/pipeline.sh << 'SCRIPT'
#!/bin/bash
set -euo pipefail

function build() {
  echo "=== BUILD STAGE ==="
  echo "Compiling application..."
  sleep 1
  echo "Build successful."
  echo ""
}

function test() {
  echo "=== TEST STAGE ==="
  echo "Running unit tests..."
  sleep 1
  echo "All tests passed."
  echo ""
}

function deploy() {
  echo "=== DEPLOY STAGE ==="
  echo "Deploying to production..."
  sleep 1
  echo "Deployment successful."
  echo ""
}

# Run pipeline
build
test
deploy

echo "Pipeline completed successfully!"
SCRIPT
chmod +x /root/pipeline.sh
/root/pipeline.sh
