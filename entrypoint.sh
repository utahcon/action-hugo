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
      21) ARGUMENTS+="--ignoreVendorPaths ${1} ";;
      22) ARGUMENTS+="--layoutDir ${1} ";;
      23) ARGUMENTS+="--log ${1} ";;
      24) ARGUMENTS+="--logFile ${1} ";;
      25) ARGUMENTS+="--minify ${1} ";;
      26) ARGUMENTS+="--noChmod ${1} ";;
      27) ARGUMENTS+="--noTimes ${1} ";;
      28) ARGUMENTS+="--path-warnings ${1} ";;
      29) ARGUMENTS+="--print-mem ${1} ";;
      30) ARGUMENTS+="--quiet ${1} ";;
      31) ARGUMENTS+="--renderToMemory ${1} ";;
      32) ARGUMENTS+="--source ${1} ";;
      33) ARGUMENTS+="--templateMetrics ${1} ";;
      34) ARGUMENTS+="--templateMetricsHints ${1} ";;
      35) ARGUMENTS+="--theme ${1} ";;
      36) ARGUMENTS+="--themesDir ${1} ";;
      37) ARGUMENTS+="--trace ${1} ";;
      38) ARGUMENTS+="--verbose ${1} ";;
      39) ARGUMENTS+="--verboseLog ${1} ";;
      40) ARGUMENTS+="--watch ${1} ";;
    esac
  fi
  arg_pos=$((arg_pos+1))
  shift
done

(
  cd "${GITHUB_WORKSPACE}" || exit 1;
  /hugo --cleanDestinationDir "${ARGUMENTS}";
)
