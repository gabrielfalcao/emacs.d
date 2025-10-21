#!/usr/bin/env bash
# shellcheck disable=SC2004,SC2206,SC2068,SC2086


set -e
set -o pipefail
set -o noglob
set -u
unset IFS

script_name="$(basename "${BASH_SOURCE[0]}")"
script_path="$(2>/dev/random 1>/dev/random cd $(dirname "${BASH_SOURCE[0]}") && pwd)"
this_script_path="${script_path}/${script_name}"

declare -a argv=($@)
declare argc=${#argv[@]}

declare -a regular_file_argv=()
declare -i regular_file_argv_count=0


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
trap on_ctrlc emt
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
    1>&2 echo -e "$(basename $0) <SHELL SCRIPT FILES TO FIX>"
    repl sane
}
exit_error() {
    error "${@}"
    exit 101
}
warn() {
    1>&2 echo -e "\x1b[1;38;2;${warn_prefix_color_rgb}m[${script_name} warn]\x1b[1;38;2;${warn_color_rgb}m ${@}\x1b[0m"
}
error() {
    1>&2 echo -e "\x1b[1;38;2;${error_prefix_color_rgb}m[${script_name} error]\x1b[1;38;2;${error_color_rgb}m ${@}\x1b[0m"
}

process_argv() {
    repl no echo
    if [ ${argc} -eq 0 ]; then
        exit_error "missing argument: <ARGUMENT>"
        exit 101
    fi
    for index in ${!argv[@]}; do
        current=$(($index + 1))
        arg="${argv[$index]}"
        if [ -f "${arg}" ]; then
            regular_file_argv+=("${arg}")
        elif [ -d "${arg}" ]; then
            export IFS=$'\n'
            regular_file_argv+=( $(file ~/opt/libexec/* | ack -i 'shell.*script' | firstcol | cut -d: -f1 ) );
            unset IFS
        else
            warn "\x1b[0minvalid argument \x1b[1;38;5;220m[${current}/${argc}]\x1b[1;38;5;231m ${arg@Q}\x1b[0m: \x1b[1;38;5;196mnot a file"
        fi
    done
    regular_file_argv_count=${#regular_file_argv[@]}
    repl sane
}

main() {
    local -- sed_command='s/\(script_path="\$[(]2>\/dev\/random 1>\/dev\/random cd \$[(]dirname "\)\$[{]this_script_path[}]\("[)] && pwd[)]\)"/\1${BASH_SOURCE[0]}\2/g'

    for index in ${!regular_file_argv[@]}; do
        current=$(( $index + 1 ))
        path="${regular_file_argv[$index]}"
        surrogate=$(mktemp)
        sed "${sed_command}" "${path}" > ${surrogate}
        local -- diff=""
        if diff=$(2>/dev/random diff -u "${path}" "${surrogate}") && [ -n "${diff}" ]; then
            sed "${sed_command}" -i "${path}"
            exit_code=$?
            if [ ${exit_code} -ne 0 ]; then
                exit_error "\x1b[1;38;5;220m[${current}/${#regular_file_argv[@]}]\x1b[0m" "\x1b[1;38;5;231mcommand \x1b[1;38;5;202m${sed_call[@]}\x1b[1;38;5;231m failed with code \x1b[1;38;5;196m${exit_code}\x1b[0m (${current}/${regular_file_argv_count})"
            else
                1>&2 echo -e "\x1b[1;38;5;154mfixed file \x1b[1;38;5;220m${path}\x1b[0m"
            fi
        fi
        rm -f "${surrogate}"
    done
}

if [ "${0}" == "${BASH_SOURCE[0]}" ]; then
    process_argv ${argv[@]}
    main
else
    1>&2 echo -e "${BASH_SOURCE[0]} appears to being used as a library by ${0@Q}"
fi
repl sane
