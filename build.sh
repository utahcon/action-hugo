#!/usr/bin/env bash

echo "Hugo Builder"

UUID=$(uuidgen)
BUILD_DIR=/tmp/build_${UUID}
mkdir "${BUILD_DIR}"

LATEST=$(
  echo "Copying to Build Dir: ${BUILD_DIR}" >&2
  cp -r . "${BUILD_DIR}"
  cd "${BUILD_DIR}" || exit 1

  echo "Updating Submodules" >&2
  git submodule foreach git pull origin master

  echo "Installing Hugo" >&2
  LATEST=$(
    cd hugo || exit
    LATEST=$(git tag | sort -rV | head -n 1)
    git checkout "${LATEST}"
    go install --tags extended
    mv "${HOME}"/go/bin/hugo .
    echo "${LATEST}"
  )
  echo "Installed version: ${LATEST}" >&2

  echo "Creating action.yml" >&2
  sed "s/%%version%%/${LATEST}/" action.yml.tmp >action.yml

  echo "Commit new action.yml" >&2
  git add action.yml
  git commit -m "Updating action.yml with version ${LATEST}"
  git push origin :refs/tags/${LATEST}
  git push origin :refs/tags/latest
  git tag -af "${LATEST}" -m "Version ${LATEST}"
  git tag -af latest -m "Version ${LATEST}"
  git push --tags
  echo "${LATEST}"
)

echo "Building Container"
podman build . -t utahcon/hugo:${LATEST}
