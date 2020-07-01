#!/usr/bin/env bash

echo "Hugo Builder"

UUID=$(uuidgen)
BUILD_DIR=/tmp/build_${UUID}
mkdir "${BUILD_DIR}"

LATEST=$(
  echo "Copying to Build Dir: ${BUILD_DIR}" >&2
  cp -r . "${BUILD_DIR}" >&2
  cd "${BUILD_DIR}" || exit 1

  echo "Updating Submodules" >&2
  git submodule foreach git pull origin master >&2

  echo "Installing Hugo" >&2
  LATEST=$(
    cd hugo || exit
    LATEST=$(git tag | sort -rV | head -n 1) >&2
    git checkout "${LATEST}" >&2
    go install --tags extended >&2
    mv "${HOME}"/go/bin/hugo . >&2
    echo "${LATEST}"
  )
  echo "Installed version: ${LATEST}" >&2

  echo "Creating action.yml" >&2
  sed "s/%%version%%/${LATEST}/" action.yml.tmp >action.yml >&2

  echo "Commit new action.yml" >&2
  git checkout -b ${LATEST} >&2
  git add action.yml >&2
  git commit -m "Updating action.yml with version ${LATEST}" >&2
  git push origin :refs/tags/latest  >&2
  git tag -af latest -m "Version ${LATEST}"  >&2
  git push origin ${LATEST} --tags >&2

  echo "${LATEST}"
)

echo "Building Container"
podman build . -t utahcon/hugo:"${LATEST}"
