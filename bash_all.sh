#!/usr/bin/env bash

echo "Hugo Builder"

echo "Cloning Hugo"
git clone https://github.com/gohugoio/hugo.git hugo

echo "Installing Hugo"
cd hugo || exit

for TAG in $(git tag | sort -rV); do
  git checkout "${TAG}"
  go install --tags extended
  cp "${HOME}"/Projects/bin/hugo .
  chmod +x hugo
  ./hugo version
  cd ..

echo "Building Container"
podman build . -t utahcon/hugo:"${LATEST}"

