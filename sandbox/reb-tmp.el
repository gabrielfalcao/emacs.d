(defun git-status-get-filenames()
  "runs git status --porcelain=v1 in the current working directory and parses the status characters according to the list below:

` ' = unmodified
`!' = ignored
`?' = untracked
`A' = added
`C' = copied (if config option status.renames is set to \"copies\")
`D' = deleted
`M' = modified
`R' = renamed
`T' = file type changed (regular file, symbolic link or submodule)
`U' = updated but unmerged

."
  (interactive)
  ;;(replace-regexp-in-string regexp rep string &optional fixedcase literal subexp start)
)
