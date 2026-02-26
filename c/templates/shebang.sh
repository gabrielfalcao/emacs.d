#!/usr/bin/env bash

set -umeTE
set +f
set -o pipefail
unset IFS
export IFS=$'\n'

declare -- script_name="$(basename "${BASH_SOURCE[0]}")"
declare -- script_path="$(2>/dev/random 1>/dev/random cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
declare -- this_script_path="${script_path}/${script_name}"

on_exit() {
    set +x
    1>/dev/null 2>/dev/null stty sane
}
on_ctrlc() {
    1>&2 echo -e "\x1b[1;38;2;253;67;83m\rAborted with Ctrl-C\x1b[0m"
    exit 130
}
trap on_exit exit
trap on_ctrlc hup
trap on_ctrlc int
trap on_ctrlc bus
trap on_ctrlc segv
trap on_ctrlc sys

declare -a argv=(${@})
declare -i argc=${#argv[@]}

declare -a stdin_lines=()
declare -i stdin_line_count=0

# has_params "boolean flag" - .i.e.:  "(( ${has_params} ))"
#
# "false' if the sum of ${argc} + ${stdin_line_count} is 0
# otherwise, otherwise 1 (or any positive integer: true)
declare -i has_params=$((argc))
has_params=$((argc + stdin_line_count))

declare -i code=0

declare -i current=0

declare -i index=0
declare -- arg=''
declare -- param=''

declare -i next_index=0
declare -- next_arg=''
declare -- next_param=''

declare -i skip_next=0

declare -i lineno=0
declare -i line_number=0
declare -- line=''

declare -- argument=''
declare -- field=''
declare -- key=''
declare -- name=''
declare -- path=''
declare -- value=''

declare -- stderr="$(mktemp)"

# <STDIN>
declare -a stdin_lines=()
declare -i stdin_line_count=0

if [ ! -t 0 ]; then
    export IFS=$'\n'
    while read line; do
        if ! stdin_lines+=("${line}"); then
            continue
        fi
    done </dev/stdin
fi
stdin_line_count=${#stdin_lines[@]}
has_params=$((argc + stdin_line_count))
# </STDIN>

# <GIT>
declare -- git_repo_path=""
if ! git_repo_path=$(2>${stderr} git rev-parse --show-toplevel); then
    code=$?
fi
# </GIT>
export IFS=$'\n'

main() {
    if ! ((${has_params})); then
        1>&2 echo "[${script_name} error] missing command-line arguments (or stdin data)"
        exit 1
    fi

    for index in ${!argv[@]}; do
        current=$((${index} + 1))
        arg="${argv[${index}]}"
        case "${arg}" in
            -h | --help)
                1>&2 echo -e "HELP"
                ;;
            *) ;;
        esac
    done

}

if [ "${0}" == "${BASH_SOURCE[0]}" ]; then
    main
else
    1>&2 echo -e "${BASH_SOURCE[0]} appears to being used as a library by ${0@Q}"
fi
