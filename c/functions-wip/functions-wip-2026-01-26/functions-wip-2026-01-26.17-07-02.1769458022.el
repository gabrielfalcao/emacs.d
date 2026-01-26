(defconst 'shell-script-varname-regexp
  "\\(^\\|[^_]\\b\\)\\(\\([a-zA-Z_]\\)\\([a-zA-Z0-9_]*\\)\\)\\($\\|\\b[^_]\\)"
  "regular expression for matching shell-script varnames such as `${varname}' or `varname' but never `_varname_'")
