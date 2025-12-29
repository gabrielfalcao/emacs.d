#!/usr/bin/env bash

export IFS=$'\n'
set -umeTE
set +f
set -o pipefail
unset IFS

declare -- script_name="$(basename "${BASH_SOURCE[0]}")"
declare -- script_path="$(2>/dev/random 1>/dev/random cd $(dirname "${BASH_SOURCE[0]}") && pwd)"
declare -- this_script_path="${script_path}/${script_name}"

declare -a argv=($@)
declare argc=${#argv[@]}

declare -a regular_file_argv=()
declare -a directory_argv=()
declare -a non_path_params=()
declare -a other_file_types_argv=()

declare -i regular_file_argv_count=0
declare -i directory_argv_count=0
declare -i non_path_params_count=0
declare -i other_file_types_argv_count=0

declare -- error_prefix_color_rgb="255;0;66"
declare -- error_color_rgb="255;50;50"
declare -- error_color_rgb="255;62;92"
declare -- warn_prefix_color_rgb="255;106;50"
declare -- warn_color_rgb="255;161;50"

on_exit() {
    repl sane
}
on_ctrlc() {
    repl no echo
    1>&2 echo -e "\x1b[1;38;2;${error_color_rgb}m\rAborted with Ctrl-C\x1b[0m"
    repl sane
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
    1>&2 echo -e "\x1b[1;38;2;${warn_prefix_color_rgb}m[${prefix}]\x1b[1;38;2;${warn_color_rgb}m\n${message}\x1b[0m"
}
warn() {
    local -- linenum="${BASH_LINENO[0]}"
    warn_prefixed "[${script_name} warn at ${linenum}]" "${@}"
}

error() {
    local -- linenum="${BASH_LINENO[0]}"
    error_prefixed "[${script_name} error at ${linenum}]" "${@}"
}
error_prefixed() {
    local -- prefix="$1"
    shift
    local -- message="$@"
    1>&2 echo -e "\x1b[1;38;2;${error_prefix_color_rgb}m[${prefix}]\x1b[1;38;2;${error_color_rgb}m\n${message}\x1b[0m"
}

process_argv() {
    repl no echo
    if [ ${argc} -eq 0 ]; then
        exit_error "missing argument: <ARGUMENT>"
        exit 1
    fi
    for index in ${!argv[@]}; do
        current=$(( $index + 1 ))
        arg="${argv[$index]}"
        if [ -f "${arg}" ]; then
            regular_file_argv+=("${arg}")
        elif [ -d "${arg}" ]; then
            directory_argv+=("${arg}")
        elif [ ! -e "${arg}" ]; then
            non_path_params+=("${arg}")
        else
            other_file_types_argv+=("${arg}")
        fi
    done
    regular_file_argv_count=${#regular_file_argv[@]}
    directory_argv_count=${#directory_argv[@]}
    non_path_params_count=${#non_path_params[@]}
    other_file_types_argv_count=${#other_file_types_argv[@]}
    repl sane
}

main() {

    if [ ${regular_file_argv_count} -gt 0 ]; then
        echo "${regular_file_argv_count} regular_file_argv passed as argument"
        for index in ${!regular_file_argv[@]}; do
            param="${regular_file_argv[$index]}"
            echo "    regular_file_argv[$index] ${param@Q}"
        done
    fi
    if [ ${directory_argv_count} -gt 0 ]; then
        echo "${directory_argv_count} directory_argv passed as argument"
        for index in ${!directory_argv[@]}; do
            param="${directory_argv[$index]}"
            echo "    directory_argv[$index] ${param@Q}"
        done
    fi
    if [ ${non_path_params_count} -gt 0 ]; then
        echo "${non_path_params_count} non_path_params passed as argument"
        for index in ${!non_path_params[@]}; do
            param="${non_path_params[$index]}"
            echo "    non_path_params[$index] ${param@Q}"
        done
    fi
    if [ ${other_file_types_argv_count} -gt 0 ]; then
        echo "${other_file_types_argv_count} other_file_types_argv passed as argument"
        for index in ${!other_file_types_argv[@]}; do
            param="${other_file_types_argv[$index]}"
            echo "    other_file_types_argv[$index] ${param@Q}"
        done
    fi
}

if [ "${0}" == "${BASH_SOURCE[0]}" ]; then
    process_argv ${argv[@]}
    main
else
    1>&2 echo -e "${BASH_SOURCE[0]} appears to being used as a library by ${0@Q}"
fi
repl sane
