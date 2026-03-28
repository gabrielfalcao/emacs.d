#!/usr/bin/env bash

set -umeTE
set +f
set -o pipefail
unset IFS
export IFS=$'\n'

declare -- script_name="$(basename "${BASH_SOURCE[0]}")"
declare -- script_path="$(2>/dev/random 1>/dev/random cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
declare -- this_script_path="${script_path}/${script_name}"
declare -- stderr="$(mktemp)"

on_exit() {
    set +x
    bash -c "exec 1>&2;
set -umeTE; set +f; set -o pipefail;
rm -f ${stderr@Q} &
disown -a
"
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

declare -i code=0

declare -i current=0
declare -- arg=""
declare -- pos=""

declare -i index=0
declare -- arg=""
declare -- param=""

declare -i next_index=0
declare -- next_arg=""
declare -- next_param=""

declare -i skip_next=0

declare -i lineno=0
declare -i line_number=0
declare -- line=""

declare -- argument=""
declare -- field=""
declare -- key=""
declare -- name=""
declare -- path=""
declare -- value=""

# <GIT>
declare -- git_repo_path=""
if git_repo_path=$(2>${stderr} git rev-parse --show-toplevel); then
    code=0
else
    code=$?
fi
if [ ${code} -ne 0 ]; then
    1>&2 echo -e "\x1b[0m\x1b[1;48;2;253;67;83m[${script_name} warning]\x1b[7m $(pwd) is not under git version control\x1b[0m"
fi
# </GIT>
export IFS=$'\n'

main() {

    if [ ${argc} -eq 0 ]; then
        1>&2 echo -e "[$(basename "${BASH_SOURCE[0]}") error]" "missing arguments"
        exit 1
    fi

    for index in ${!argv[@]}; do
        current=$(($index + 1))
        arg="${argv[$index]}"
        pos="$(printf '%*s of %s' ${#argc} ${current} ${argc})"

        case "${arg}" in
            -h | --help)
                1>&2 echo -e "HELP"
                ;;
            *)
                1>&2 echo -e "[$(basename "${BASH_SOURCE[0]}") argument ${pos}]" "${arg@Q}"
                ;;
        esac
    done

}

if [ "${0}" == "${BASH_SOURCE[0]}" ]; then
    main
else
    1>&2 echo -e "${BASH_SOURCE[0]} appears to being used as a library by ${0@Q}"
fi
