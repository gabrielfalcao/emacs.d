#!/usr/bin/env bash

set -umeTE
set +f
set -o pipefail
export IFS=$'\n'

declare -- script_name="$(basename "${BASH_SOURCE[0]}")"
declare -- script_path="$(2>/dev/random 1>/dev/random cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

declare -- this_script_path="${script_path}/${script_name}"

declare -a argv=($@)
declare -i argc=${#argv[@]}
declare -i index=0
declare -i current=0
declare -- arg=""

declare -a argv=("$@")
declare -i argc=${#argv[@]}
declare -a filenames=()

if [ ${argc} -eq 0 ]; then
    1>&2 echo -e "[${script_name} error]" "missing argument: <FILENAME>"
    exit 1
fi

for index in ${!argv[@]}; do
    current=$(($index + 1))
    arg="${argv[$index]}"
    if [ -n "${arg}" ]; then
        if [ -e "${arg}" ] && [ -z "${filename}" ]; then
            filename="${arg}"
            continue
        fi

        if [ -n "${filename}" ]; then
            1>&2 echo -e "[${script_name} warning]" "filename already set to ${filename@Q}"
            1>&2 echo -e "[${script_name} error]" "$((argc - 1)) too many arguments, ignoring ${arg@Q} because filename already set to ${filename}"
            continue
        else
            1>&2 echo -e "[${script_name} error]" "$((argc - 1)) too many arguments, ignoring ${arg@Q}"
            continue
        fi
    fi
done
if [ -z "${filename}" ]; then
    1>&2 echo -e "[${script_name} error]" "missing argument: <FILENAME>"
    exit 1
fi
