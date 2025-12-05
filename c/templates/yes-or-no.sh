#!/usr/bin/env bash
export IFS=$'\n'
set -ueTE
set +f
set -o pipefail
unset IFS

exec 1>&2
declare -- script_name="$(basename "${BASH_SOURCE[0]}")"
declare -- script_path="$(2>/dev/random 1>/dev/random cd $(dirname "${BASH_SOURCE[0]}") && pwd)"
declare -- this_script_path="${script_path}/${script_name}"

declare -a argv=($@)
declare argc=${#argv[@]}

declare -- remote_branch_to_migrate="linux/linux"

declare -- stderr=$(mktemp)
declare -- stdout=$(mktemp)
declare -a commit_hashes=()
declare -A commits=()
declare -A cli_args_option_list=()
declare -A cli_args_flag_list=()
declare -a cli_args_value_list=()
declare -a valid_argument_types=('flag' 'option' 'value')
declare -- target_dir="${script_path}/x.d"
declare -- entrypoint_path="${script_path}/entrypoint.sh"
declare -- error_prefix_color_rgb="255;0;66"
declare -- error_color_rgb="255;62;92"
declare -- warn_prefix_color_rgb="255;106;50"
declare -- warn_color_rgb="255;161;50"
declare -- info_prefix_color_rgb="0;66;255"
declare -- info_color_rgb="62;92;255"
declare -- debug_prefix_color_rgb="50;255;106"
declare -- debug_color_rgb="50;255;161"
declare -- danger_prefix_color_rgb="2;249;110;99m"
declare -- danger_color_rgb="219;80;69"
declare -- question_color_rgb="244;145;1"
declare -- question_prefix_color_rgb="254;155;11"

on_exit() {
    2>/dev/random 1>/dev/random stty sane
}
on_ctrlc() {
    echo -e "\x1b[1;38;2;${error_color_rgb}m\rAborted with Ctrl-C\x1b[0m"
    exit 1
}
trap on_exit exit
trap on_ctrlc hup
trap on_ctrlc int
trap on_ctrlc bus
trap on_ctrlc segv
trap on_ctrlc sys

usage() {
    echo -e "$(basename $0) <ARGUMENT>"
}
exit_error() {
    error "${@}"
    exit 1
}
warn_prefixed() {
    local -- prefix="$1"
    shift
    local -- message="$@"
    echo -e "\x1b[1;38;2;${warn_prefix_color_rgb}m${prefix}\x1b[1;38;2;${warn_color_rgb}m ${message}\x1b[0m"
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
    echo -e "\x1b[1;38;2;${error_prefix_color_rgb}m${prefix}\x1b[1;38;2;${error_color_rgb}m ${message}\x1b[0m"
}
question_prefixed() {
    local -- prefix="$1"
    shift
    local -- message="$@"
    echo -e "\x1b[1;38;2;${question_prefix_color_rgb}m${prefix}\x1b[1;38;2;${question_color_rgb}m ${message}\x1b[0m"
}
question() {
    local -- linenum="${BASH_LINENO[0]}"
    question_prefixed "[question]  [${script_name}:${linenum}]" "${@}"
}
danger_prefixed() {
    local -- prefix="$1"
    shift
    local -- message="$@"
    echo -e "\x1b[1;38;2;${danger_prefix_color_rgb}m${prefix}\x1b[1;38;2;${danger_color_rgb}m ${message}\x1b[0m"
}
danger() {
    local -- linenum="${BASH_LINENO[0]}"
    danger_prefixed "[danger]  [${script_name}:${linenum}]" "${@}"
}

info() {
    local -- linenum="${BASH_LINENO[0]}"
    info_prefixed "[info]  [${script_name}:${linenum}]" "${@}"
}
info_prefixed() {
    local -- prefix="$1"
    shift
    local -- message="$@"
    echo -e "\x1b[1;38;2;${info_prefix_color_rgb}m${prefix}\x1b[1;38;2;${info_color_rgb}m ${message}\x1b[0m"
}
debug_prefixed() {
    local -- prefix="$1"
    shift
    local -- message="$@"
    echo -e "\x1b[1;38;2;${debug_prefix_color_rgb}m${prefix}\x1b[1;38;2;${debug_color_rgb}m ${message}\x1b[0m"
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

yes_or_no() {
    local -a yn_argv=($@)
    local -i yn_argc=${!yn_argv[@]}
    local -i index=0
    local -i current=0
    local -- arg=""
    local -A results=()

    if [ ${yn_argc} -eq 0 ]; then
        1>&2 echo -e "[${BASH_SOURCE[0]}:${BASH_LINENO[0]}]" "missing string argument: <YES / NO>"
        exit 1
    fi

    for index in ${!yn_argv[@]}; do
        current=$(($index + 1))
        arg="$(td -d '[:space:]' <<<"${yn_argv[$index]}")"
        case "${arg@L}" in
            y | yes)
                results[$index]="yes"
                ;;
            n | no)
                results[$index]="no"
                ;;
            *)
                # error_prefixed "[${FUNCNAME[0]}]" "invalid argument <PROMPT>"
                return 1
                ;;
        esac
    done
    for index in ${!results[@]}; do
        local yorno="${results[$index]}"
        echo "${yorno}"
    done
}

