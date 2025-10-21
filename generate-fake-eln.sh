#!/usr/bin/env bash

set -e
set -o pipefail
set -u

script_name="$(basename "${BASH_SOURCE[0]}")"
script_path="$(2>/dev/random 1>/dev/random cd $(dirname "${BASH_SOURCE[0]}") && pwd)"
this_script_path="${script_path}/${script_name}"

declare -a argv=($@)
declare -i argc=${#argv[@]}

script_name="$(basename "${BASH_SOURCE[0]}")"

declare -a fakes=(
    "${HOME}/.emacs.d/eln-cache/28.2-6ac46776/parse-time-ca7017be-39be3991.eln"
    "${HOME}/.emacs.d/eln-cache/28.2-6ac46776/password-cache-187e4eec-58743954.eln"
    "${HOME}/.emacs.d/eln-cache/28.2-6ac46776/pcomplete-81dbd8b0-881a3c43.eln"
    "${HOME}/.emacs.d/eln-cache/28.2-6ac46776/pp-5d47c1cc-de730a1a.eln"
    "${HOME}/.emacs.d/eln-cache/28.2-6ac46776/rect-cd288962-8fd57717.eln"
    "${HOME}/.emacs.d/eln-cache/28.2-6ac46776/ring-bff0b981-1ec923e0.eln"
    "${HOME}/.emacs.d/eln-cache/28.2-6ac46776/shell-57930f41-89db2832.eln"
    "${HOME}/.emacs.d/eln-cache/28.2-6ac46776/subr--trampoline-7965732d6f722d6e6f2d70_yes_or_no_p_0.eln"
    "${HOME}/.emacs.d/eln-cache/28.2-6ac46776/text-property-search-db1383f6-138a1d72.eln"
    "${HOME}/.emacs.d/eln-cache/28.2-6ac46776/thingatpt-6fc8a4ab-8b6b8920.eln"
    "${HOME}/.emacs.d/eln-cache/28.2-6ac46776/time-date-40951a48-90379058.eln"
    "${HOME}/.emacs.d/eln-cache/28.2-6ac46776/tramp-b5a14372-7fe9999f.eln"
    "${HOME}/.emacs.d/eln-cache/28.2-6ac46776/tramp-cmds-feea5f1f-a6087c25.eln"
    "${HOME}/.emacs.d/eln-cache/28.2-6ac46776/tramp-compat-fa04d39a-5de0754d.eln"
    "${HOME}/.emacs.d/eln-cache/28.2-6ac46776/tramp-integration-58d1aa20-020c4e32.eln"
    "${HOME}/.emacs.d/eln-cache/28.2-6ac46776/trampver-0d42d995-1f784846.eln"
    "${HOME}/.emacs.d/eln-cache/28.2-6ac46776/url-38944b26-496ead54.eln"
    "${HOME}/.emacs.d/eln-cache/28.2-6ac46776/url-cookie-02b28750-39280d69.eln"
    "${HOME}/.emacs.d/eln-cache/28.2-6ac46776/url-domsuf-beabcbfe-62637a20.eln"
    "${HOME}/.emacs.d/eln-cache/28.2-6ac46776/url-expand-cf7ffc4e-55972622.eln"
    "${HOME}/.emacs.d/eln-cache/28.2-6ac46776/url-handlers-8b35c993-30409448.eln"
    "${HOME}/.emacs.d/eln-cache/28.2-6ac46776/url-history-a9b2f6e8-bfe8d526.eln"
    "${HOME}/.emacs.d/eln-cache/28.2-6ac46776/url-methods-08bf763a-d2942789.eln"
    "${HOME}/.emacs.d/eln-cache/28.2-6ac46776/url-parse-ee297c9b-64644c43.eln"
    "${HOME}/.emacs.d/eln-cache/28.2-6ac46776/url-privacy-7df6b777-eddf1865.eln"
    "${HOME}/.emacs.d/eln-cache/28.2-6ac46776/url-proxy-fc0751f0-60c45fa0.eln"
    "${HOME}/.emacs.d/eln-cache/28.2-6ac46776/url-util-28122a93-65413f7c.eln"
    "${HOME}/.emacs.d/eln-cache/28.2-6ac46776/url-vars-04b97511-6e21ea42.eln"
)
declare -i total=${#fakes[@}]


for index in ${!fakes[@]}; do
    current=$(( $index + 1 ))
    dummy_path=${fakes[${index}]}
    parent_path=$(dirname "${dummy_path}")
    mkdir -p "${parent_path}"
    2>&1 echo -e "generating dummy ${current} of ${total}"
    2>/dev/random dd if=/dev/random of=${dummy_path} bs=256 count=${#dummy_path} > ${dummy_path}
done
