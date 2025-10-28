#!/bin/bash
cd path/to/n8n || exit 1
exec npx n8n start --tunnel
