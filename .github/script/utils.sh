#!/bin/bash

function log() {
  echo -e "\033[1;33m$1\033[0m"
}

function changed-charts() {
  git diff --find-renames --name-only "$(git rev-parse --abbrev-ref HEAD)" remotes/origin/master -- charts | cut -d/ -f 1-2 | sort | uniq
}

function install-kubeval() {
  KUBEVAL_SOURCE="https://github.com/instrumenta/kubeval/releases/download/${KUBEVAL_VERSION}/kubeval-linux-amd64.tar.gz"

  log "Downloading kubeval v${KUBEVAL_VERSION}"
  curl --silent --show-error --fail --location --output /tmp/kubeval.tar.gz "${KUBEVAL_SOURCE}"
  tar -xf /tmp/kubeval.tar.gz kubeval
  sudo mv kubeval /usr/local/bin/
}

function install-helmdocs() {
  HELMDOCS_SOURCE="https://github.com/norwoodj/helm-docs/releases/download/v${HELMDOCS_VERSION}/helm-docs_${HELMDOCS_VERSION}_Linux_x86_64.tar.gz"

  log "Downloading helm-docs v${HELMDOCS_VERSION}"
  curl --silent --show-error --fail --location --output /tmp/helmdocs.tar.gz "${HELMDOCS_SOURCE}"
  tar -xf /tmp/helmdocs.tar.gz helm-docs
  sudo mv helm-docs /usr/local/bin/
}
