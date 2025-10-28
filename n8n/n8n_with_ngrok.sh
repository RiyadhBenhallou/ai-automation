#!/usr/bin/env bash
set -euo pipefail
cd path/to/n8n

# start both in the same process group (background but attached)
npx n8n start &  N8N_PID=$!
ngrok http --url=subdomain.ngrok-free.app 5678 >/dev/null & NGROK_PID=$!

cleanup(){
  echo
  # kill the whole group (-PID) so no orphaned children
  kill -TERM -$$ 2>/dev/null || true   # $$ = this script’s PGID
  wait                                   # one wait is enough
  exit 0
}
trap cleanup INT

# wait for either child to finish
wait