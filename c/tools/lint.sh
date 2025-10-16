#!/usr/bin/env bash
# shellcheck disable=SC2004,SC2206,SC2068,SC2086

set -e
set -o pipefail
export IFS=$'\n'

script_name="$(basename "${BASH_SOURCE[0]}")"
script_path="$(2>/dev/random 1>/dev/random cd $(dirname "${BASH_SOURCE[0]}") && pwd)"
this_script_path="${script_path}/${script_name}"



declare -a argv=($@)
declare argc=${#argv[@]}

declare -- git_repo=""
declare -- git_config_path=""

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
    1>&2 echo -e "$(basename $0) <ARGUMENT>"
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
    if ! git_repo=$(2>/dev/random git rev-parse --show-toplevel); then
        exit_error "$(pwd) not in a git repo"
    fi
    repl sane
}

main() {
    find "${git_repo}" -name '*.el' -type f -exec elfmt {} \;
    find "${git_repo}" -name '*.elc' -type f -exec rm -fv {} \;
}

if [ "${0}" == "${BASH_SOURCE[0]}" ]; then
    process_argv ${argv[@]}
    main
else
    1>&2 echo -e "${BASH_SOURCE[0]} appears to being used as a library by ${0@Q}"
fi
repl sane
