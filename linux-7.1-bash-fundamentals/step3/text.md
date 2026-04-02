# Functions

Functions make scripts modular and reusable.

## Defining Functions

```bash
# Method 1
function greet() {
  echo "Hello, $1!"
}

# Method 2
greet() {
  echo "Hello, $1!"
}

# Calling
greet "World"
```

## Return Values

Functions use `return` for exit codes (0-255) and `echo` for output:

```bash
function is_even() {
  if (( $1 % 2 == 0 )); then
    return 0  # true
  else
    return 1  # false
  fi
}

function get_hostname() {
  echo $(hostname)
}

# Capture output
HOST=$(get_hostname)
```

## Your Task

Write `~/utils.sh` with three functions:

1. **`log_info`** — prints `[INFO] <message>` to stdout
2. **`log_error`** — prints `[ERROR] <message>` to stderr
3. **`check_command`** — checks if a command exists, returns 0 or 1

Make it executable.
