#!/usr/bin/env bash

ARGUMENTS=""

# Handle Arguments
arg_pos=1

while (( "$#" )); do
  if [[ -n $1 ]]; then
    case $arg_pos in 
      1) ARGUMENTS+="--baseURL ${1} ";;
      2) ARGUMENTS+="--buildDrafts ${1} ";;
      3) ARGUMENTS+="--buildExpired ${1} ";;
      4) ARGUMENTS+="--buildFuture ${1} ";;
      5) ARGUMENTS+="--cacheDir ${1} ";;
      6) ARGUMENTS+="--cleanDestinationDir ${1} ";;
      7) ARGUMENTS+="--config ${1} ";;
      8) ARGUMENTS+="--configDir ${1} ";;
      9) ARGUMENTS+="--contentDir ${1} ";;
      10) ARGUMENTS+="--debug ${1} ";;
      11) ARGUMENTS+="--destination ${1} ";;
      12) ARGUMENTS+="--disableKinds ${1} ";;
      13) ARGUMENTS+="--enableGitInfo ${1} ";;
      14) ARGUMENTS+="--environment ${1} ";;
      15) ARGUMENTS+="--forceSyncStatic ${1} ";;
      16) ARGUMENTS+="--gc ${1} ";;
      17) ARGUMENTS+="--help ${1} ";;
      18) ARGUMENTS+="--i18n-warnings ${1} ";;
      19) ARGUMENTS+="--ignoreCache ${1} ";;
      20) ARGUMENTS+="--ignoreVendor ${1} ";;
      21) ARGUMENTS+="--layoutDir ${1} ";;
      22) ARGUMENTS+="--log ${1} ";;
      23) ARGUMENTS+="--logFile ${1} ";;
      24) ARGUMENTS+="--minify ${1} ";;
      25) ARGUMENTS+="--noChmod ${1} ";;
      26) ARGUMENTS+="--noTimes ${1} ";;
      27) ARGUMENTS+="--path-warnings ${1} ";;
      28) ARGUMENTS+="--quiet ${1} ";;
      29) ARGUMENTS+="--renderToMemory ${1} ";;
      30) ARGUMENTS+="--source ${1} ";;
      31) ARGUMENTS+="--templateMetrics ${1} ";;
      32) ARGUMENTS+="--templateMetricsHints ${1} ";;
      33) ARGUMENTS+="--theme ${1} ";;
      34) ARGUMENTS+="--themesDir ${1} ";;
      35) ARGUMENTS+="--trace ${1} ";;
      36) ARGUMENTS+="--verbose ${1} ";;
      37) ARGUMENTS+="--verboseLog ${1} ";;
      38) ARGUMENTS+="--watch ${1} ";;
    esac
  fi
  arg_pos=$((arg_pos+1))
  shift
done

(
  cd "${GITHUB_WORKSPACE}" || exit 1;
  /hugo --cleanDestinationDir "${ARGUMENTS}";
)
