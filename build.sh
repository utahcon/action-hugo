#!/usr/bin/env bash

echo "Hugo Builder"

echo "Cloning Hugo"
git clone https://github.com/gohugoio/hugo.git hugo

echo "Installing Hugo"
cd hugo || exit
LATEST=$(git tag | sort -rV | head -n 1)
git checkout "${LATEST}"
go install --tags extended
cp "${HOME}"/Projects/bin/hugo .
ls -al
chmod +x hugo
./hugo version
cd ..

echo "Building Container"
podman build . -t utahcon/hugo:"${LATEST}"

