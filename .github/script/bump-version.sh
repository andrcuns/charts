#!/bin/bash

set -euo pipefail

source "$(dirname "$0")/utils.sh"

chart=$1
version_segment=$2

log "bump chart version"
helm local-chart-version bump -c charts/$chart -s $version_segment

log
log "update docs"
helm-docs -c charts/$chart

log
log "create release commit"
version=$(helm local-chart-version get -c charts/$chart)
git commit -a -m "$chart: Update chart to version $version"

log "push changes"
git push
