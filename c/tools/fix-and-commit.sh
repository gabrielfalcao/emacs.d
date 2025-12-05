#!/usr/bin/env bash

set -o pipefail
set -o errexit # or -e
# set -o noglob # or -f
set -o errtrace  # or set -E
set -o functrace # or set -T
set -o nounset   # -u

export IFS=$'\n'
unset IFS


declare -a argv=($@)
declare -i argc=${#argv[@]}


declare -- error_prefix_color_rgb="255;0;66"
declare -- error_color_rgb="255;62;92"
declare -- warn_prefix_color_rgb="255;106;50"
declare -- warn_color_rgb="255;161;50"
declare -- info_prefix_color_rgb="0;66;255"
declare -- info_color_rgb="62;92;255"
declare -- debug_prefix_color_rgb="50;255;106"
declare -- debug_color_rgb="50;255;161"

declare -- git_repo_path=""
declare -- script_name="$(basename "${BASH_SOURCE[0]}")"
declare -- tools_path="$(2>/dev/random 1>/dev/random cd $(dirname "${BASH_SOURCE[0]}") && pwd)"
declare -- this_tools_path="${tools_path}/${script_name}"
declare -- expected_git_repo_path="${HOME}/.emacs.d"

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

declare -i exit_code=0



process_argv() {
    true
    # repl no echo
    # local -i current=0
    # local -i index=0
    # local -- arg=""
    #
    # for index in ${!argv[@]}; do
    #     current=$(($index + 1))
    #     arg="${argv[$index]}"
    #
    # done
    # repl sane
}

main() {
    export IFS=$'\n'
    local -a changed_paths=()
    local -i exit_code=0
    local -- stderr=$(mktemp)
    local -- python_script="${tools_path}/fix-el.py"

    if ! changed_paths=( $(2>${stderr} python3 "${python_script}") ); then
        exit_code=$?
        error_prefixed "[${python_script} error]" "$(cat "${stderr}")"
        exit ${exit_code}
    fi
    unset IFS
    if [ ${#changed_paths[@]} -eq 0 ]; then
        warn_prefixed "[error]" "nothing changed"
        exit 2
    fi
    git commit ${changed_paths[@]} -m "fixes ${#changed_paths[@]} elisp files"
}

if [ "${0}" == "${BASH_SOURCE[0]}" ]; then
    if ! git_repo_path=$(git rev-parse --show-toplevel); then
        exit_code=$?
        error "$(pwd) is not in a git repo"
        exit "${exit_code}"
    fi
    if [ "${git_repo_path}" != "${expected_git_repo_path}" ]; then
        error_prefixed '[location error]' "current git repo should be located at ${expected_git_repo_path@Q} but actual path is ${git_repo_path@Q}"
        exit 1
    fi
    if [ "${git_repo_path}/tools" != "${tools_path}" ]; then
        error_prefixed '[location error]' "${BASH_SOURCE[0]} is not located under ${git_repo_path}/tools"
        exit 1
    fi

    if process_argv ${argv[@]}; then
        main
    fi
else
    1>&2 echo -e "${BASH_SOURCE[0]} appears to being used as a library by ${0@Q}"
fi
repl sane
