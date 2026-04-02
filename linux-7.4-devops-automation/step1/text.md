# Configuration Management with envsubst

`envsubst` replaces `${VARIABLE}` placeholders in files with environment variable values. This is how many containers configure themselves at startup.

## How envsubst Works

```bash
export NAME="World"
echo 'Hello ${NAME}' | envsubst
# Output: Hello World
```

## Template File

A template at `~/app.conf.template` has been created with placeholders like `${APP_HOST}`, `${APP_PORT}`, etc.

## Your Task

Write `~/deploy-config.sh` that:

1. Exports environment variables for a production deployment:
   - `APP_HOST=0.0.0.0`
   - `APP_PORT=8080`
   - `APP_ENV=production`
   - `DB_HOST=db.example.com`
   - `DB_PORT=5432`
   - `DB_NAME=myapp_prod`
   - `LOG_LEVEL=warn`
2. Uses `envsubst` to generate `~/app.conf` from the template
3. Make it executable and run it

The resulting `~/app.conf` should have no `${...}` placeholders remaining.
