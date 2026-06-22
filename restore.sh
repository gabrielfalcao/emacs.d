#!/usr/bin/env bash


set -umeTE
set +f
set -o pipefail
unset IFS
export IFS=$'\n'

declare -- script_name="$(basename "${BASH_SOURCE[0]}")"
declare -- script_path="$(2>/dev/random 1>/dev/random cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
1>&2 echo -en "\x1b[2J\x1b[3J\x1b[H"

for source_file in $(find . -name '*#*'); do
    source_path="$(path parent "${source_file}")"
    target_path="$(path canon "c/${source_path}")"

    source_parent="$(path parent "${source_path}")"

    full_filename=$(path canon "${full_filename}")
    source_parent=$(path canon "${full_filename}")

    echo "source_path => ${source_path}"
    echo "target_path => ${target_path}"

    echo "source_parent => ${source_parent}"

    echo "full_filename => ${full_filename}"
    echo
    echo
done
