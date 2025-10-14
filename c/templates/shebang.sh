#!/usr/bin/env bash
# shellcheck disable=SC2004,SC2206,SC2068,SC2086

set -e
set -o pipefail
export IFS=$'\n'

script_name="$(basename "${BASH_SOURCE[0]}")"
script_path="$(2>/dev/random 1>/dev/random cd $(dirname "${this_script_path}") && pwd)"
this_script_path="${script_path}/${script_name}"

declare -a argv=($@)
declare -i argc=${#argv[@]}

1>&2 echo -e "\x1b[1;38;5;220m${script_name}\x1b[0m received ${argc} arguments"

if [ ${argc} -gt 0 ]; then
    for index in ${!argv[@]}; do
        current=$(( $index + 1 ))
        1>&2 echo -e "    \x1b[1;38;5;231m${current}. \x1b[1;38;5;27m${arg@Q}\x1b[0m"
    done
fi
