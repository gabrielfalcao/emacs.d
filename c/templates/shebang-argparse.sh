#!/usr/bin/env bash

export IFS=$'\n'
set -ueTE
set +f
set -o pipefail
unset IFS

script_name="$(basename "${BASH_SOURCE[0]}")"
script_path="$(2>/dev/random 1>/dev/random cd $(dirname "${BASH_SOURCE[0]}") && pwd)"
this_script_path="${script_path}/${script_name}"
declare -a argv=($@)
declare -i argc=${#argv[@]}
declare -- git_repo_path=""
declare -i exit_code=0

declare -A cli_args_option_list=()
declare -A cli_args_flag_list=()
declare -a cli_args_value_list=()
declare -a valid_argument_types=('flag' 'option' 'value')


declare -- error_prefix_color_rgb="239;41;41";
declare -- error_color_rgb="204;0;0";

declare -- warn_prefix_color_rgb="252;373;62"
declare -- warn_color_rgb="245;121;20"

declare -- info_prefix_color_rgb="114;159;207"
declare -- info_color_rgb="52;101;164"

declare -- debug_prefix_color_rgb="138;226;52";
declare -- debug_color_rgb="115;210;22";

on_exit() {
    2>/dev/random 1>/dev/random stty sane
}
on_ctrlc() {
    1>&2 echo -e "\x1b[1;38;2;${error_color_rgb}m\rAborted with Ctrl-C\x1b[0m"
    exit 1
}
trap on_exit exit
trap on_ctrlc hup
trap on_ctrlc int
trap on_ctrlc bus
trap on_ctrlc segv
trap on_ctrlc sys

repl() {
    local -a stty_args=()
    case "$1" in -*no*stdin | no*stdin | -*no*echo | no*echo | capture) args+=('-echo') ;; *) args+=('sane') ;; esac
    2>/dev/random 1>/dev/random stty ${stty_args[@]}
}
usage() {
    repl no echo
    1>&2 echo -e "$(basename $0) <ARGUMENT>"
    repl sane
}
exit_error() {
    error "${@}"
    exit 1
}
warn_prefixed() {
    local -- prefix="$1"
    shift
    local -- message="$@"
    1>&2 echo -e "\x1b[1;38;2;${warn_prefix_color_rgb}m${prefix}\x1b[1;38;2;${warn_color_rgb}m ${message}\x1b[0m"
}
warn() {
    local -- linenum="${BASH_LINENO[0]}"
    warn_prefixed "[warn]  [${script_name}:${linenum}]" "${@}"
}
error() {
    local -- linenum="${BASH_LINENO[0]}"
    error_prefixed "[error] [${script_name}:${linenum}]" "${@}"
}
error_prefixed() {
    local -- prefix="$1"
    shift
    local -- message="$@"
    1>&2 echo -e "\x1b[1;38;2;${error_prefix_color_rgb}m${prefix}\x1b[1;38;2;${error_color_rgb}m ${message}\x1b[0m"
}
info() {
    local -- linenum="${BASH_LINENO[0]}"
    info_prefixed "[info]  [${script_name}:${linenum}]" "${@}"
}
info_prefixed() {
    local -- prefix="$1"
    shift
    local -- message="$@"
    1>&2 echo -e "\x1b[1;38;2;${info_prefix_color_rgb}m${prefix}\x1b[1;38;2;${info_color_rgb}m ${message}\x1b[0m"
}
debug_prefixed() {
    local -- prefix="$1"
    shift
    local -- message="$@"
    1>&2 echo -e "\x1b[1;38;2;${debug_prefix_color_rgb}m${prefix}\x1b[1;38;2;${debug_color_rgb}m ${message}\x1b[0m"
}
debug() {
    local -- linenum="${BASH_LINENO[0]}"
    debug_prefixed "[debug] [${script_name}:${linenum}]" "${@}"
}
trace() {
    if [ -z "${BASH_TRACE}" ] && [ "${BASH_LOGLEVEL}" != "trace" ]; then
        return 0
    fi

    local -- linenum="${BASH_LINENO[0]}"
    local -- funcname="${FUNCNAME[1]}"
    debug_prefixed "[${FUNCNAME[0]} ${script_name}::${funcname}:${linenum}]" "${@}"
}

