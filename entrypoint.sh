#!/usr/bin/env bash

ARGUMENTS=""

# Handle Arguments
arg_pos=1

while (( "$#" )); do
  if [[ -n $1 ]]; then
    case $arg_pos in
      1) ARGUMENTS+="-b ${1} ";;
      2) if [[ "true" == "$1" ]]; then ARGUMENTS+="-D "; fi;;
      3) if [[ "true" == "$1" ]]; then ARGUMENTS+="-E "; fi;;
      4) if [[ "true" == "$1" ]]; then ARGUMENTS+="-F "; fi;;
      5) ARGUMENTS+="--config ${1} ";;
      6) ARGUMENTS+="--configDir ${1} ";;
      7) ARGUMENTS+="-c ${1} ";;
      8) if [[ "true" == "$1" ]]; then ARGUMENTS+="--debug "; fi;;
      9) if [[ "true" == "$1" ]]; then ARGUMENTS+="--enableGitInfo "; fi;;
      10) ARGUMENTS+="--environment ${1} ";;
      11) if [[ "true" == "$1" ]]; then ARGUMENTS+="--i18n-warnings ${1} "; fi;;
      12) if [[ "true" == "$1" ]]; then ARGUMENTS+="--ignoreVendor ${1} "; fi;;
      13) ARGUMENTS+="-l ${1} ";;
      # 14) if [[ "true" == "$1" ]]; then ARGUMENTS+="--minify "; fi;;
      15) if [[ "true" == "$1" ]]; then ARGUMENTS+="--noChmod "; fi;;
      16) if [[ "true" == "$1" ]]; then ARGUMENTS+="--noTimes "; fi;;
      17) if [[ "true" == "$1" ]]; then ARGUMENTS+="--path-warnings "; fi ;;
      18) ARGUMENTS+="-s ${1} ";;
      19) if [[ "true" == "$1" ]]; then ARGUMENTS+="--templateMetrics "; fi;;
      20) if [[ "true" == "$1" ]]; then ARGUMENTS+="--templateMetricsHints "; fi;;
      21) ARGUMENTS+="-t ${1} ";;
      22) ARGUMENTS+="--themesDir ${1} ";;
      23) if [[ "true" == "$1" ]]; then ARGUMENTS+="-v"; fi;;
    esac
  fi
  arg_pos=$((arg_pos+1))
  shift
done

(
  if [ -n "${GITHUB_ACTIONS}" ]; then
    cd "${GITHUG_WORKSPACE}";
  fi;
  /hugo --cleanDestinationDir=true "${ARGUMENTS}"
)
