#!/usr/bin/env bash
set -euo pipefail
# scrape the help info from Hugo to create better action.yml and entrypoint.sh

# left trimming!
function trim_left {
  # shellcheck disable=SC2001
  echo "${1}" | sed -e "s/^\s*//"
}

YML_INPUTS=""
YML_ARGS=""
ENTRY=""
IFS=$'\n'

COUNT=1

for FLAG in $(./hugo --help | grep "^\s*-.*"); do
#  echo -e "\n"
  FLAG=$(trim_left "${FLAG}")
#  echo "'${FLAG}'"

  # Get Short Flag
  SHORT=${FLAG%%--*}
  SHORT=$(trim_left "${SHORT}")
#  echo "Short:1:2 ${SHORT:1:1}"
  FLAG=${FLAG#*--}

  # Get Long Flag
  FLAG=$(trim_left "${FLAG}")
  LONG=${FLAG%% *}
  LONG=$(trim_left "${LONG}")
#  echo "Long: '${LONG}'"

  FLAG=${FLAG#* }
  ARG=${FLAG%% *}
#  echo "Arg: '${ARG}'"

  FLAG=${FLAG#* }
  DESC=$(trim_left "${FLAG}")
#  echo "Desc: '${DESC}'"

  YML_INPUTS+="\n  ${LONG}\:\n    description\: ${DESC}\n    required\: false"
  YML_ARGS+="\n    - \${{ inputs.${LONG} }}"
  ENTRY+="\n      ${COUNT}) ARGUMENTS+=\"--${LONG} \${1} \";;"

  README_INPUTS+="\n| ${LONG} | ${ARG} | ${DESC} |"

  ((COUNT=COUNT+1))
done

VERSION=$(cat BUILD_VERSION)

sed -i -e "s;%%INPUTS%%;${YML_INPUTS};" action.yml
sed -i -e "s/%%ARGS%%/${YML_ARGS}/" action.yml
sed -i -e "s/%%VERSION%%/${VERSION}/" action.yml

sed -i -e "s/%%ENTRY%%/${ENTRY}/" entrypoint.sh

sed -i -e "s;%%README_INPUTS%%;${README_INPUTS};" README.md
sed -i -e "s/%%VERSION%%/${VERSION}/" README.md
