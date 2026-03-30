# Report Generator

Generate an HTML system report that can be viewed in a browser or emailed.

## HTML Basics for Reports

```html
<html>
<head><title>System Report</title></head>
<body>
  <h1>System Report</h1>
  <h2>Hostname</h2>
  <p>myserver</p>
  <h2>Uptime</h2>
  <pre>uptime output here</pre>
</body>
</html>
```

## Your Task

Write `/root/report.sh` that creates `/root/system-report.html` with:

1. Hostname
2. Uptime
3. Disk usage (from `df -h`)
4. Memory usage (from `free -m`)

Use proper HTML tags (`<h1>`, `<h2>`, `<pre>`). Make the script executable and run it.
