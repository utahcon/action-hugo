#!/usr/bin/env bash
set -o pipefail
set -o errexit

# import https://github.com/UrsaDK/getopts_long
source ./getopts_long.bash

# set some variables
HUGO_URL="https://github.com/gohugoio/hugo.git"
ACTION_URL="https://github.com/utahcon/action-hugo"

set +o nounset
if [ -z $GITHUB_ACTIONS ]; then GITHUB_ACTIONS=false; fi
set -o nounset


function get_version {
  echo "---"
  echo "Determine ${1} Version"
  if [ -d $1 ]; then
    cd "$1" || exit
    VERSION=$(git tag | sort -rV | head -n 1)
    if [ "${GITHUB_ACTIONS}" == "true" ]; then
      echo "::set-output name=version::${VERSION}"
    else
      echo "${VERSION}"
    fi
  else
    echo "$1 is not checked out, please run: $0 --clone-$1"
  fi
}

function cleanup {
  echo "---"
  echo "Cleaning Up Hugo and Builder"
  rm -Rf hugo
  rm -Rf builder
}

function clone {
  set +o nounset
  REPO=$1
  DIR=$2
  VERSION=$3
  set -o nounset
  git clone $REPO $DIR
  if [ -n $VERSION ]; then
    git checkout $VERSION
  fi
}

function runner {
  echo "Hugo Build Checker"
  if [ "${GITHUB_ACTIONS}" != "true" ]; then
    cleanup
    clone https://github.com/gohugoio/hugo.git hugo
    clone https://github.com/utahcon/action-hugo builder
  fi

}

while getopts_long ":h: hugo-version action-version clone-hugo clone-action" opt; do
  case $opt in
    "h"|"hugo-version" )
      get_version hugo;;
    "action-version" )
      get_version action;;
    "clone-hugo" )
      clone $HUGO_URL hugo;;
    "clone-action" )
      clone $ACTION_URL action;;
    * )
      runner;;
  esac
done

for BUILDER_VERION in ${BUILDER_VERSIONS}; do
  echo "${BUILDER_VERION}"
  if [ "${BUILDER_VERSION}" == "${HUGO_VERSION}" ]; then
    MUST_BUILD=0
  fi
done

echo "---"
if [ ${MUST_BUILD} ]; then
  echo "Build Builder Version ${HUGO_VERSION}"
  echo -e "${HUGO_VERSION}" > BUILD_VERSION
fi
