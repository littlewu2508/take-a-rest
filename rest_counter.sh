#!/bin/bash

_term() {
  kill -TERM "$child" 2>/dev/null
}
trap _term SIGTERM

$(./suspendable_sleep $1 && notify-send -t $(($3*1000)) "Take a Rest") &
shell_pid=$!
shell_pid=$(ps --ppid ${shell_pid} -o pid=)
sleep_pid=$(ps --ppid ${shell_pid} -o pid=)

TEMP_LEAVE_THRESHOLD=$2

xidle.py -d -w timeout ${TEMP_LEAVE_THRESHOLD} "kill -INT ${sleep_pid} > /dev/null 2>&1" \
	resume "sleep ${TEMP_LEAVE_THRESHOLD} && kill -CONT ${sleep_pid} > /dev/null 2>&1" &
child=$!
wait "$child"
