#!/bin/bash

set -e

if [ "$AUTO_RETIREMENT" != "" ] && [ "$AUTO_RETIREMENT" != "0" ]; then
    trap '/usr/bin/mackerel-agent retire -force' TERM KILL
fi

echo "/usr/bin/mackerel-agent -apikey=$APIKEY -role=$ROLE $OPTS"

/usr/bin/mackerel-agent -apikey=$APIKEY -role=$ROLE $OPTS &
wait ${!}