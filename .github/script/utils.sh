#!/bin/bash

function log() {
  echo -e "\033[1;33m$1\033[0m"
}

function changed-charts() {
  git diff --find-renames --name-only "$(git rev-parse --abbrev-ref HEAD)" remotes/origin/master -- charts | cut -d/ -f 1-2 | sort | uniq
}

function install-kubeconform() {
  KUBECONFORM_SOURCE="https://github.com/yannh/kubeconform/releases/download/v${KUBECONFORM_VERSION}/kubeconform-linux-amd64.tar.gz"

  log "Downloading kubeconform v${KUBECONFORM_VERSION}"
  curl --silent --show-error --fail --location --output /tmp/kubeconform.tar.gz "${KUBECONFORM_SOURCE}"
  tar -xf /tmp/kubeconform.tar.gz kubeconform
  sudo mv kubeconform /usr/local/bin/
}

function install-helmdocs() {
  HELMDOCS_SOURCE="https://github.com/norwoodj/helm-docs/releases/download/v${HELMDOCS_VERSION}/helm-docs_${HELMDOCS_VERSION}_Linux_x86_64.tar.gz"

  log "Downloading helm-docs v${HELMDOCS_VERSION}"
  curl --silent --show-error --fail --location --output /tmp/helmdocs.tar.gz "${HELMDOCS_SOURCE}"
  tar -xf /tmp/helmdocs.tar.gz helm-docs
  sudo mv helm-docs /usr/local/bin/
}
