#!/bin/bash
cd dev/ai-automation/n8n || exit 1
exec npx n8n start --tunnel
