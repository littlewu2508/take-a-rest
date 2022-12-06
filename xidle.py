#!/usr/bin/env python3

import sys, os
import subprocess
from time import sleep

TIMEOUT=int(sys.argv[4]) * 1000
TIMEOUT_CMD=sys.argv[5]
RESUME_CMD=sys.argv[7]

def getidle() :
    result = subprocess.run("xprintidle", stdout=subprocess.PIPE)
    return int(result.stdout)

while True :
    while True :
        idle_time_ms = getidle()
        if idle_time_ms > TIMEOUT :
            prevous_idle_time_ms = getidle()
            os.system(TIMEOUT_CMD)
            break
        sleep(1)

    while True :
        idle_time_ms = getidle()
        if idle_time_ms < prevous_idle_time_ms :
            prevous_idle_time_ms = getidle()
            os.system(RESUME_CMD)
            break
        sleep(1)

