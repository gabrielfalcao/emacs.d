;; ^[#]\s-*\([0-9]\(?:[0-9]\|[[:space:]]\)\)\(?:\s-\{4\}\)\(SIG\([A-Z0-9]\{2\}\(?:\s-\{4\}\)\|[A-Z0-9]\{3\}\(?:\s-\{3\}\)\|[A-Z0-9]\{6\}\|[A-Z0-9]\{4\}\s-\{2\}\)\)\(?:\s-\{8\}\)\([a-z[:space:]]\{17\}\)\(?:\s-\{4\}\)\([a-zA-Z0-9()/[:space:]-]+[^
;; ]*\)$

declare -a signal_lines=()
declare -A signal_name_by_number=()
declare -A signal_number_by_name=()
declare -A signal_number_by_suffix=()
declare -A signal_suffix_by_number=()
declare -A signal_default_action_by_suffix=()
declare -A signal_default_action_by_name=()
declare -A signal_default_action_by_number=()
declare -A signal_description_by_suffix=()
declare -A signal_description_by_name=()
declare -A signal_description_by_number=()


signal_lines+=("\1")
signal_name_by_number["\2"]="\3"
signal_number_by_name["\3"]="\2"
signal_number_by_suffix["\4"]="\2"
signal_suffix_by_number["\2"]="\4"
signal_default_action_by_suffix["\5"]="\4"
signal_default_action_by_name["\5"]="\3"
signal_default_action_by_number["\2"]="\5"
signal_description_by_suffix["\4"]="\6"
signal_description_by_name["\3"]="\6"
signal_description_by_number["\2"]="\6"
