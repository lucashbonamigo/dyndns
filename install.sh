#!/bin/bash

set -e

echo "Creating directories..."

sudo mkdir -p /opt/dyndns
sudo mkdir -p /etc/dyndns

echo "Installing files..."

sudo cp update_dns.sh /opt/dyndns/update_dns.sh
sudo chmod +x /opt/dyndns/update_dns.sh

sudo cp dyndns /usr/local/bin/dyndns
sudo chmod +x /usr/local/bin/dyndns

echo "Configuring cron..."

(
crontab -l 2>/dev/null
echo "*/10 * * * * /opt/dyndns/update_dns.sh"
) | crontab -

echo "Creating log..."

sudo touch /var/log/dyndns.log

echo "Installation completed."    