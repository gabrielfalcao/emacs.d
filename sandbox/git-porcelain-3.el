;; (defconst git-status-porcelain-class-regexp
;;   "^`\\([[:space:]ACDMRTU!?]\\)'\\s-*=\\s-*\\(\\([a-z]+\\)\\(\\s-*\\([a-z]+\\|\\s-*\\)*\\)\\(\\s-+\\([(].*\\)\\)*\\)?$")

;; (defconst git-status-porcelain-class-replacement
;;   "((string= \"\1\" input)\n (list :sym '\3\n :desc \"\4\"\n :long_desc \"\2\"\n :note \"\7\"\n) \n;; \\3 => \3\n;; \\6 => \6\n;; end list \n);; end clause\n\n"
;;   )

;; (save-mark-and-excursion
;;   (widen)
;;   (beginning-of-buffer)
;;   (save-mark-and-excursion
;;     (replace-regexp-in-region
;;      git-status-porcelain-class-regexp
;;      git-status-porcelain-class-replacement
;;      (point-min)
;;      (point-max)
;;      ))
;;   (save-mark-and-excursion
;;     (flush-lines ":note\s-+\"\"" (point-min) (point-max) nil)
;;     )
;;   (save-mark-and-excursion
;;     (flush-lines ";\s-*\\[36]" (point-min) (point-max) nil)
;;     )
;;   )

(defun map-git-porcelain(char)
  "."
  (cond
   ((string= " " input)
    (list :sym 'unmodified
	  :long_desc "unmodified"
	  )
    )
   ((string= "!" input)
    (list :sym 'ignored
	  :long_desc "ignored"
	  )
    )
   ((string= "?" input)
    (list :sym 'untracked
	  :long_desc "untracked"
	  )
    )
   ((string= "A" input)
    (list :sym 'added
	  :long_desc "added"
	  )
    )
   ((string= "C" input)
    (list :sym 'copied
	  :long_desc "copied (if config option status.renames is set to \"copies\")"
	  :note "(if config option status.renames is set to \"copies\")"
	  )
    )
   ((string= "D" input)
    (list :sym 'deleted
	  :long_desc "deleted"
	  )
    )
   ((string= "M" input)
    (list :sym 'modified
	  :long_desc "modified"
	  )
    )
   ((string= "R" input)
    (list :sym 'renamed
	  :long_desc "renamed"
	  )
    )
   ((string= "T" input)
    (list :sym 'file
	  :desc " type changed"
	  :long_desc "file type changed (regular file, symbolic link or submodule)"
	  :note "(regular file, symbolic link or submodule)"
	  )
    )
   ((string= "U" input)
    (list :sym 'updated
	  :desc " but unmerged"
	  :long_desc "updated but unmerged"
	  )
    )
   (t (list))
   )
  )
