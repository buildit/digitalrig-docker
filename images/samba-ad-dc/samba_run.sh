#!/bin/sh

set -e

[ -f /var/lib/samba/.setup ] || {
    >&2 echo "[ERROR] Samba is not setup yet, which should happen automatically. Look for errors!"
    exit 127
}

trap 'kill -TERM $PID' TERM INT
samba -i -s /var/lib/samba/private/smb.conf < /dev/null &
PID=$!
wait $PID
trap - TERM INT
wait $PID
EXIT_STATUS=$?
