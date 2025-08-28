#!/bin/bash
cd dev/ai-automation/flowise || exit 1
export PORT=3030
exec npx flowise start
