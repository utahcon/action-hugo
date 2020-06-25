#!/usr/bin/env bash

echo "Hugo Builder"

echo "Updating Submodules"
git submodule foreach git pull origin master

echo "Installing Hugo"
(
  cd hugo || exit;
  go install --tags extended
  cp "${HOME}"/go/bin/hugo .
  ./hugo version
)

echo "Building Container"
podman build . -t utahcon/hugo:local
