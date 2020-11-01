#!/bin/bash

set -euo pipefail

source "$(dirname "$0")/utils.sh"

install-helmdocs

helm-docs -c charts
git diff --exit-code
