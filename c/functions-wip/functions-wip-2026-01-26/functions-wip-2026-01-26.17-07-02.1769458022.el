(defconst 'shell-script-varname-regexp-read
  "\\(^\\|[^_]\\b\\)\\(\\([a-zA-Z_]\\)\\([a-zA-Z0-9_]*\\)\\)\\($\\|\\b[^_]\\)"
  "regular expression for matching shell-script varnames such as `${varname}' or `varname' but never `_varname_'")


(defconst 'shell-script-varname-regexp-string
  "\(^\(?:\(\s-*\)\(declare\|local\)\(\s-+[-][a-zA-Z-]+\s-*\)\)\|[^_a-zA-Z0-9_\x0a]\b\)\(\([a-zA-Z_]+\)\([a-zA-Z0-9_]*\)\)\($\|\b[^_\x0a]\)"
  "regular expression for matching shell-script varnames such as `${varname}' or `varname' but never `_varname_'")
