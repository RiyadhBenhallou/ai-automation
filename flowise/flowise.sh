#!/bin/bash

# Move to Flowise project directory
cd dev/ai-automation/flowise && PORT=3030 npx flowise start &
flowise_pid=$!

# Trap SIGINT (Ctrl+C) to kill Flowise process cleanly
trap "echo -e '\nStopping Flowise...'; kill $flowise_pid; exit" SIGINT

# Wait for the Flowise process to end
wait $flowise_pid
