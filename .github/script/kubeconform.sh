#!/bin/bash

set -euo pipefail

source "$(dirname "$0")/utils.sh"

charts=($(changed-charts))

if [ ${#charts[@]} -eq 0 ]; then
  log "No chart changes detected!"
  exit
fi

install-kubeconform

for chart_dir in "${charts[@]}"; do
  for yaml in $chart_dir/ci/ci-*.yaml; do
    values_opt=$([ -f "$yaml" ] && echo "-f $yaml" || echo "")

    message="Validating $chart_dir with $yaml"
    length=$(echo "$message" | awk '{print length}')
    delimiter=$(head -c $length </dev/zero | tr '\0' '=')

    log "$delimiter"
    log "$message"
    log "$delimiter"

    helm dependency update $chart_dir
    helm template $chart_dir $values_opt | kubeconform -strict -output tap
  done
done
