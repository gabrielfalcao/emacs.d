(defconst 'shell-script-varname-regexp-read
  "\\(^\\|[^_]\\b\\)\\(\\([a-zA-Z_]\\)\\([a-zA-Z0-9_]*\\)\\)\\($\\|\\b[^_]\\)"
  "regular expression for matching shell-script varnames such as `${varname}' or `varname' but never `_varname_'")


(defconst 'shell-script-varname-regexp-string
  "\(^\|[^_]\b\)\(\([a-zA-Z_]\)\([a-zA-Z0-9_]*\)\)\($\|\b[^_]\)"
  "regular expression for matching shell-script varnames such as `${varname}' or `varname' but never `_varname_'")
