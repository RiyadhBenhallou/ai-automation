#!/bin/bash

cd dev/ai-automation/n8n && npm run dev &
n8n_pid=$!

ngrok http --url=chicken-apt-dinosaur.ngrok-free.app 5678 > /dev/null &
ngrok_pid=$!

# Wait for user to press Ctrl+C
trap "echo 'Stopping...'; kill $n8n_pid $ngrok_pid; exit" SIGINT

wait $n8n_pid
