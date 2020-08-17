#!/usr/bin/env bash

HUGO_VERSION=$(
  cd hugo
  git fetch --all 1>&2
  git tag | sort -V
)

echo "Hugo Tags: ${HUGO_VERSION}"

ACTION_VERSION=$(
  git fetch --all 1>&2
  git tag | sort -V
)

echo "Action Tags: ${ACTION_VERSION}"