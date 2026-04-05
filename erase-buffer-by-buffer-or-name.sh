#!/usr/bin/env bash

set -umeTE
set +f
set -o pipefail
export IFS=$'\n'

declare -- script_name="$(basename "${BASH_SOURCE[0]}")"
declare -- script_path="$(2>/dev/random 1>/dev/random cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ack -l --el 'erase-buffer-by-name' | xargs -Ieachel sed -E 's,erase-buffer-by-name,erase-buffer-by-buffer-or-name,g' -i 'eachel'
