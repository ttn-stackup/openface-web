#!/bin/bash

set -e -u

function die { echo $1; exit 42; }

WEBSOCKET_PORT=9000

case $# in
  0) ;;
  1) WEBSOCKET_PORT=$1
     ;;
  *) die "Usage: $0 <HTTP Server Port> <WebSocket Port>"
     ;;
esac

cd $(dirname $0)
trap 'kill $(jobs -p)' EXIT

cat <<EOF

Starting WebSocket server on port $WEBSOCKET_PORT.

EOF

WEBSOCKET_LOG='/tmp/openface.websocket.log'
printf "WebSocket Server: Logging to '%s'\n\n" $WEBSOCKET_LOG

cd ../../ # Root OpenFace directory.
./websocket-server.py --port $WEBSOCKET_PORT 2>&1 | tee $WEBSOCKET_LOG &

wait
