#!/bin/bash

set -e

source "$(dirname "$0")/utils.sh"

chart=$1
version_segment=$2

log "setup git"
git config user.name github-actions
git config user.email github-actions@github.com

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
