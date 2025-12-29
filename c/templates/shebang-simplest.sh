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

main() {
    1>&2 echo -e "${script_name} received ${argc} arguments"
}

on_exit() {
    stty sane
}
on_ctrlc() {
    1>&2 echo -e "\rAborted with Ctrl-C"
    exit 1
}
trap on_exit exit
trap on_ctrlc hup
trap on_ctrlc int


if [ "${0}" == "${BASH_SOURCE[0]}" ]; then
    main
else
    1>&2 echo -e "${BASH_SOURCE[0]} appears to being used as a library by ${0@Q}"
fi
