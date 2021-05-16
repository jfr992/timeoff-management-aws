#!/bin/bash
set -x
nohup /usr/bin/npm --prefix /var/timeoff-management/ run start </dev/null &>/dev/null &
