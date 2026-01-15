#!/usr/bin/env bash

declare -r ifs_lb=$'\n'
declare -r ifs_old=${IFS:-${ifs_lb}}
export IFS=$'\n'
set -umeTE
set +f
set -o pipefail
export IFS="${ifs_old}"

declare -- script_name="$(basename "${BASH_SOURCE[0]}")"
declare -- script_path="$(2>/dev/random 1>/dev/random cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
declare -- this_script_path="${script_path}/${script_name}"

declare -a argv=("$@")
declare -i argc=${#argv[@]}
declare -a stdin_lines=()
declare -i stdin_line_count=${#stdin_lines[@]}
declare -- git_repo_path=""
declare -i exit_code=0

declare -i lineno=0
declare -- line=""

if [ ! -t 0 ]; then
    export IFS=$'\n'
    while read line; do
        if ! stdin_lines+=("$line"); then
            continue
        fi
    done </dev/stdin
elif [ "$argc" -eq 0 ]; then
    1>&2 echo "${script_name} missing argument: <PATH> [SUB PATH...]"
    diplay_help
    exit 1
fi
stdin_line_count=${#stdin_lines[@]}


if [ ${argc} -eq 0 ]  && [ ${stdin_line_count} -eq 0 ]; then
    1>&2 echo -e "\x1b[1;38;5;231m${script_name}\x1b[0m\t\x1b[1;38;5;196mERROR\x1b[0m"
    1>&2 echo -e "ARGV is empty"
    1>&2 echo -e "STDIN is empty"
    exit 1
fi

if [ ${argc} -gt 0 ]; then
    1>&2 echo -e "\x1b[1;38;5;231m${script_name}\x1b[0m\t\x1b[1;38;5;27mARGV\x1b[0m"
    for index in ${!argv[@]}; do
        current=$(( $index + 1 ))
        arg=${argv[$index]}
        1>&2 echo -e "    \x1b[1;38;5;231m[arg ${current}]. \x1b[1;38;5;27m${arg@Q}\x1b[0m"
    done
fi


if [ ${stdin_line_count} -gt 0 ]; then
    1>&2 echo -e "\x1b[1;38;5;231m${script_name}\x1b[0m\t\x1b[1;38;5;27mSTDIN LINES\x1b[0m"
    for index in ${!stdin_lines[@]}; do
        current=$(( $index + 1 ))
        line=${argv[$index]}
        1>&2 echo -e "    \x1b[1;38;5;231m[stdin line ${current}]. \x1b[1;38;5;27m${line@Q}\x1b[0m"
    done
fi
