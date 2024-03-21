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
      7) ARGUMENTS+="--clock ${1} ";;
      8) ARGUMENTS+="--config ${1} ";;
      9) ARGUMENTS+="--configDir ${1} ";;
      10) ARGUMENTS+="--contentDir ${1} ";;
      11) ARGUMENTS+="--debug ${1} ";;
      12) ARGUMENTS+="--destination ${1} ";;
      13) ARGUMENTS+="--disableKinds ${1} ";;
      14) ARGUMENTS+="--enableGitInfo ${1} ";;
      15) ARGUMENTS+="--environment ${1} ";;
      16) ARGUMENTS+="--forceSyncStatic ${1} ";;
      17) ARGUMENTS+="--gc ${1} ";;
      18) ARGUMENTS+="--help ${1} ";;
      19) ARGUMENTS+="--ignoreCache ${1} ";;
      20) ARGUMENTS+="--ignoreVendorPaths ${1} ";;
      21) ARGUMENTS+="--layoutDir ${1} ";;
      22) ARGUMENTS+="--logLevel ${1} ";;
      23) ARGUMENTS+="--minify ${1} ";;
      24) ARGUMENTS+="--noBuildLock ${1} ";;
      25) ARGUMENTS+="--noChmod ${1} ";;
      26) ARGUMENTS+="--noTimes ${1} ";;
      27) ARGUMENTS+="--panicOnWarning ${1} ";;
      28) ARGUMENTS+="--poll ${1} ";;
      29) ARGUMENTS+="--printI18nWarnings ${1} ";;
      30) ARGUMENTS+="--printMemoryUsage ${1} ";;
      31) ARGUMENTS+="--printPathWarnings ${1} ";;
      32) ARGUMENTS+="--printUnusedTemplates ${1} ";;
      33) ARGUMENTS+="--quiet ${1} ";;
      34) ARGUMENTS+="--renderSegments ${1} ";;
      35) ARGUMENTS+="--renderToMemory ${1} ";;
      36) ARGUMENTS+="--source ${1} ";;
      37) ARGUMENTS+="--templateMetrics ${1} ";;
      38) ARGUMENTS+="--templateMetricsHints ${1} ";;
      39) ARGUMENTS+="--theme ${1} ";;
      40) ARGUMENTS+="--themesDir ${1} ";;
      41) ARGUMENTS+="--trace ${1} ";;
      42) ARGUMENTS+="--verbose ${1} ";;
      43) ARGUMENTS+="--watch ${1} ";;
    esac
  fi
  arg_pos=$((arg_pos+1))
  shift
done

(
  cd "${GITHUB_WORKSPACE}" || exit 1;
  /hugo --cleanDestinationDir "${ARGUMENTS}";
)
