# 🌐 Dynamic DNS with Cloudflare

A simple project to automatically update your Cloudflare DNS records whenever your public IP address changes.

---

## 📋 Prerequisites

*   A registered domain name
*   A Cloudflare account
*   A Linux environment
*   `curl` installed
*   `cron` enabled

---

## ⚙️ Configuration Guide

### 1. Add Domain to Cloudflare
Log in to your Cloudflare account and add your domain to a new or existing site.

### 2. Update Nameservers
Go to your domain registrar's panel and replace your current nameservers with Cloudflare's nameservers.

### 3. Create a DNS Record
In your Cloudflare dashboard, create a new DNS record with the following specifications:

| Field | Value |
| :--- | :--- |
| **Type** | A |
| **Name** | noip |
| **IPv4 address** | 1.1.1.1 |
| **Proxy status** | DNS Only |

### 4. Create an API Token
Navigate to **My Profile** → **API Tokens** → **Create Token** → **Edit zone DNS**. Configure it as follows:

| Setting | Value |
| :--- | :--- |
| **Permissions** | Zone / DNS / Edit |
| **Zone Resources** | Include / Specific Zone / *Select your domain* |

### 5. Retrieve IDs
You will need your **Zone ID** and **Record ID**.
*   **Zone ID:** Found on your domain's Overview page in the Cloudflare dashboard.
*   **Record ID:** Run the following command in your terminal, replacing `ZONE_ID` and the domain name:

```bash
curl -X GET "[https://api.cloudflare.com/client/v4/zones/ZONE_ID/dns_records?name=noip.yourdomain.com](https://api.cloudflare.com/client/v4/zones/ZONE_ID/dns_records?name=noip.yourdomain.com)" \
     -H "Authorization: Bearer YOUR_API_TOKEN" \
     -H "Content-Type: application/json"
```

### 6. Configure the Application File
Copy the example configuration file to the correct directory:

```bash
sudo cp dyndns.conf.example /etc/dyndns/dyndns.conf
```

### 7. Installation
Clone the repository on the target machine and execute the installation script:

```bash
sudo ./install.sh
```

---

## 🚀 Usage

**Syntax:** `dyndns [COMMAND] [OPTIONS]`

| Command | Description |
| :--- | :--- |
| `configure [KEY VALUE]` | Edit the config file or set a specific key=value |
| `logs` | Show logs in real time |
| `update` | Force a DNS update |
| `cache` | Clear the current IP cache |

**Options:**
*   `-h, --help`: Show the help message
*   `-v, --version`: Show version information

**Examples:**
```bash
dyndns configure
dyndns configure DNS_NAME mydomain.example.com
dyndns configure API_TOKEN api_token_here
dyndns logs
dyndns update
dyndns --help
```

---

## ⏱️ Automation (Cron)

To keep your IP updated automatically, add this job to execute every 10 minutes:

```bash
*/10 * * * * /opt/dyndns/update_dns.sh
```