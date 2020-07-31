#!/usr/bin/env bash
# Script for local engineering of the Checker Workflow

# import https://github.com/UrsaDK/getopts_long
source ./getopts_long.bash

# set some variables
HUGO_URL="https://github.com/gohugoio/hugo.git"
ACTION_URL="https://github.com/utahcon/action-hugo"
if [ -z $GITHUB_ACTIONS ]; then GITHUB_ACTIONS=false; fi

# Turn on strict mode
set -euo pipefail

# Make temporary workspace
WORKSPACE=$(mktemp -d)

function cleanup {
  echo -e "\n\nCleaning up"
  rm -Rf "${WORKSPACE}"
}

trap cleanup EXIT

# Checkout hugo
git clone ${HUGO_URL} "${WORKSPACE}/hugo"
H_VERSION=$(
  cd "${WORKSPACE}/hugo"
  git fetch --all 1>&2
  git tag | sort -rV | head -n 1
)

# Checkout action-hugo
git clone ${ACTION_URL} "${WORKSPACE}/action"
(
  cd "${WORKSPACE}/action"
  git fetch --all
)

for AV in $(cd "${WORKSPACE}/action"; git tag); do
  echo "'${AV}' == '${H_VERSION}'"
  if [ "${AV}" == "${H_VERSION}" ]; then
    exit
  fi
done

echo "Kick Build"
cleanup