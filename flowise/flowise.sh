#!/bin/bash
cd path/to/flowise || exit 1
export PORT=3030
exec npx flowise start