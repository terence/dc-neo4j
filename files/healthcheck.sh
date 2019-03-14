#!/usr/bin/env bash
set -euo pipefail

curl -qf --connect-timeout 4 --max-time 7 http://`hostname`:7474 >/dev/null 2>&1
cd /init && make && cd -


