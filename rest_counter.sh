#!/bin/bash

_term() {
  kill -TERM "$child" 2>/dev/null
}
trap _term SIGTERM

$(./suspendable_sleep $1 && notify-send "Take a Rest") &
shell_pid=$!
shell_pid=$(ps --ppid ${shell_pid} -o pid=)
sleep_pid=$(ps --ppid ${shell_pid} -o pid=)
echo ${shell_pid}
echo ${sleep_pid}
ps -f -p ${sleep_pid}

TEMP_LEAVE_THRESHOLD=$2

swayidle -w -d timeout ${TEMP_LEAVE_THRESHOLD} "kill -INT ${sleep_pid}" \
	resume "sleep ${TEMP_LEAVE_THRESHOLD} && kill -CONT ${sleep_pid}" &
child=$!
wait "$child"
