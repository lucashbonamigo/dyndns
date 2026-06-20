# Dynamic DNS with Cloudflare

A simple project for update register in ClaudFlare always the public IP changed

Nice For:

- Home Server
- Remote SSH
- Homelab
- Nextcloud
- Self-hosted aplications
- Study environments

## Pré-requisitos

- Domain registred
- CloudFlare Account
- Linux
- curl
- cron

## Configuration

### 1. Add domain in Cloudflare

Add yout domain in Cloudflare.

### 2. Change Nameservers

In registrator of domain:

change the Nameservers for Cloudflare nameservers.

### 3. Create DNS register

Exemple:

Type:
A

Name:
noip

Content:
1.1.1.1

Proxy:
DNS Only

### 4. Create Token API

Cloudflare

My Profile
→ API Tokens
→ Create Token
→ Edit DNS

Permissions:

Zone
DNS
Edit

Scop:

Specific Zone

### 5. Get IDs

Zone ID:

Dashboard
→ Domain Overview

Record ID:

```
curl -X GET \
"https://api.cloudflare.com/client/v4/zones/ZONE_ID/dns_records?name=noip.yourdomain.com"
```
### 6. Configure archive

COpy:

dyndns.conf.example

for:

/etc/dyndns/dyndns.conf

### 7. Install

You need clone repository in the taget machine and execute:

```
sudo ./install.sh
```

### 8. Use

Usage: dyndns [COMMAND] [OPTIONS]

Available Commands:
    configure [KEY VALUE]    Edit config file or set a specific key=value
    logs                     Show logs in real time
    update                   Force DNS update
    cache                    Clear current IP cache

Options:
    -h, --help               Show this help message
    -v, --version            Show version information

Examples:
    dyndns configure
    dyndns configure DNS_NAME mydomain.example.com
    dyndns configure API_TOKEN api_token_here
    dyndns logs
    dyndns update
    dyndns --help

## Cron

Execute every 10 minutes:

*/10 * * * * /opt/dyndns/update_dns.sh