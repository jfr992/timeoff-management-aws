#!/bin/bash
set -x
HTTPCODE=$(wget --server-response http://localhost:3000/login/ 2>&1 | awk '/^  HTTP/{print $2}')
if [ "$HTTPCODE" == "200" ]
then
    exit 0
else
    exit 1
fi