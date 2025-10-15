#!/usr/bin/env bash

set -e
set -o pipefail
set -o noglob
set -u
export IFS=$'\n'

declare -a argv=($@)
declare -i argc=${#argv[@]}

script_name="$(basename "${BASH_SOURCE[0]}")"

1>&2 echo -e "\x1b[1;38;5;220m${script_name}\x1b[0m received \x1b[1;38;5;254m${argc} arguments\x1b[0m"
