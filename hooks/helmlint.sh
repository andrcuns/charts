#!/bin/bash

set -e

# Source
# https://github.com/gruntwork-io/pre-commit/blob/master/hooks/helmlint.sh

# Take the current working directory to know when to stop walking up the tree
readonly cwd_abspath="$(realpath "$PWD")"

# https://stackoverflow.com/a/8574392
# Usage: contains_element "val" "${array[@]}"
# Returns: 0 if there is a match, 1 otherwise
contains_element() {
  local -r match="$1"
  shift

  for e in "$@"; do
    if [[ "$e" == "$match" ]]; then
      return 0
    fi
  done
  return 1
}

# Only log debug statements if PRECOMMIT_DEBUG environment variable is set.
# Log to stderr.
debug() {
  if [[ ! -z $PRECOMMIT_DEBUG ]]; then
    echo >&2 "$@"
  fi
}

# Recursively walk up the tree until the current working directory and check if the changed file is part of a helm
# chart. Helm charts have a Chart.yaml file.
chart_path() {
  local -r changed_file="$1"

  # We check both the current dir as well as the parent dir, in case the current dir is a file
  local -r changed_file_abspath="$(realpath "$changed_file")"
  local -r changed_file_dir="$(dirname "$changed_file_abspath")"

  debug "Checking directory $changed_file_abspath and $changed_file_dir for Chart.yaml"

  # Base case: we have walked to the top of dir tree
  if [[ "$changed_file_abspath" == "$cwd_abspath" ]]; then
    debug "No chart path found"
    echo ""
    return 0
  fi

  # The changed file is itself the helm chart indicator, Chart.yaml
  if [[ "$(basename "$changed_file_abspath")" == "Chart.yaml" ]]; then
    debug "Chart path found: $changed_file_dir"
    echo "$changed_file_dir"
    return 0
  fi

  # The changed_file is the directory containing the helm chart package file
  if [[ -f "$changed_file_abspath/Chart.yaml" ]]; then
    debug "Chart path found: $changed_file_abspath"
    echo "$changed_file_abspath"
    return 0
  fi

  # The directory of changed_file is the directory containing the helm chart package file
  if [[ -f "$changed_file_dir/Chart.yaml" ]]; then
    debug "Chart path found: $changed_file_dir"
    echo "$changed_file_dir"
    return 0
  fi

  # None of the above, so recurse and do again in the parent dir
  chart_path "$changed_file_dir"
}

# An array to keep track of which charts we already linted
seen_chart_paths=()

for file in "$@"; do
  debug "Checking $file"
  file_chart_path=$(chart_path "$file")
  debug "Resolved $file to chart path $file_chart_path"

  if [[ ! -z "$file_chart_path" ]]; then
    if contains_element "$file_chart_path" "${seen_chart_paths[@]}"; then
      debug "Already linted $file_chart_path"
    else
      # Run against all combinations of ci-values.yaml files
      for yaml in $file_chart_path/ci/ci-*.yaml; do
        echo "Validating $file_chart_path with values from $yaml"
        helm lint -f "$yaml" "$file_chart_path"
      done
      seen_chart_paths+=("$file_chart_path")
    fi
  fi
done
