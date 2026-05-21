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
}

on_ctrlc() {
    local -- msg="Aborted with Ctrl-C"
    local -i len=${#msg}
    local -i screen_width=0
    if [[ -v COLUMNS ]]; then
        screen_width=$((COLUMNS))
    else
        local -- stty_info=$(stty -a | grep -E -i columns)
        screen_width=$(echo "${stty_info}" | sed -n -E "s,^.*[;]\s+((\s*columns\s+)([0-9]+)|([0-9]+)(\s+columns\s*))[;],\3\4,gp" | grep -E '^[0-9]+$' | sort -un)
    fi

    1>&2 echo -e "\r$(printf '%*s' ${screen_width} "\r\x1b[1;38;2;253;67;83m${msg}")\x1b[0m"
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

declare -- arg=""
declare -- argument=""
declare -- field=""
declare -- key=""
declare -- line=""
declare -- name=""
declare -- param=""
declare -- path=""
declare -- pos=""
declare -- value=""

declare -i code=0
declare -i current=0
declare -i index=0
declare -i skip=0

declare -- filename=""
declare -- filename_extension=""
declare -- filename_base=""

main() {
    1>&2 echo "declare -${argv@a} argv=("
    1>&2 printf '    [%s]=%s\n' ${argv[@]@k}
    1>&2 echo ")"
}

if [ "${0}" == "${BASH_SOURCE[0]}" ]; then
    main
else
    1>&2 echo -e "${BASH_SOURCE[0]} appears to being used as a library by ${0@Q}"
fi
exit 0
