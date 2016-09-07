#!/bin/bash

set -e

if [ -n "$APIKEY" ]; then
    echo "apikey = \"$APIKEY\"" >> /etc/mackerel-agent/mackerel-agent.conf
fi

if [ "$AUTO_RETIREMENT" != "" ] && [ "$AUTO_RETIREMENT" != "0" ]; then
    trap '/usr/bin/mackerel-agent retire -force' TERM KILL
fi

if [ -n "$PLUGINS" ]; then
    IFS=','
    ARRAY=($PLUGINS)
    for PLUGIN in ${ARRAY[@]}
    do
        ln -s /etc/mackerel-agent/plugins/$PLUGIN.conf /etc/mackerel-agent/enabled/$PLUGIN.conf
    done
fi

echo "/usr/bin/mackerel-agent $OPTS"
/usr/bin/mackerel-agent $OPTS &
wait ${!}
