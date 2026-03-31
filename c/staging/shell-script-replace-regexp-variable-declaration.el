(defconst shell-script-variable-declaration-regexp

  ^\(\s-*\)\(declare\|local\)[[:space:]]+\([-]\([-]\|[a-zA-Z]+\)\)[[:space:]]+\([a-zA-Z_]+[a-zA-Z0-9_]*\)\(=\(["]\([^"
                                                                                                               ]*\)["]\|[0-9]+\|\(.*\)\)\|\(.*\)\)$

)
