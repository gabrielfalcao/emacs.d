#!/usr/bin/env bash

set -e
set -o pipefail
export IFS=$'\n'

this_script_path="${BASH_SOURCE[0]}"
script_name="$(basename "${this_script_path}")"
script_path="$(dirname "${this_script_path}")"

declare -a argv=($@)
declare -i argc=${#argv[@]}

1>&2 echo -e "\x1b[1;38;5;220m${script_name}\x1b[0m received ${argc} arguments"

if [ ${argc} -gt 0 ]; then
    for index in ${!argv[@]}; do
        current=$(( $index + 1 ))
        1>&2 echo -e "    \x1b[1;38;5;231m${current}. \x1b[1;38;5;27m${arg@Q}\x1b[0m"
    done
fi
