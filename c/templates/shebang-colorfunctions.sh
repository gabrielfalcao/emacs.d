declare -- error_prefix_color_rgb="255;0;66" # red=255 green=0 blue=66
declare -- error_color_rgb="255;62;92" # red=255 green=62 blue=92
declare -- warn_prefix_color_rgb="255;106;50" # red=255 green=106 blue=50
declare -- warn_color_rgb="255;161;50" # red=255 green=161 blue=50
declare -- info_prefix_color_rgb="55;180;231" # red=55 green=180 blue=231
declare -- info_color_rgb="25;150;201" # red=25 green=150 blue=201


declare -- modified_prefix_color_rgb="151;215;255" # red=151 green=215 blue=255
declare -- modified_color_rgb="121;185;255" # red=121 green=185 blue=255

declare -- debug_prefix_color_rgb="39;206;121" # red=39 green=206 blue=121  #27CE79
declare -- debug_color_rgb="60;193;76" # red=60 green=193 blue=76   #3cc14c
declare -- added_prefix_color_rgb="39;206;121" # red=39 green=206 blue=121  #27CE79
declare -- added_color_rgb="60;193;76" # red=60 green=193 blue=76   #3cc14c
declare -- danger_prefix_color_rgb="249;110;99" # red=249 green=110 blue=99
declare -- danger_color_rgb="219;80;69" # red=219 green=80 blue=69
declare -- question_color_rgb="244;145;1" # red=244 green=145 blue=1
declare -- question_prefix_color_rgb="254;155;11" # red=254 green=155 blue=11

declare -- error_prefix_color_rgb="255;0;66" # red=255 green=0 blue=66
declare -- error_color_rgb="255;62;92" # red=255 green=62 blue=92
declare -- warn_prefix_color_rgb="255;106;50" # red=255 green=106 blue=50
declare -- warn_color_rgb="255;161;50" # red=255 green=161 blue=50  # 255;161;50
declare -- info_prefix_color_rgb="55;180;231;"
declare -- info_color_rgb="25;150;201;"
declare -- debug_prefix_color_rgb="50;255;106" # red=50 green=255 blue=106
declare -- debug_color_rgb="50;255;161" # red=50 green=255 blue=161
declare -- danger_prefix_color_rgb="2;249;110;99m"
declare -- danger_color_rgb="219;80;69" # red=219 green=80 blue=69
declare -- question_prefix_color_rgb="255;201;18" # red=255 green=201 blue=18
declare -- question_color_rgb="245;191;08" # red=245 green=191 blue=08
declare -- keyword_prefix_color_rgb="238;91;143" # red=238 green=91 blue=143
declare -- keyword_color_rgb="198;51;103" # red=198 green=51 blue=103


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
register_color "standard-dark" #2E222F  \x1b[1;38;2;46,34,47       46,  34,  47
register_color "standard-medium" #AB947A  \x1b[1;38;2;171,148,122   171, 148, 122
register_color "standard-light" #C7DCD0  \x1b[1;38;2;199,220,208   199, 220, 208
register_color "error" #EA4F36  \x1b[1;38;2;234,79,54     234,  79,  54
register_color "error" #E83B3B  \x1b[1;38;2;232,59,59     232,  59,  59
register_color "danger" #FB6B1D  \x1b[1;38;2;251,107,29    251, 107,  29
register_color "warning" #F79617  \x1b[1;38;2;247,150,23    247, 150,  23
register_color "seealso" #F9C22B  \x1b[1;38;2;249,194,43    249, 194,  43
register_color "warn" #CD683D  \x1b[1;38;2;205,104,61    205, 104,  61
register_color "alert" #FBB954  \x1b[1;38;2;251,185,84    251, 185,  84
register_color "info" #A2A947  \x1b[1;38;2;162,169,71    162, 169,  71
register_color "success" #D5E04B  \x1b[1;38;2;213,224,75    213, 224,  75
register_color "note" #FBFF86  \x1b[1;38;2;251,255,134   251, 255, 134
register_color "info" #1EBC73  \x1b[1;38;2;30,188,115     30, 188, 115
register_color "info" #91DB69  \x1b[1;38;2;145,219,105   145, 219, 105
register_color "standard-dark" #313638  \x1b[1;38;2;49,54,56       49,  54,  56
register_color "standard-medium" #92A984  \x1b[1;38;2;146,169,132   146, 169, 132
register_color "standard-light" #B2BA90  \x1b[1;38;2;178,186,144   178, 186, 144
register_color "info" #0EAF9B  \x1b[1;38;2;14,175,155     14, 175, 155
register_color "info" #30E1B9  \x1b[1;38;2;48,225,185     48, 225, 185
register_color "info" #8FF8E2  \x1b[1;38;2;143,248,226   143, 248, 226
register_color "note" #4D9BE6  \x1b[1;38;2;77,155,230     77, 155, 230
register_color "note" #8FD3FF  \x1b[1;38;2;143,211,255   143, 211, 255
register_color "debug" #A884F3  \x1b[1;38;2;168,132,243   168, 132, 243
register_color "debug" #EAADED  \x1b[1;38;2;234,173,237   234, 173, 237
register_color "debug" #F04F78  \x1b[1;38;2;240,79,120    240,  79, 120
register_color "info" #FCA790  \x1b[1;38;2;252,167,144   252, 167, 144
register_color "info" #FDCBB0  \x1b[1;38;2;253,203,176   253, 203, 176
