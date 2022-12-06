#!/bin/sh

TIMEOUT=$(($4 * 1000))  # s -> ms
TIMEOUT_CMD=$5
RESUME_CMD=$7

while true; do
	while true; do
		idle_time_ms=$(xprintidle)
		if [ ${idle_time_ms} -gt ${TIMEOUT} ]; then
			${TIMEOUT_CMD}
			prevous_idle_time_ms=$(xprintidle)
			break
		fi
		sleep 1;
	done

	while true; do
		idle_time_ms=$(xprintidle)
		if [ ${idle_time_ms} -lt ${prevous_idle_time_ms} ]; then
			${RESUME_CMD}
			break
		fi
		sleep 1;
	done
done
