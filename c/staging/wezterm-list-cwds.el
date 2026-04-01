(defun wezterm-list-active-cwds-by-ctime()
  (let* (
         (commands (list
                    "wezterm cli list  --format=json | jq -r '.[].cwd | match(\"^(file://)(.*?)[/]?$\") | .captures[-1].string' | xargs -Ieachpath gstat -c '%W %Y eachpath' 'eachpath' | sort -nr | gawk '{ path=\"\"; last=\"\"; for (i=3;i<=NF;i++) { if ((i+2) == NF) { last=\"\n\"; }; path=sprintf(\"%s%s%s\", path, $i, last); }; if (!printed_paths[path]) { printed_paths[path]=NR; print(path);} }' | head -1")
                   )
         (stdout (shell-command-to-string (string-join commands " | ")))
         )
    )
  )
