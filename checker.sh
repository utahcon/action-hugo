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
(
  cd "${WORKSPACE}/hugo"
  git fetch --all
)
H_VERSION=$(
  cd "${WORKSPACE}/hugo"
  git tag | sort -rV | head -n 1
)
echo "Hugo: '${H_VERSION}'"

# Checkout action-hugo
git clone ${ACTION_URL} "${WORKSPACE}/action"
(
  cd "${WORKSPACE}/action"
  git fetch --all
)
A_VERSIONS=$(
  cd "${WORKSPACE}/action"
  git tag | sort -rV
)
echo "Action: '${A_VERSIONS}'"

for AV in ${A_VERSIONS}; do
  echo "'${AV}' == '${H_VERSION}'"
  if [ "${AV}" == "${H_VERSION}" ]; then
    exit
  fi
done

echo "Kick Build"
cleanup