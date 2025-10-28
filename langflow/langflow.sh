#!/bin/bash

# Change to the target directory
cd /home/riadh/dev/ai-automation/langflow || { echo "Directory not found"; exit 1; }

# Run the command
source ./ai/bin/activate

# Run the command
uv run langflow run
