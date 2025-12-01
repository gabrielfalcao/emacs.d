declare -- error_prefix_color_rgb="255;0;66"
declare -- error_color_rgb="255;62;92"
declare -- warn_prefix_color_rgb="255;106;50"
declare -- warn_color_rgb="255;161;50"
declare -- info_prefix_color_rgb="55;180;231"
declare -- info_color_rgb="25;150;201"


declare -- modified_prefix_color_rgb="151;215;255"
declare -- modified_color_rgb="121;185;255"

declare -- debug_prefix_color_rgb="39;206;121"  #27CE79
declare -- debug_color_rgb="60;193;76"   #3cc14c
declare -- added_prefix_color_rgb="39;206;121"  #27CE79
declare -- added_color_rgb="60;193;76"   #3cc14c
declare -- danger_prefix_color_rgb="249;110;99"
declare -- danger_color_rgb="219;80;69"
declare -- question_color_rgb="244;145;1"
declare -- question_prefix_color_rgb="254;155;11"

declare -- error_prefix_color_rgb="255;0;66"
declare -- error_color_rgb="255;62;92"
declare -- warn_prefix_color_rgb="255;106;50"
declare -- warn_color_rgb="255;161;50"  255;161;50
declare -- info_prefix_color_rgb="55;180;231;"
declare -- info_color_rgb="25;150;201;"
declare -- debug_prefix_color_rgb="50;255;106"
declare -- debug_color_rgb="50;255;161"
declare -- danger_prefix_color_rgb="2;249;110;99m"
declare -- danger_color_rgb="219;80;69"
declare -- question_prefix_color_rgb="255;201;18"
declare -- question_color_rgb="245;191;08"
declare -- keyword_prefix_color_rgb="238;91;143"
declare -- keyword_color_rgb="198;51;103"


# sel                     #C6DCFC
# sel                     #CFC6A6
# background              #1C1C1C
# variable                #F49101 #F5BF08
# string                  #DCDC88
# regexp                  #C63367
# admonition              #F80101
# admonition              #F937B9
# warning                 #F80101
# error                   #DB5045
# operators               #F682FF
# number                  #FC580C
# normal                  #DEDEDE
# mode-line-inactive-bg   #211F17
# mode-line-inactive-bg   #312F27
# mode-line-inactive-fg   #A66A00
# method-declaration      #A6E22E
# type-face               #36F6E9
# type-face               #1996C9
# line-fg                 #919588
# line-number             #161A1F
# current-line-number     #A66A00
# current-line-number     #F6CA51
# keywords                #F13976
# current-line            #151515
# operators               #F479C4
# operators               #79B9Ff
# operators               #EF5AAA
# constant                #FF79C6
# comments                #A79C83
# sel                     #F5BF08


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
