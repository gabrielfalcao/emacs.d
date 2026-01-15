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
declare -- usefulness="does stuff"

declare -a description_lines=(
    "these lines are supposed to describe the usefulness of ${script_name}"
    "beyond \"${usefulness}\" such that the output of ${script_name}\x27"
    "help looks not unlike a nice unix manpage"
)

declare -a argv=("$@")
declare -i argc=${#argv[@]}
declare -a stdin_lines=("$@")
declare -i stdin_line_count=${#stdin_lines[@]}
declare -a inputs=()
declare -A sources_by_input=()
declare -i input_count=0
declare -- git_repo_path=""
declare -i exit_code=0
declare -i argv_return_code=0
declare -i stdin_return_code=0
declare -- curdir="$PWD"

declare -- error_prefix_color_rgb="239;41;41"
declare -- error_color_rgb="204;0;0"

declare -- achtung_prefix_color_rgb="245;121;0"
declare -- achtung_color_rgb="206;92;0"

declare -- warn_prefix_color_rgb="252;233;79"
declare -- warn_color_rgb="237;212;00"

declare -- info_prefix_color_rgb="52;101;164"
declare -- info_color_rgb="114;159;207;"

declare -- msg_prefix_color_rgb="186;189;182"
declare -- msg_color_rgb="136;138;133"

declare -- display_prefix_color_rgb="238;238;236"
declare -- display_color_rgb="211;215;207"

declare -- debug_prefix_color_rgb="138;226;52"
declare -- debug_color_rgb="115;210;22"

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
    2>/dev/random 1>/dev/random stty "${stty_args[@]}"
}
usage() {
    repl no echo
    1>&2 echo -e "$(basename "$0") <ARGUMENT>"
    repl sane
}
exit_error() {
    error "${@}"
    exit 1
}

achtung_prefixed() {
    local -- prefix="$1"
    shift
    local -- message="$@"
    1>&2 echo -e "\x1b[1;38;2;${achtung_prefix_color_rgb}m${prefix}\x1b[1;38;2;${achtung_color_rgb}m ${message}\x1b[0m"
}
achtung() {
    local -- linenum="${BASH_LINENO[0]}"
    achtung_prefixed "[achtung]  [${script_name}:${linenum}]" "${@}"
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
msg() {
    local -- linenum="${BASH_LINENO[0]}"
    msg_prefixed "[msg]  [${script_name}:${linenum}]" "${@}"
}
msg_prefixed() {
    local -- prefix="$1"
    shift
    local -- message="$@"
    1>&2 echo -e "\x1b[1;38;2;${msg_prefix_color_rgb}m${prefix}\x1b[1;38;2;${msg_color_rgb}m ${message}\x1b[0m"
}
display() {
    local -- linenum="${BASH_LINENO[0]}"
    display_prefixed "[display]  [${script_name}:${linenum}]" "${@}"
}
display_prefixed() {
    local -- prefix="$1"
    shift
    local -- message="$@"
    1>&2 echo -e "\x1b[1;38;2;${display_prefix_color_rgb}m${prefix}\x1b[1;38;2;${display_color_rgb}m ${message}\x1b[0m"
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
    if [ "$BASH_TRACE" = "" ] && [ "$BASH_LOGLEVEL" != "trace" ]; then
        return 0
    fi

    local -- linenum="${BASH_LINENO[0]}"
    local -- funcname="${FUNCNAME[1]}"
    debug_prefixed "[${FUNCNAME[0]} ${script_name}::${funcname}:${linenum}]" "${@}"
}

process_inputs() {
    local -i current=0
    local -i index=0
    local -- item=""

    if ! git_repo_path=$(git rev-parse --show-toplevel); then
        error_prefixed "[${script_name} error]" "${curdir@Q} is not a git repo"
        exit 1
    fi
    repl sane
    if ! process_argv; then
        argv_return_code=$?
    fi
    if [ "$argc" -gt 0 ]; then
        for index in ${!argv[@]}; do
            current=$(( index + 1 ))
            item="${argv[${index}]}"
            sources_by_input+=(["argv:${index}"]="$item")
        done
    fi

    if [ ! -t 0 ]; then
        if ! process_stdin; then
            stdin_return_code=$?
        fi
    fi
    if [ "$stdin_line_count" -gt 0 ]; then
        for index in ${!stdin_lines[@]}; do
            current=$(( index + 1 ))
            item="${stdin_lines[${index}]}"
            sources_by_input+=(["stdin:${index}"]="$item")
        done
    fi
}

process_stdin() {
    repl sane
    local -i lineno=0
    local -- line=""
    if [ ! -t 0 ]; then
        export IFS=$'\n'
        while read line; do
            if ! stdin_lines+=("$line"); then
                continue
            fi
        done </dev/stdin
    elif [ "$argc" -eq 0 ]; then
        error_prefixed "[input error]"
        diplay_help
        exit 1
    fi
    stdin_line_count=${#stdin_lines[@]}
}

display_usage() {
    echo -e "${script_name} [-v|--verbose] [-q|--quiet|--silent] [-h|-help|--help]"
}
process_argv() {
    if [ "$argc" -eq 0 ]; then
        return 1
    fi
    repl no echo

    local -i current=0
    local -i index=0
    local -- arg=""
    for index in "${!argv[@]}"; do
        current=$(( index + 1 ))
        arg="${argv[$index]}"
        case "$arg" in
            -h | --help | -help)
                colored_manual "NAME
    ${script_name} - ${usefulness}

SYNOPSIS
$(printf '%-*s' 4 "$(display_usage)")

DESCRIPTION

$(printf '%-*s\n' 4 "${description_lines[@]}")

    Options:

      -v, --verbose
          prints debug information

      -q, --quiet, --silent
          omits debug information

      -h, -help, --help
          prints this help
"

                ;;
            *) ;;
        esac
    done
    repl sane
}

main() {
    info_prefixed "[${script_name}]" "main"
}

if [ "${0}" == "${BASH_SOURCE[0]}" ]; then
    if process_inputs "${argv[@]}"; then
        main
    fi
else
    1>&2 echo -e "${BASH_SOURCE[0]} appears to being used as a library by ${0@Q}"
fi
repl sane
