


(defun shell-script-add-missing-semicolon-to-region()

declare -F | sed -n -E 's/^\s*(declare\s+[-][Ff]+\s*)\s*([a-zA-Z_]+[a-zA-Z0-9_]*)\s*([=]?(.*))?$/\2
/gp'

)
