#!/bin/bash
# Solution: Create utils.sh with functions
cat > /root/utils.sh << 'SCRIPT'
#!/bin/bash

function log_info() {
  echo "[INFO] $*"
}

function log_error() {
  echo "[ERROR] $*" >&2
}

function check_command() {
  if command -v "$1" > /dev/null 2>&1; then
    return 0
  else
    return 1
  fi
}

# Test if sourced directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  log_info "Testing log_info"
  log_error "Testing log_error"
  if check_command "bash"; then
    log_info "bash is available"
  fi
fi
SCRIPT
chmod +x /root/utils.sh
/root/utils.sh
