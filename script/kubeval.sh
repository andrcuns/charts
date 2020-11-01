#!/bin/bash
set -euo pipefail

function log() {
  echo -e "\033[1;33m$1\033[0m"
}

CT_SOURCE="https://github.com/helm/chart-testing/releases/download/v${CT_VERSION}/chart-testing_${CT_VERSION}_linux_amd64.tar.gz"
KUBEVAL_SOURCE="https://github.com/instrumenta/kubeval/releases/download/${KUBEVAL_VERSION}/kubeval-linux-amd64.tar.gz"

# install ct
curl --silent --show-error --fail --location --output /tmp/ct.tar.gz "${CT_SOURCE}" && tar -xf /tmp/ct.tar.gz ct

# install kubeval
curl --silent --show-error --fail --location --output /tmp/kubeval.tar.gz  "${KUBEVAL_SOURCE}" && tar -xf /tmp/kubeval.tar.gz kubeval

# validate charts
for CHART_DIR in $(./ct list-changed); do
  log "Validating $CHART_DIR"
  helm template "${CHART_DIR}" | ./kubeval --strict --kubernetes-version "${KUBERNETES_VERSION}"
done
