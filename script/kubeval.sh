#!/bin/bash
set -euo pipefail

function log() {
  echo -e "\033[1;33m$1\033[0m"
}

KUBEVAL_SOURCE="https://github.com/instrumenta/kubeval/releases/download/${KUBEVAL_VERSION}/kubeval-linux-amd64.tar.gz"

if [ ! -f "kubeval" ]; then
  log "Downloading kubeval v${KUBEVAL_VERSION}"
  curl --silent --show-error --fail --location --output /tmp/kubeval.tar.gz "${KUBEVAL_SOURCE}" && tar -xf /tmp/kubeval.tar.gz kubeval
fi

git fetch origin master >/dev/null 2>&1

CHARTS=$(git diff --find-renames --name-only "$(git rev-parse --abbrev-ref HEAD)" remotes/origin/master -- charts | cut -d/ -f 1-2 | sort | uniq)

if [ -z "$CHARTS" ]; then
  log "No chart changes detected."
  exit
fi

# validate charts
for CHART_DIR in "$CHARTS"; do
  log "Validating $CHART_DIR"
  helm template "${CHART_DIR}" | ./kubeval --strict
done
