#!/bin/bash

function log() {
  echo -e "\033[1;33m$1\033[0m"
}

function changed-charts() {
  git diff --find-renames --name-only "$(git rev-parse --abbrev-ref HEAD)" remotes/origin/main -- charts | cut -d/ -f 1-2 | sort | uniq
}
