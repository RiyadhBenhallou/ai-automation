#!/bin/bash

cd dev/ai-automation/n8n && npx n8n start &
n8n_pid=$!

# uncomment this command in case you wnated to use ngrok and remove the --tunnel flag from the scripts in package.json + add the ngrok pid alongside n8n pid in the kill command below
ngrok http --url=subdomain.ngrok-free.app 5678 > /dev/null &
ngrok_pid=$!

# Wait for user to press Ctrl+C
trap "echo 'Stopping...'; kill $n8n_pid; exit" SIGINT

wait $n8n_pid
