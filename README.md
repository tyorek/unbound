# Unbound DNS Configs

This repo contains the same `unbound.conf` files that I use, along with DoT (DNS-over-TLS) forwarding and public DNS forwarding configs, plus some bash alias scripts for easier shortcuts to commonly accessed items.

## Forwarding

In the forwarding configuration files, the `.` is the DNS root zone of your server. If you want everything to be forwarded, leave it as is. If you want specific domains forwarded, replace the `.` with the domain name you want forwarded for lookups.

## DNS-over-TLS (DoT)

The dotconfig within this repo uses TCP port 853, with port 53 UDP/TCP as fallback.

If you want to use DoT for your server you must have real TLS certificates. Self-signed certificates will not work due to them being untrusted by default. This means you will have to create a domain and register it. After that you can use certbot. The command to request a certificate is `sudo certbot certonly -d example.com` — replace `example.com` with your domain name.

The easiest method is to start a temporary server on port 80 that Let's Encrypt can interact with to answer the challenge. If you are behind a firewall, this means you will have to forward port 80 to your server for it to work. You can utilize Cloudflare Tunnel if you are behind a CGNAT, which adds more complexity beyond the scope of this repo.