yes_or_no_prompt() {
    local -a yorn_argv=($@)
    local -i yorn_argc=${!yorn_argv[@]}
    local -i index=0
    local -i current=0
    local -- arg=""
    local -- prompt_string=""

    if [ ${yorn_argc} -eq 0 ]; then
        error_prefixed "[yes_or_no_prompt]" "missing argument <PROMPT>"
        exit 1
    fi
    for index in ${!yorn_argv[@]}; do
        current=$(($index + 1))
        arg="${yorn_argv[$index]}"
        if [ -z "${prompt_string}" ]; then
            prompt_string="${arg}"
        else
            warn_prefixed "[yes_or_no_prompt]" "$(index_ordinal $index) argument is unexpected because prompt string already set to ${prompt_string@Q}: ${arg@Q}"
            exit 1
        fi
    done

    local -- yn=""
    local -- result=""
    unset IFS
    until [ -n "${yn}" ] && result=$(yes_or_no "${yn}"); do
        question_prefixed "${prompt_string}" "[y/n]"
        read yn
        yn=$(tr -d '[:space:]' <<<"${yn@L}")
        case "${yn@L}" in
            "y" | "yes")
                yn="yes"
                break
                ;;
            "n" | "no")
                yn="no"
                break
                ;;
            *) ;;
        esac
    done
}

