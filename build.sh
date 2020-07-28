#!/usr/bin/env bash
# Build a specific version of action-hugo

echo "Hugo Builder"

HUGO_VERSION=$(cat BUILD_VERSION)
echo "Build Version: ${HUGO_VERSION}"

if [ "${GITHUB_ACTIONS}" != "true" ]; then
  echo "Cleaning Up Hugo and Builder"
  rm -Rf hugo
  rm -Rf builder

  echo "Cloning Hugo"
  git clone https://github.com/gohugoio/hugo.git hugo
fi

echo "Checking out Hugo version ${HUGO_VERSION}"
(
  cd hugo || exit 1
  git checkout "${HUGO_VERSION}"
)

echo "Installing Hugo"
(
  cd hugo || exit 1
  go install --tags extended
  cp "${HOME}"/Projects/bin/hugo .
  chmod +x hugo
)

echo "Building Container"
podman build . -t utahcon/hugo:"${HUGO_VERSION}"

echo "Pushing Container"
podman push utahcon/hugo:"${HUGO_VERSION}"

echo "Creating branch ${HUGO_VERSION}"
git branch -D "${HUGO_VERSION}"
git checkout -b "${HUGO_VERSION}"

echo "Create action.yml"
sed "s/%%version%%/${HUGO_VERSION}}" action.tml.tmp > action.yml
git add action.yml
git commit -m "Updating action.yml with version ${HUGO_VERSION}"

