#!/bin/bash

function log() {
  echo -e "\033[1;33m$1\033[0m"
}

function changed-charts() {
  git diff --find-renames --name-only "$(git rev-parse --abbrev-ref HEAD)" remotes/origin/main -- charts | cut -d/ -f 1-2 | sort | uniq
}

function install-kubeconform() {
  KUBECONFORM_VERSION="v0.6.6"
  KUBECONFORM_SOURCE="https://github.com/yannh/kubeconform/releases/download/${KUBECONFORM_VERSION}/kubeconform-linux-amd64.tar.gz"

  log "Installing kubeconform ${KUBECONFORM_VERSION}"
  curl --silent --show-error --fail --location --output /tmp/kubeconform.tar.gz "${KUBECONFORM_SOURCE}"
  tar -xf /tmp/kubeconform.tar.gz kubeconform
  sudo mv kubeconform /usr/local/bin/
}

function install-helmdocs() {
  HELMDOCS_VERSION="1.14.2"
  HELMDOCS_SOURCE="https://github.com/norwoodj/helm-docs/releases/download/v${HELMDOCS_VERSION}/helm-docs_${HELMDOCS_VERSION}_Linux_x86_64.tar.gz"

  log "Installing helm-docs ${HELMDOCS_VERSION}"
  curl --silent --show-error --fail --location --output /tmp/helmdocs.tar.gz "${HELMDOCS_SOURCE}"
  tar -xf /tmp/helmdocs.tar.gz helm-docs
  sudo mv helm-docs /usr/local/bin/
}

function install-local-chart-version() {
  log "Installing local-chart-version helm plugin"
  helm plugin install https://github.com/mbenabda/helm-local-chart-version
}
