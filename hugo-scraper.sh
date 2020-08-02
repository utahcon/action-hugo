#!/usr/bin/env bash

# scrape the help info from Hugo to create better action.yml

# left trimming!
function trim_left {
  # shellcheck disable=SC2001
  echo "${1}" | sed -e "s/^\s*//"
}

INPUTS=""

IFS=$'\n'

