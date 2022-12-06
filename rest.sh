#!/bin/bash

if [[ $# -ne 3 ]]; then
	echo "Usage: ./rest.sh <work_duration> <rest_duration> <temp_leave_threshold>"
	exit 1
fi

WORK_DURATION=$1
REST_DURATION=$2
TEMP_LEAVE_THRESHOLD=$3

./rest_counter.sh ${WORK_DURATION} ${TEMP_LEAVE_THRESHOLD} ${REST_DURATION} &

xidle.py -d -w timeout ${REST_DURATION} "pkill -TERM rest_counter.sh" resume "./rest_counter.sh ${WORK_DURATION} ${TEMP_LEAVE_THRESHOLD} ${REST_DURATION} &"
