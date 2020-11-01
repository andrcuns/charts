#!/bin/bash
set -euo pipefail

CT_SOURCE="https://github.com/helm/chart-testing/releases/download/v${CT_VERSION}/chart-testing_${CT_VERSION}_linux_amd64.tar.gz"
KUBEVAL_SOURCE="https://github.com/instrumenta/kubeval/releases/download/${KUBEVAL_VERSION}/kubeval-linux-amd64.tar.gz"
SCHEMA_LOCATION="https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/"

# install ct
echo "Download ct"
curl --silent --show-error --fail --location --output /tmp/ct.tar.gz "${CT_SOURCE}" && tar -xf /tmp/ct.tar.gz ct

# install kubeval
echo "Download kubeval"
curl --silent --show-error --fail --location --output /tmp/kubeval.tar.gz  "${KUBEVAL_SOURCE}" && tar -xf /tmp/kubeval.tar.gz kubeval

./ct version

# validate charts
for CHART_DIR in $(./ct list-changed); do
  helm template "${CHART_DIR}" | ./kubeval --strict --ignore-missing-schemas --kubernetes-version "${KUBERNETES_VERSION}" --schema-location "${SCHEMA_LOCATION}"
done
