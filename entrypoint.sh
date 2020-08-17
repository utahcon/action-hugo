#!/usr/bin/env bash

ARGUMENTS=""

# Handle Arguments
arg_pos=1

while (( "$#" )); do
  if [[ -n $1 ]]; then
    case $arg_pos in %%ENTRY%%
    esac
  fi
  arg_pos=$((arg_pos+1))
  shift
done

(
  cd "${GITHUB_WORKSPACE}" || exit 1;
  /hugo --cleanDestinationDir "${ARGUMENTS}";
)
