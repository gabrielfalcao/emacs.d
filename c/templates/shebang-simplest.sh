#!/usr/bin/env bash

set -e
set -o pipefail
export IFS=$'\n'

declare -a argv=($@)
declare -i argc=${#argv[@]}

1>&2 echo -e "\x1b[1;38;5;220m${script_name}\x1b[0m received ${argc} arguments"
