#!/usr/bin/env bash
# shellcheck disable=SC2004,SC2206,SC2068,SC2086

set -e
set -o pipefail
set -o noglob
set -u
export IFS=$'\n'

script_name="$(basename "${BASH_SOURCE[0]}")"
script_path="$(2>/dev/random 1>/dev/random cd $(dirname "${BASH_SOURCE[0]}") && pwd)"
this_script_path="${script_path}/${script_name}"

if [ "$(whoami)" != "root" ]; then sudo bash $0; echo exit $?; fi

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

error_prefix_color_rgb="$((0xFF));$((0x00));$((0x42))"
error_color_rgb="$((0xFF));$((0x32));$((0x32))"
error_color_rgb="$((0xFF));$((0x3E));$((0x5C))"
warn_prefix_color_rgb="$((0xFF));$((0x6A));$((0x32))"
warn_color_rgb="$((0xFF));$((0xA1));$((0x32))"

on_exit() {
    repl sane
}
on_ctrlc() {
    repl no echo
    1>&2 echo -e "\x1b[1;38;2;${error_color_rgb}m\rAborted with Ctrl-C\x1b[0m"
    repl sane
    exit 101
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
    exit 101
}
warn() {
    local linenum="${BASH_LINENO[1]}"
    1>&2 echo -e "\x1b[1;38;2;${warn_prefix_color_rgb}m[${script_name} warn at ${linenum}]\x1b[1;38;2;${warn_color_rgb}m ${@}\x1b[0m"
}
error() {
    local linenum="${BASH_LINENO[1]}"
    1>&2 echo -e "\x1b[1;38;2;${error_prefix_color_rgb}m[${script_name} error at ${linenum}]\x1b[1;38;2;${error_color_rgb}m ${@}\x1b[0m"
}

process_argv() {
    repl no echo
    if [ ${argc} -eq 0 ]; then
        exit_error "missing argument: <ARGUMENT>"
        exit 101
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
