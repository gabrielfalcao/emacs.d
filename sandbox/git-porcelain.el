;; (widen)
;; (beginning-of-buffer)
;; (replace-regexp
;;  "^`\\([[:space:]ACDMRTU!?]\\)'\\s-*=\\s-*\\(\\([a-z]+\\)\\(\\s-*\\([a-z]+\\|\\s-*\\)*\\)\\(\\s-+\\([(].*\\)\\)*\\)?$"
;;  ";; <begin `\\1'\\n;; \\\\1 => \"\\1\"\\n;; \\\\2 => \"\\2\"\\n;; \\\\3 => \"\\3\"\\n;; \\\\4 => \"\\4\"\\n;; \\\\5 => \"\\5\"\\n;; \\\\6 => \"\\6\"\\n;; \\\\7 => \"\\7\"\\n;; \\\\8 => \"\\8\"\\n;; \\\\9 => \"\\9\"\\n;; </end `\\1'>\\n\\n\\n"
;;  );; replace-regexp
;; (flush-lines "[=][>]\\s-+\"\\(\\s-[^\"]\\)?")
(defun git-status-porcelain-categorized()
  "runs git status --porcelain=v1 in the current working directory and parses the status characters according to the list below:

;; <begin ` '
;; \1 => " "
;; \2 => "unmodified"
;; \3 => "unmodified"
;; </end ` '>

;; <begin `!'
;; \1 => "!"
;; \2 => "ignored"
;; \3 => "ignored"
;; </end `!'>

;; <begin `?'
;; \1 => "?"
;; \2 => "untracked"
;; \3 => "untracked"
;; </end `?'>

;; <begin `A'
;; \1 => "A"
;; \2 => "added"
;; \3 => "added"
;; </end `A'>

;; <begin `C'
;; \1 => "C"
;; \2 => "copied (if config option status.renames is set to \"copies\")"
;; \3 => "copied"
;; \7 => "(if config option status.renames is set to \"copies\")"
;; </end `C'>

;; <begin `D'
;; \1 => "D"
;; \2 => "deleted"
;; \3 => "deleted"
;; </end `D'>

;; <begin `M'
;; \1 => "M"
;; \2 => "modified"
;; \3 => "modified"
;; </end `M'>

;; <begin `R'
;; \1 => "R"
;; \2 => "renamed"
;; \3 => "renamed"
;; </end `R'>

;; <begin `T'
;; \1 => "T"
;; \2 => "file type changed (regular file, symbolic link or submodule)"
;; \3 => "file"
;; \7 => "(regular file, symbolic link or submodule)"
;; </end `T'>

;; <begin `U'
;; \1 => "U"
;; \2 => "updated but unmerged"
;; \3 => "updated"
;; </end `U'>
."
  (interactive)
  ;;(replace-regexp-in-string regexp rep string &optional fixedcase literal subexp start)
)
