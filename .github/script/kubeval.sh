#!/bin/bash

set -euo pipefail

source "$(dirname "$0")/utils.sh"

log "Fetch master"
git fetch origin master

charts=($(changed-charts))

if [ ${#charts[@]} -eq 0 ]; then
  log "No chart changes detected."
  exit
fi

install-kubeval

for chart_dir in "${charts[@]}"; do
  values_yaml="$chart_dir/ci/ci-values.yaml"
  values_opt=$([ -f "$values_yaml" ] && echo "-f $values_yaml" || echo "")

  log "Validating $chart_dir"
  helm dependency build $chart_dir
  helm template $chart_dir $values_opt
done
