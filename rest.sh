#!/bin/bash

$(sleep 45m; notify-send "Take a Rest") &
SLEEP_ID=$!
SLEEP_ID=$(ps --ppid ${SLEEP_ID} -o pid=)
SLEEP_ID=$(ps --ppid ${SLEEP_ID} -o pid=)
echo ${SLEEP_ID}
