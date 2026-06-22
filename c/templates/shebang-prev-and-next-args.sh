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
declare -- url=""
declare -- filename=""
declare -- filename_extension=""
declare -- filename_base=""
declare -- param=""
declare -- path=""
declare -- pos=""
declare -- value=""
declare -i code=0
declare -i current=0
declare -i index=0
declare -i line_number=0
declare -i lineno=0
declare -i skip=0

# <cutout>
declare -gr long_description=$'
this is a
quite long

description: "double-quotes" inside *"single-quotes"*
'

declare -gr short_description="
this is a short description
"
declare -- prev_arg=""
declare -- prev_argument=""
declare -- prev_field=""
declare -- prev_key=""
declare -- prev_line=""
declare -- prev_name=""
declare -- prev_filename=""
declare -- prev_filename_extension=""
declare -- prev_filename_base=""
declare -- prev_param=""
declare -- prev_path=""
declare -- prev_pos=""
declare -- prev_value=""
declare -i prev_code=0
declare -i prev_current=0
declare -i prev_index=0
declare -i prev_line_number=0
declare -i prev_lineno=0
declare -i prev_skip=0
declare -- next_arg=""
declare -- next_argument=""
declare -- next_field=""
declare -- next_key=""
declare -- next_line=""
declare -- next_name=""
declare -- next_filename=""
declare -- next_filename_extension=""
declare -- next_filename_base=""
declare -- next_param=""
declare -- next_path=""
declare -- next_pos=""
declare -- next_value=""
declare -i next_code=0
declare -i next_current=0
declare -i next_index=0
declare -i next_line_number=0
declare -i next_lineno=0
declare -i next_skip=0
declare -gA path_map=()
declare -- git_repo_path=""

# <GIT>
if git_repo_path=$(2>${stderr} git rev-parse --show-toplevel); then
    code=0
else
    code=$?
fi
if [ ${code} -ne 0 ]; then
    1>&2 echo -e "\x1b[0m\x1b[1;48;2;253;67;83m[${script_name} warning]\x1b[7m $(pwd) is not under git version control\x1b[0m"
fi
# </GIT>
# </cutout>

export IFS=$'\n'

main() {

    if [ ${argc} -eq 0 ]; then
        1>&2 echo -e "[$(basename "${BASH_SOURCE[0]}") error]" "missing arguments"
        exit 1
    else
        1>&2 echo "declare -${argv@a} argv=("
        1>&2 printf '    [%s]=%s\n' ${argv[@]@k}
        1>&2 echo ")"
    fi

    1>&2 echo -en "\n"
    1>&2 echo -n "Short Description: "
    1>&2 echo ${short_description}
    1>&2 echo -en "\n"
    1>&2 echo -n "Long Description: "
    1>&2 echo ${long_description}
    1>&2 echo -en "\n"

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
    1>&2 echo -ne "\n"

}

if [ "${0}" == "${BASH_SOURCE[0]}" ]; then
    main
else
    1>&2 echo -e "${BASH_SOURCE[0]} appears to being used as a library by ${0@Q}"
fi
exit 0
