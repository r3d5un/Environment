# dnsmasq

## Overview

This setup uses `dnsmasq` as a local DNS server to resolve all `*.islandwind.me` subdomains to the homelab's Tailscale IP (`100.67.63.36`). Tailscale's **Custom DNS** feature ensures that DNS queries for `islandwind.me` are forwarded to `dnsmasq` only for devices connected to the Tailscale network. For example:

- A device connected to Tailscale queries `jellyfin.islandwind.me`.
- Tailscale's DNS forwards the query to dnsmasq running on `100.67.63.36`.
- `dnsmasq` resolves the subdomain to `100.67.63.36` (the homelab's Tailscale IP).
- The device connects directly to the homelab service via Tailscale.

## `dnsmasq` Configuration

`dnsmasq` resolves all subdomains of `islandwind.me` to the homelab's Tailscale IP. The configuration file is found at `/etc/dnsmasq.conf`. See `dnsmasq.conf` for the actual contents.

Changes to the `dnsmasq.conf` file requires restarting the service.

```bash
sudo systemctl restart dnsmasq
```

## Tailscale Configuration

In order to take advantage of the DNS server on the homelab a custom nameserver must be added in the Tailscale admin console. Within the DNS settings on Tailscale add a new nameserver, restrict it to a single domain `islandwind.me` and the Tailscale IP address, identical to the `dnsmasq.conf` `listen-address` field. This will cause all DNS queries within the Tailscale network to go to the `dnsmasq` service on the homelab.