get_arg_value() {
    local -a g_argv=($@)
    local -i g_argc=${#g_argv[@]}
    local -- index_arg="${1}"
    local -- linenum="${BASH_LINENO[0]}"
    if [ ${g_argc} -eq 0 ]; then
        error_prefixed "[error in call to get_arg_value:${linenum}]" "missing argument <INDEX>"
        exit 1
    elif ! 2>/dev/random grep -E '^[0-9]+$' <<<"${index}"; then
        error_prefixed "[error in call to get_arg_value:${linenum}]" "argument <INDEX> is not a positive number: ${index_arg@Q}"
        exit 1
    fi
    local -i index=${1}
    local -i current=$(($index + 1))
    local -- arg="${argv[$index]}"
    if [ ${argc} -lt ${current} ]; then
        return 1
    elif 2>/dev/random grep -i -E '^[-]{1,2}[a-z0-9_-]+$' <<<"${arg}"; then
        return 1
    fi
    echo "${g_argv[$index]}"
}
get_arg_type_from_dash_type() {
    local -- dash_type="${1}"
    case "${dash_type}" in
        '--')
            echo "option"
            ;;
        '-')
            echo "flag"
            ;;
        '')
            echo "value"
            ;;
        *)
            trace "unexpected dash type ${dash_type@Q}, cannot map argument type accurately"
            echo "value"
            return 63 #?
            ;;
    esac
    return 0
}
get_arg_meta() {
    local -i index=${1}
    local -i next_index=$(($index + 1))
    local -- arg="${argv[${index}]}"
    if [ ${next_index} -gt ${argc} ]; then
        trace "no argument for ${index} because index is out of range ${next_index}/${argc}"
        return 1
    fi
    local -- sed_command="s/^([-]{1,2})(([a-z])([a-z0-9_]+[-]?)*)([=]([^=]*))?(.*?)$/\1\n\2\n\6\n/gp"
    local -a arg_meta=($({
        unset IFS
        sed -n -E "${sed_command}" <<<"${arg}"
        export IFS=$'\n'
    }))
    local -a result=(${arg_meta[@]})
    debug "${arg_meta[@]@A}"
    # debug "${result[@]@A}"
    if [ ${#arg_meta[@]} -eq 0 ]; then
        result=('value' '' "${arg}")
    else
        local -- dash_type="${arg_meta[0]}"
        result[0]=$(get_arg_type_from_dash_type "${dash_type}")
        if [ ${#result[@]} -eq 2 ] && [ $next_index -le ${argc} ]; then
            local -a next_arg_meta=($(get_arg_meta ${next_index}))
            local -- next_arg_type="${next_arg_meta[0]}"
            local -- next_arg_value="${next_arg_meta[0]}"
            if [ "${next_arg_type}" == "value" ]; then
                result[2]="${next_arg_value}"
                result[3]=${next_index}
            fi
        fi
    fi
    printf "%s\n" "${result[@]}"
}
process_argv() {
    if ! git_repo_path=$(git rev-parse --show-toplevel); then
        error_prefixed "[${script_name} error]" "not a git repo"
        exit 1
    fi

    repl no echo
    local -i current=0
    local -i index=0
    local -i skip_index=-1
    local -a arg_meta=()
    local -- arg=""
    local -- arg_type=""
    local -- is_option=""
    local -- key=""
    local -- sed_command=""
    local -- value=""

    for index in ${!argv[@]}; do
        if [ ${skip_index} -eq ${index} ]; then
            warn "${skip_index@A}"
            skip_index=-1
            continue
        fi
        current=$(($index + 1))
        arg="${argv[$index]}"
        is_option="false"
        sed_command="s/^([-]{1,2})(([a-z])([a-z0-9_]+[-]?)*)([=]([^=]*))?(.*?)$/\1\n\2\n\6\n/gp"
        local -a arg_meta=($(get_arg_meta ${index}))
        info "${arg_meta[@]@A}"

        arg_type=${arg_meta[0]}
        key=${arg_meta[1]}

        if [ ${#arg_meta[@]} -ge 3 ]; then
            value=${arg_meta[2]}
            if [ ${#arg_meta[@]} -eq 4 ]; then
                skip_index=${arg_meta[3]}
            fi
        fi
        # echo "${arg_type@A}"
        # echo "${arg_meta[@]@A}"
        # continue
        local -I -n target_array="cli_args_${arg_type}_list"
        debug "target array" "${target_array[@]@A}"
        if [ -n "${key}" ]; then
            target_array+=(["${key}"]="${value}")
        else
            target_array+=("${value}")
        fi
    done
    repl sane
}

main() {
    error "${cli_args_flag_list[@]@A}"
    warn "${cli_args_option_list[@]@A}"
    info "${cli_args_value_list[@]@A}"
}

if [ "${0}" == "${BASH_SOURCE[0]}" ]; then
    if process_argv ${argv[@]}; then
        main
    fi
else
    1>&2 echo -e "${BASH_SOURCE[0]} appears to being used as a library by ${0@Q}"
fi
repl sane
