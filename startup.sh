#!/bin/bash

set -e

if [ -n "$ROLE" ]; then
    OPTS="-role=$ROLE $OPTS"
fi

if [ "$AUTO_RETIREMENT" != "" ] && [ "$AUTO_RETIREMENT" != "0" ]; then
    trap '/usr/bin/mackerel-agent retire -force' TERM KILL
fi

echo "/usr/bin/mackerel-agent -apikey=$APIKEY $OPTS"
/usr/bin/mackerel-agent -apikey=$APIKEY $OPTS &
wait ${!}