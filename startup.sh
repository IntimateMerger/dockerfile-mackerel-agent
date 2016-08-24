#!/bin/bash

set -e

export DOCKER_HOST=$(curl -sf "http://169.254.169.254/latest/meta-data/hostname" | cut -d '.' -f 1)

if [ -n "$DOCKER_HOST" ]; then
    echo "display_name = \"My Host\"" >> /etc/mackerel-agent/mackerel-agent.conf
fi

if [ -n "$APIKEY" ]; then
    echo "apikey = \"$APIKEY\"" >> /etc/mackerel-agent/mackerel-agent.conf
fi

if [ "$AUTO_RETIREMENT" != "" ] && [ "$AUTO_RETIREMENT" != "0" ]; then
    trap '/usr/bin/mackerel-agent retire -force' TERM KILL
fi

echo "/usr/bin/mackerel-agent $OPTS"
/usr/bin/mackerel-agent $OPTS &
wait ${!}