#!/bin/bash

source /etc/dyndns/dyndns.conf

DATE_AND_TIME=$(date "+%Y-%m-%d %H:%M:%S")

IP=$(curl -s https://api.ipify.org)

if [ -f "$CACHE_FILE" ]; then
    LAST_IP=$(cat "$CACHE_FILE")
else
    LAST_IP=""
fi

if [ "$IP" != "$LAST_IP" ]; then

    echo "[$DATE_AND_TIME] IP alterado: $LAST_IP -> $IP" >> "$LOG_FILE"

    RESPONSE=$(curl -s -X PUT \
        "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$RECORD_ID" \
        -H "Authorization: Bearer $API_TOKEN" \
        -H "Content-Type: application/json" \
        --data "{\"type\":\"A\",\"name\":\"$DNS_NAME\",\"content\":\"$IP\",\"ttl\":120,\"proxied\":false}")

    echo "[$DATE_AND_TIME] Cloudflare: $RESPONSE" >> "$LOG_FILE"

    echo "$IP" > "$CACHE_FILE"

else

    echo "[$DATE_AND_TIME] IP inalterado ($IP)" >> "$LOG_FILE"

fi