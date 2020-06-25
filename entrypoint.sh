#!/usr/bin/env bash
set -euo pipefail

# Get into the workspace
cd "${GITHUB_WORKSPACE}";

# Show what is here before we run hugo
ls -A;

# Run hugo
hugo;

# Show what is here after running hugo
ls -A;
