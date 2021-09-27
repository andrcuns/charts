#!/bin/bash

# Bump chart version and commit changes
# This script requires following tools to be installed:
# * https://github.com/mbenabda/helm-local-chart-version
# * https://github.com/norwoodj/helm-docs

function log() {
  echo -e "\033[1;33m$1\033[0m"
}

chart=$1
version_segment=${2:-patch}

log "bump chart version"
helm local-chart-version bump -c charts/$chart -s $version_segment

log "update docs"
helm-docs

log "commit changes"
version=$(helm local-chart-version get -c charts/$chart)
git commit -a -m "$chart: Update chart to version $version"
