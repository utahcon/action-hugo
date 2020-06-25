#!/usr/bin/env bash

ARGUMENTS=""

# Handle Arguments
arg_pos=1

while (( "$#" )); do
  if [[ -n $1 ]]; then
    case $arg_pos in
      1) ARGUMENTS+="-b ${1} ";;
      2) ARGUMENTS+="-D ${1} ";;
      3) ARGUMENTS+="-E ${1} ";;
      4) ARGUMENTS+="-F ${1} ";;
      5) ARGUMENTS+="--config ${1} ";;
      6) ARGUMENTS+="--configDir ${1} ";;
      7) ARGUMENTS+="--configDir ${1} ";;
      8) ARGUMENTS+="-c ${1} ";;
      9) ARGUMENTS+="--debug ${1} ";;
      10) ARGUMENTS+="--enableGitInfo ${1} ";;
      11) ARGUMENTS+="--environment ${1} ";;
      12) ARGUMENTS+="--i18n-warnings ${1} ";;
      13) ARGUMENTS+="--ignoreVendor ${1} ";;
      14) ARGUMENTS+="-l ${1} ";;
      15) ARGUMENTS+="--minify ${1} ";;
      16) ARGUMENTS+="--noChmod ${1} ";;
      17) ARGUMENTS+="--noTimes ${1} ";;
      18) ARGUMENTS+="--path-warnings ${1} ";;
      19) ARGUMENTS+="-s ${1} ";;
      20) ARGUMENTS+="--templateMetrics ${1} ";;
      21) ARGUMENTS+="--templateMetricsHints ${1} ";;
      22) ARGUMENTS+="-t ${1} ";;
      23)ARGUMENTS+="--themesDir ${1} ";;
      24) ARGUMENTS+="-v ${1} ";;
    esac
  fi
  arg_pos=$((arg_pos+1))
  shift
done

(
  if [ -n "${GITHUB_ACTIONS}" ]; then
    cd "${GITHUG_WORKSPACE}";
  fi;
  echo "hugo ${ARGUMENTS}"
  ../hugo "${ARGUMENTS}"
)
