#!/bin/bash

cd dev/ai-automation/n8n && npx n8n start &
n8n_pid=$!

# Start ngrok (background)
ngrok http --url=subdomain.ngrok-free.app 5678 > /dev/null &
ngrok_pid=$!

# Cleanup function
cleanup() {
    echo -e "\nStopping..."
    # Kill n8n if it's still running
    if kill -0 $n8n_pid 2>/dev/null; then
        kill $n8n_pid
        wait $n8n_pid 2>/dev/null
    fi
    # Kill ngrok if it's still running
    if kill -0 $ngrok_pid 2>/dev/null; then
        kill $ngrok_pid
        wait $ngrok_pid 2>/dev/null
    fi
    exit 0
}

# Trap Ctrl+C (SIGINT)
trap cleanup SIGINT

# Wait for n8n to finish
wait $n8n_pid
