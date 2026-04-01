(defun wezterm-list-active-cwds-by-ctime()
  (let* (
         (shell-pipe-command-list (list "wezterm cli list  --format=json"
                                        "jq -r '.[].cwd | match(\"^(file://)(.*?)[/]?$\") | .captures[-1].string'"
                                        "xargs -Ieachpath gstat -c '%W %Y eachpath' 'eachpath'"
                                        "sort -nr"
                                        "gawk '{ path=\"\"; last=\"\"; for (i=3;i<=NF;i++) { if ((i+2) == NF) { last=\"\n\"; }; path=sprintf(\"%s%s%s\", path, $i, last); }; if (!printed_paths[path]) { printed_paths[path]=NR; print(path);} }'"
                                        ))
         (command (string-join shell-pipe-command-list " | "))
         (stdout (shell-command-to-string command))
         (lines (mapcar #'string-trim (string-split stdout "\n" t)))
         )
    lines
    )
  )


(defun wezterm-get-newest-cwd()
  (let* (
         (items (wezterm-list-active-cwds-by-ctime))
         )
    (and (length> items 0) (car items))))
