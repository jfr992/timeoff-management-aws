#!/bin/bash
set -ex
git clone https://github.com/timeoff-management/application.git /var/timeoff-management
cd /var/timeoff-management
npm install
npm --prefix /var/timeoff-management/ run start &

