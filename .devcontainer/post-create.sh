#!/bin/bash

npm install -g @anthropic-ai/claude-code
npm install -g prettier
npm install -g baedal

if [ -f /workspaces/general/.env ]; then
  grep -v '^#' /workspaces/general/.env | sed 's/^/export /' >> ~/.bashrc
fi
