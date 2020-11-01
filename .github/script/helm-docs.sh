#!/bin/bash

set -euo pipefail

source "$(dirname "$0")/utils.sh"

charts=($(changed-charts))

if [ ${#charts[@]} -eq 0 ]; then
  log "No chart changes detected."
  exit
fi

install-helmdocs

helm-docs -c charts
git diff --exit-code
