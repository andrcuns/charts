#!/bin/bash

set -e

source "$(dirname "$0")/utils.sh"

charts=($(changed-charts))

if [ ${#charts[@]} -eq 0 ]; then
  log "No chart changes detected!"
  exit
fi

install-helmdocs

log "Running helm-docs to validate if chart documentation is up-to-date..."
helm-docs -c charts
log "Checking if helm-docs produced any changes..."
git diff --color --exit-code
echo "docs are up to date!"
