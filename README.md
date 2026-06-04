This repo contains the same unbound.conf files that I use along with dot forwarding and public dns forwarding configs. 
Some bash alias scripts for easier shortcuts for commonly accessed items. 
In the forwarding configuration files the "." is the dns root zone of your server. If you want everything to be forwarded leave it as is. If you want specific domains replace the "." with the domain name you want forwarded for lookups. 
The dotconfig within this repo uses tcp port 853 and port 53 udp/tcp as fallback. 
If you are wanting to use DOT for your server you must have real tls certificates. Self-signed certificates will not work due to them being untrusted by default.
This means you will have to create a domain and register it. After that you can use certbot. The command to request a certificate is sudo certbot certonly -d example.com. Replace the example.com with your domain name. 
The easiest method is to start a temprorary server on port 80 that letsencrypt can interact with to answer the challenge. If you are behind a firewall this means you will have to forward port 80 to your server for it to work. 
You can utilize cloudflare tunnel if you are behind a cgnat which adds more complexity beyond the scope of this repo. 
