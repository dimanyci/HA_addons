# Masquerade NAT Setup

This Home Assistant add-on enables IP forwarding and configures a NAT MASQUERADE rule automatically via iptables.

## Features
- IP forwarding enabled on container start
- MASQUERADE rule management in iptables
- Custom command execution via `/data/options.json`

## Options
```yaml
log_level: "info"
commands:
  - "your-command-here"