main() {
    local -a source_files=($(find . -mindepth 1 -maxdepth 1 -type f -name '*.sh' -not -name entrypoint.sh -not -name $(basename $0)))
    local -i total=${#source_files[@]}

    for index in ${!source_files[@]}; do
        current=$(($index + 1))
        src="${source_files[$index]}"
        head=$(git rev-parse HEAD)
        base=$(path base "${src}")
        mod=$(sed -n -E 's/^[01]+[-]([a-z0-9-]+)/\1/gp' <<<"$base")
        target="${script_path}/x.d/${mod}.sh"

        local -a files_modified=(
            "${entrypoint_path}"
            ".gitignore"
            "${src}"
            "${target}"
        )

        local -- subject=""
        local -- color="2;219;80;69m" #danger
        local -- color="2;219;80;69m" #danger
        echo -e "\x1b[1;38;${color}${base@A}\x1b[0m"
        local -- color="2;249;110;99m" #danger
        echo -e "\x1b[1;38;${color}${mod@A}\x1b[0m"
        echo -en "\x1b[0m"

        # ERROR COLOR echo -en "\x1b[1;48;2;219;80;69m\x1b[1;38;2;33;33;33m"
        if [ -z "${mod}" ]; then
            echo -en "\x1b[1;38;5;79m"
            mv -fv "${src}" "${target}"
            subject="rename ${src@Q} to ${target@Q}"
        else
            if [ ! -e "${entrypoint_path}.bak" ]; then
                sed -E "s/${base}/${mod}/g" -i.${head:0:7} "${entrypoint_path}"
            fi

            if [ -e "${target}" ]; then
                export IFS=$'\n'
                subject="concatenate ${src@Q} and ${target@Q} into ${target@Q}"
                declare -a new_content=(
                    "# <old path=${src@Q}>"
                    "$(cat "${src}")"
                    "# </old path=${src@Q}>"
                    ""
                    "# <new path=${target@Q}>"
                    "$(cat "${target}")"
                    "# </new path=${target@Q}>"
                    ""
                )

                local -- color="2;166;226;46m"
                local -- inver="2;33;33;33m"
                echo -en "\x1b[1;48;${color}\x1b[1;38;${inver}[MERGE]\x1b[0m "
                echo -e "\x1b[1;38;${color}target exists: ${target}\x1b[0m"
                printf '%s\n' "${new_content[@]}" >"${target}"
                rm -f "${src}"
            else
                subject="rename ${src@Q} to ${target@Q}"
                local -- color="2;219;80;69m" #danger
                local -- color="2;244;145;1m" #warn
                local -- inver="2;33;33;33m"
                echo -en "\x1b[1;48;${color}\x1b[1;38;${inver}[ ADD ]\x1b[0m "
                echo -e "\x1b[1;38;${color}target does not exist: ${target}\x1b[0m"
                mv -fv "${src}" "${target}"
                echo -en "\x1b[0m"

            fi
        fi
        commit_message="[${current}/${total}] ${subject}"
        local -a git_bash_commands=(
            "export PS4='\[\033[1;38;5;$(( 255 % ${BASH_LINENO[0]} ))\] '"
            "set -TExuveo pipefail"
            "git add -f ${files_modified[@]}"
            "git commit ${files_modified[@]} -m \"${commit_message}\""
        )
        local -- bash_contents="$(printf '%s\n' "${git_bash_commands[@]}")" # | sed -E 's/[&]+\s*$//g')"
        if 2>${stderr} 1>${stdout} bash -c "${bash_contents}"; then
            if ! last_commit_hash=$(2>${stderr} git rev-parse HEAD); then
                local -- color="2;219;80;69m" #danger
                echo -en "\x1b[1;48;${color}\x1b[1;38;${inver}ERROR\x1b[0m "
                echo -en "\x1b[1;38;${color}\x1b[1;48;${inver}failed to git rev-parse HEAD: $(cat ${stderr})"
                action_response=$(yes-or-no-prompt)
            else
                commit_hashes+=("${last_commit_hash}")
                commits["${last_commit_hash}"]="${commit_message}"
            fi
        fi
    done
}

index_ordinal() {
    local -i index="$1"
    local -i number=$(($index + 1))
    if ! number_to_ordinal "${number}"; then
        return $?
    fi
}
number_to_ordinal() {
    local -a nto_argv=($@)
    local -i nto_argc=${!nto_argv[@]}
    local -i index=0
    local -i current=0
    local -- arg=""
    local -A inputs=()
    local -A nan=()
    local -A numbers=()
    local -a result=()

    if [ ${nto_argc} -eq 0 ]; then
        1>&2 echo -e "[${FUNCNAME[0]}:${BASH_LINENO[0]}]" "missing argument <NUMBER>"
        exit 1
    fi

    for index in ${!nto_argv[@]}; do
        current=$(($index + 1))
        arg="${nto_argv[$index]}"
        inputs[$index]="${arg}"
        local -- argnum=$(("${arg}" + 0))
        if [ $(($arg - 1)) -eq -1 ]; then # NaN
            nan[$index]="${arg}"
        else
            numbers[$index]=${argnum}
        fi
    done

    if [ ${#numbers[@]} -eq 0 ]; then
        1>&2 echo -e "[${FUNCNAME[0]}:${BASH_LINENO[0]}]" "none of the arguments is a number"
        exit 1
    fi

    for index in ${!nto_argv[@]}; do
        if [[ -v numbers[$index] ]]; then
            local -- number=${numbers[$index]}
            local -- ordinality=$(ordinality_of_number ${number})
            echo "${number}${ordinality}"
        elif [[ -v nan[$index] ]]; then
            local -- text=${nan[$index]}
            echo "${text}"
        else
            1>&2 echo -e "[${FUNCNAME[0]}:${BASH_LINENO[0]}]" "unexpected item ${index} neither in numbers nor in NaN"
            exit 1
        fi
    done
}
ordinality_of_number() {
    local -- number=${1}
    if [ $(($number - 1)) -eq 0 ]; then
        1>&2 echo -e "[${FUNCNAME[0]}:${BASH_LINENO[0]}]" "argument is not a number"
        return 1
    fi
    local -- absnum=${number##-}
    local -- last_two=$(($absnum % 100))
    local -- last_digit=$(($absnum % 10))

    case "${last_two}" in
        11 | 12 | 13)
            echo "th"
            ;;
        *)
            case "${last_digit}" in
                1)
                    echo "st"
                    ;;
                2)
                    echo "nd"
                    ;;
                3)
                    echo "rd"
                    ;;
                *)
                    echo "th"
                    ;;
            esac
            ;;
    esac
}

if [ "${0}" == "${BASH_SOURCE[0]}" ]; then
    main
else
    echo -e "${BASH_SOURCE[0]} appears to being used as a library by ${0@Q}"
fi
