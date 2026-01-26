(defconst 'shell-script-varname-regexp-read
  "\\(^\\|[^_]\\b\\)\\(\\([a-zA-Z_]\\)\\([a-zA-Z0-9_]*\\)\\)\\($\\|\\b[^_]\\)"
  "regular expression for matching shell-script varnames such as `${varname}' or `varname' but never `_varname_'")


(defconst 'shell-script-varname-regexp-string
  "\(^\(?:\(\s-*\)\(declare\|local\)\(\s-+[-][a-zA-Z-]+\s-*\)\)\|^\|[^_a-zA-Z0-9_\x0a]\b\)\(\([a-zA-Z_]+\)\([a-zA-Z0-9_]*\)\([[]\(?:[0-9]+\|\"[0-9]+\"\|'[0-9]+'\|[^]]+\|\"[^]]+\"\|'[^]]+'\)[]]\)?\)\(\b[^_\x0a]\|\(?:\(\s-*\)\(declare\|local\)\(\s-+[-][a-zA-Z-]+\s-*\)\)$\|$\)"
  "regular expression for matching shell-script varnames such as `${varname}' or `varname' but never `_varname_'")
