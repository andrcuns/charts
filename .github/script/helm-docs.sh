#!/bin/bash

set -euo pipefail

source "$(dirname "$0")/utils.sh"

log "Fetch master"
git fetch origin master

CHARTS=$(changed-charts)

if [ -z "$CHARTS" ]; then
  log "No chart changes detected."
  exit
fi

install-helmdocs

helm-docs -c charts
git diff --exit-code
