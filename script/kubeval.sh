#!/bin/bash
set -euo pipefail

function log() {
  echo -e "\033[1;33m$1\033[0m"
}

KUBEVAL_DIR="tools"
KUBEVAL="$KUBEVAL_DIR/kubeval"
CT="$KUBEVAL_DIR/ct"
CT_SOURCE="https://github.com/helm/chart-testing/releases/download/v${CT_VERSION}/chart-testing_${CT_VERSION}_linux_amd64.tar.gz"
KUBEVAL_SOURCE="https://github.com/instrumenta/kubeval/releases/download/${KUBEVAL_VERSION}/kubeval-linux-amd64.tar.gz"

if [ ! -d "$KUBEVAL_DIR" ]; then
  mkdir -p "$KUBEVAL_DIR"

  log "Downloading chart-testing v${CT_VERSION}"
  curl --silent --show-error --fail --location --output /tmp/ct.tar.gz "${CT_SOURCE}" && tar -xf /tmp/ct.tar.gz ct

  log "Downloading kubeval v${KUBEVAL_VERSION}"
  curl --silent --show-error --fail --location --output /tmp/kubeval.tar.gz "${KUBEVAL_SOURCE}" && tar -xf /tmp/kubeval.tar.gz kubeval

  mv ct kubeval $KUBEVAL_DIR/
fi

CHARTS=$(./$CT list-changed)

if [ -z "$CHARTS" ]; then
  log "No chart changes detected."
  exit
fi

# validate charts
for CHART_DIR in "$CHARTS"; do
  log "Validating $CHART_DIR"
  helm template "${CHART_DIR}" | ./$KUBEVAL --strict
done
