# API Interaction with curl and jq

Automation scripts frequently interact with REST APIs. `curl` makes HTTP requests and `jq` parses JSON responses.

## curl Basics

```bash
# GET request
curl -s http://localhost:8080/

# POST with JSON body
curl -s -X POST -H "Content-Type: application/json" \
  -d '{"key":"value"}' http://localhost:8080/

# With headers and authentication
curl -s -H "Authorization: Bearer TOKEN" http://localhost:8080/
```

## jq Basics

```bash
# Pretty print
echo '{"name":"Alice"}' | jq .

# Extract a field
echo '{"name":"Alice","age":30}' | jq '.name'

# Nested field
echo '{"server":{"host":"localhost"}}' | jq '.server.host'
```

## Your Task

A simple API server is running at `http://localhost:8080/`.

Write `~/api-check.sh` that:

1. Makes a GET request to `http://localhost:8080/`
2. Parses the JSON response with `jq`
3. Extracts and prints: status, version, and each service status
4. Make it executable and run it

The script should produce output like:
```
Status: healthy
Version: 1.2.3
Database: connected
Cache: connected
Queue: degraded
```
