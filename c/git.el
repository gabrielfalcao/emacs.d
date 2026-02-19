(defun git-diff-exitcode-output (&optional ref)
  "."
  (let* ((git-diff-output-buf
          (create-fresh-buffer
           (format "*git-diff:%s*" (buffer-file-name-relative))))
         (exitcode
          (or
           (when (stringp ref)
             (call-process
              "git" nil git-diff-output-buf nil "diff" ref
              (buffer-file-name-relative)))
           (when (null ref)
             (call-process
              "git" nil git-diff-output-buf nil "diff"
              (buffer-file-name-relative)))
           (user-error
            (format "ref is neither nil nor string: %S" ref))))
         (output
          (with-current-buffer git-diff-output-buf
	    (widen)
	    (buffer-string))))
    (ignore-errors (kill-buffer git-diff-output-buf))
    (cons exitcode output)))

(defun git-diff-internal (&optional ref)
  (let* ((exitcode-output (git-diff-exitcode-output ref))
         (exitcode (nth 0 exitcode-output))
         (output (nth 1 exitcode-output))
         (buffer
          (create-fresh-buffer
           (format "*git-diff:%s*" (buffer-file-name-relative)))))
    (if (eq 0 exitcode-output)
        (progn
          (with-current-buffer buffer
            (widen)
            (diff-mode)
            (setq major-mode 'diff-mode)
            (insert output))
          (pop-to-buffer-same-window buffer t))
      (user-error (format "git diff failed with status %d" exitcode)))))

(defun git-diff () (interactive) (git-diff-internal))

(defun git-diff-head () (interactive) (git-diff-internal "HEAD"))

(defun git-diff-ref ()
  (interactive)
  (let ((ref (read-string "git diff against ref: " "HEAD")))
    (git-diff-internal ref)))



(defun git-status ()
  "."
  (interactive)
  (let* ((result (git-status-porcelain))
         (exitcode (car result))
         (output (car (cdr result))))

    (if (eq 0 exitcode)
        (message "git status ok: %s" output)
      (user-error
       (format "git-status error (%s): %s" exitcode output)))))

(defun git-current-branch ()
  (car
   (seq-filter
    (apply-partially #'string-match-p "[*]\s-\\(\\)")
    (string-lines (shell-command-to-string "git branch")))))

(defun git-save ()
  "
shortcut to calling \\[git-add] and \\[git-commit]
."
  (interactive)
  (git-add)
  (git-commit))

(defun git-commit ()
  "commits the current buffer if file has been staged (.e.g.: with \\[git-add])"
  (let* ((filename (buffer-file-name-relative))
         (commit-message
          (read-string "Commit Message: " (format "saves %s" filename)))
         (git-repo-path
          (shell-command-to-string "git rev-parse --show-toplevel"))
         (git-commit-output-buf (get-buffer-create "*git-commit*"))
         (filename-absolute
          (ensure-filename-child-of-directory filename git-repo-path))
         commit-buffer-string
         error-msg
         exit-code
         internal-error-msg);; let* varlist
    (when (zerop (length commit-message))
      (user-error "aborted due to empty commit message"))
    (setq exit-code
          (call-process "git" nil git-commit-output-buf nil "commit" "-m"
                        (format "%s" commit-message))
          commit-buffer-string
          (with-current-buffer git-commit-output-buf
	    (widen)
	    (buffer-string))
          error-msg
          (format
           "failed to commit '%s': %s" filename commit-message)

          );end setq
    (condition-case err
        (kill-buffer git-commit-output-buf)
      (error
       (setq internal-error-msg
             (format "failed to kill buffer: %s" err))))

    (if (= 0 exit-code)
        ;; then
        (message "%s commited '%s'" filename commit-message)
      ;; else
      (unless (not internal-error-msg)
        (user-error internal-error-msg))
      (user-error error-msg)); end (if (= 0
    );; end (defun (let*
  );;end defun



(defun git-commit-staged ()
  "."
  (interactive)
  (let* ((git-commit-output-buf (get-buffer-create "*git-commit*"))
         (current-working-dir
          (file-name-directory (expand-file-name (buffer-file-name))))
         (commit-message
          (read-string "Commit Message: "
                       (format "saves %s" current-working-dir)))) ;; let
    (or
     (when (zerop (length commit-message))
       (user-error "aborted due to empty commit message"))
     (if (eq 0
             (let* ((exitcode
                     (call-process "git" nil git-commit-output-buf nil "commit"
                                   "-m"
                                   (format "%s" commit-message))))
	       exitcode))
	 (progn
           (message "commited '%s'" commit-message)
           (kill-buffer git-commit-output-buf))
       (progn
         (user-error
          (format "failed to commit '%s': %s" commit-message
                  (with-current-buffer git-commit-output-buf
		    (widen)
		    (buffer-string)))
          (kill-buffer git-commit-output-buf)))))))


(defun get-regexp-github-remote-url ()
  "."
  "\\(https://github[.]com[/]\\|git@github[.]com[:]\\)\\([a-zA-Z0-9_-]+\\)[/]\\([a-zA-Z0-9_-]+\\)[.]git")

(defun get-git-remote-url-vendor-username-and-repo ()
  "."
  "\\(https://[^.]+[.][^.]+[/]\\|git@[^.]+[.][^.]+[:]\\)\\([a-zA-Z0-9_-]+\\)[/]\\([a-zA-Z0-9_-]+\\)[.]git")

(defun git-push (allow-github)
  "."
  (let* ((remotes (git-remote-names))
         (allow-github (not (null allow-github)))
         (linux-remote
          (-first
           #'(lambda (remote) (string= "linux" (car remote)))
           remotes))
         (github-remote
          (-first
           #'(lambda (remote)
	       (string-match
                (get-regexp-github-remote-url)
                (cdr remote)
                nil t )))
          remotes)
         (has-linux-remote (not (null linux-remote)))
         (has-github-remote (not (null github-remote)))
         (push-remote
          (cond
           (has-linux-remote (car linux-remote))
           ((and allow-github has-github-remote)
            github-remote)
           (t
            (-first
             #'(lambda (remote)
                 (and
                  (not (string= "linux" (car remote)))
                  (null
                   (string-match
                    (get-regexp-github-remote-url)
                    (cdr remote)
                    nil t ))))
             remotes)))))
    (cond
     ((null push-remote)
      (let ((error-message
             (format "no suitable remotes found in current git dir (allow-github=%s)"
                     (if allow-github "true" "false"))))
        (user-error error-message)
	(cons 101 error-message)))
     (t
      (let* ((remote-name (car push-remote))
             (remote-url (cdr push-remote))
             (git-push-output-buf
	      (get-buffer-create (format "*git-push-%s*" remote-name)))
             (exitcode
	      (call-process
	       "git" nil git-push-output-buf nil "push" remote-name))
             (output
	      (with-current-buffer git-push-output-buf
	        (widen)
	        (buffer-string))))
	(ignore-errors (kill-buffer git-push-output-buf))
	(cons exitcode output))))))

(defun git-remote-names ()
  "."
  (save-match-data
    (split-string
     (shell-command-to-string "git remote show -n")
     nil t )))

(defun git-remote-get-url (remote-name)
  "returns a cons cell where the head is the remote name and the tail is the remote url."
  (let ((remote-url
         (shell-command-to-string
          (format "git remote get-url %s" remote-name))))
    (cons remote-name remote-url)))

(defun git-remotes ()
  "returns list of cons cells where the head is the remote name and the tail is the remote url."
  (mapcar 'git-remote-get-url (git-remote-names)))

  ;; (progn (message  "%s" (git-remotes)))

(defun git-commit-all ()
  "."
  (interactive)
  (let *((commit-message
          (read-string "Commit Message:")))
       (or
        (when (zerop (length commit-message))
          (user-error "aborted due to empty commit message"))
        (progn
          (shell-command-to-string
           (format "git commit -a -m '%s'" commit-message))))))

(defun git-autocommit-current-file-buffer ()
  (let* ((current-branch-name (git-current-branch))
         (last-commit-message
          (shell-command-to-string "git log --max-count=1 --format=%s"))
         (branch-name
          (format "%s@%s"
                  (Ox33b4O/$/hash-take-last-n-chars 'sha512 8 filename)
                  (file-name-nondirectory filename))))
    (shell-command-to-string (format "git branch %s" branch-name))
    (shell-command-to-string (format "git checkout %s" branch-name))
    (shell-command-to-string (format "git add --renormalize -f %s" filename))
    (shell-command-to-string
     (format "git commit %s -m '%s'" filename
             (file-name-nondirectory filename)))
    (shell-command-to-string
     (format "git checkout %s" current-branch-name))
    (shell-command-to-string
     (format "git merge --squash %s --no-commit" branch-name))
    (shell-command-to-string
     (format "git commit --amend -m '%s'"
             (format "%s\n%s (%s)" last-commit-message
                     (file-name-nondirectory filename)
                     (format-time-string "%Y-%m-%d %H:%M:%S"))))
    (set-buffer-modified-p nil)))

(defun git-autocommit-opt-libexec ()
  "."
  (when-buffer-filename-meets
   (string-match-p
    (concat "^" (getenv "HOME") "/opt/libexec")
    filename)
   (git-autocommit-current-file-buffer)
   (message  "auto-commited %s" filename)))

(defun git-autocommit-emacs-d-c-sources ()
  "."
  (when-buffer-filename-matches
   (concat "^" (getenv "HOME") "/.emacs.d/c")
   (git-autocommit-current-file-buffer)
   (message "auto-commited emacs file %s" filename)))


(defun git-add ()
  "."
  (interactive)
  (shell-command-to-string
   (format "git add --renormalize -f %s" (expand-file-name (buffer-file-name)))))

(defun git-rm-force ()
  "."
  (interactive)
  (shell-command-to-string
   (format "git rm --force %s" (expand-file-name (buffer-file-name)))))

(defun git-rm-cached ()
  "."
  (interactive)
  (shell-command-to-string
   (format "git rm --cached %s"
           (expand-file-name (buffer-file-name)))))

(defun git-restore-staged ()
  "."
  (interactive)
  (shell-command-to-string
   (format "git restore --staged %s"
           (expand-file-name (buffer-file-name))))
  (shell-command-to-string
   (format "git restore %s" (expand-file-name (buffer-file-name))))
  (revert-buffer t t t))


(defun git-restore ()
  "."
  (interactive)
  (shell-command-to-string
   (format "git restore %s" (expand-file-name (buffer-file-name))))
  (revert-buffer t t t))


(defun git-rev-parse (arg)
  "."
  (let* ((extra-args
          (if (listp arg) arg '((format "%S" arg))))
         (call-process-args
          (append
           '("git" nil git-rev-parse-output-buf nil "rev-parse")
           extra-args))
         (git-rev-parse-output-buf
          (get-buffer-create "*git-rev-parse*"))
         (exitcode (apply #'call-process call-process-args))
         (output
          (with-current-buffer git-rev-parse-output-buf
	    (widen)
	    (buffer-string))))
    (ignore-errors (kill-buffer git-rev-parse-output-buf))
    (cons exitcode output)))

(defun git-delete ()
  "runs \"git rm -rf \" against `buffer-file-name'."
  (interactive)
  (let* ((git-status-output-buf (get-buffer-create "*git-delete*"))
         (exitcode
          (call-process
           "git" nil git-status-output-buf nil "rm" "-rf"
           (buffer-file-name)))
         (output
          (with-current-buffer git-status-output-buf
	    (widen)
	    (buffer-string))))
    (ignore-errors (kill-buffer git-status-output-buf))
    (cons exitcode output)))


  ;; git-status-porcelain stuff
(defun git-status-porcelain ()
  "."
  (let* ((git-status-output-buf
          (get-buffer-create "*git-status-porcelain*"))
         (exitcode
          (call-process
           "git" nil git-status-output-buf nil "status" "--porcelain"))
         (output
          (with-current-buffer git-status-output-buf
	    (widen)
	    (buffer-string))))
    (ignore-errors (kill-buffer git-status-output-buf))
    (list exitcode output)))

  ;; (defconst git-status-porcelain-class-group-regexp
  ;;   "\\([[:space:]!?ACDMRTU]\\)"

  ;;   "regular expression used within `git-status-porcelain-class-group-regexp' in call to `string-match'."
  ;;   )

(defconst git-status-porcelain-regexp
  ;; "^\\(.\\)\\(.\\)\\s-+\\(.+\\)$"
  "^\\([[:space:]!?ACDMRTU]\\)\\([[:space:]!?ACDMRTU]\\)[[:space:]]+\\(.*\\)$"

  "regular expression used within `git-status-get-filenames' in call to `string-match'.")

(defun git-status-porcelain-class-char-to-symbol(char)
  "`maps the given `char' to semantic symbols according to table below:

' ' = unmodified
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
  (let ((input
         (cond
          ((or (stringp char) (characterp char))
	   (format "%s" char))
	  ((and (listp char) (length= char 1))
	   (car char))
	  (t
	   (error "invalid value (neither string nor character) for argument `char': %S" char))))
        (len (length input)))
    (if (> len 1)
        (error "`char' argument must be a string of length 1, instead got `%S' (normalized to `%s' of length `%d')"
	       char input len))
    (cond

     ((string= " " input)
      (list :sym 'unmodified :desc "" :long_desc "unmodified")
      ;; end list
      );; end clause

     ((string= "!" input)
      (list :sym 'ignored :desc "" :long_desc "ignored")
      ;; end list
      );; end clause

     ((string= "?" input)
      (list :sym 'untracked :desc "" :long_desc "untracked")
      ;; end list
      );; end clause

     ((string= "A" input)
      (list :sym 'added :desc "" :long_desc "added")
      ;; end list
      );; end clause

     ((string= "C" input)
      (list :sym 'copied
	    :desc ""
	    :long_desc "copied (if config option status.renames is set to \"copies\")"
	    :note "(if config option status.renames is set to \"copies\")"
	    )
      ;; end list
      );; end clause

     ((string= "D" input)
      (list :sym 'deleted :desc "" :long_desc "deleted")
      ;; end list
      );; end clause

     ((string= "M" input)
      (list :sym 'modified :desc "" :long_desc "modified")
      ;; end list
      );; end clause

     ((string= "R" input)
      (list :sym 'renamed :desc "" :long_desc "renamed")
      ;; end list
      );; end clause

     ((string= "T" input)
      (list :sym 'file
	    :desc " type changed"
	    :long_desc "file type changed (regular file, symbolic link or submodule)"
	    :note "(regular file, symbolic link or submodule)"
	    )
      ;; end list
      );; end clause

     ((string= "U" input)
      (list :sym 'updated
	    :desc " but unmerged"
	    :long_desc "updated but unmerged")
      ;; end list
      );; end clause


     );;end cond
    );;end let
  );; end defun git-status-porcelain-class-char-to-symbol

(defun git-status-porcelain-categorized()
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

  (let* ((status-code-and-output (git-status-porcelain))
         (status (car status-code-and-output))
         (output (car (cdr status-code-and-output)))
         (output-lines (save-match-data (string-lines output t)))
         ;; (seq-filter #'numberp '(a b 3 4 f 6))
         ;;   ⇒ (3 4 6)
         ;;
         ;; (seq-remove #'numberp '(1 2 c d 5))
         ;;   ⇒ (c d)

         (classified-paths
	  ;;(seq-remove #'null
          (mapcar
           #'(lambda (line)
	       (save-match-data
                 (setq case-fold-search nil) ;; case sensitive
	         (if (string-match git-status-porcelain-regexp line)
		     (let ((staged (match-string 1 line))   ;; then
			   (unstaged (match-string 2 line)) ;; then
			   (path (match-string 3 line)))    ;; then
		       (list 'staged staged             ;; then
			     'unstaged unstaged         ;; then
			     'path path))               ;; end inner let varlist

                   ;; else
                   nil ;; else ;; KGxpc3QgJ3N0YWdlZCBuaWwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICd1bnN0YWdlZCBuaWwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICdwYXRoIG5pbCkpKQ==
                   ) ;;end if
                 ) ;; end save-match-data
	       ) ;;end lambda
           ;; sequence
           output-lines ;; sequence
           ) ;; mapcar
	  ;; ) ;;seq-remove
          ))  ;; end let* varlist
    ;; let* [body]
    (let ;; [debug]
        ((result
          (format "
status=%S
output=%S
output-lines=%S
classified-paths=%S
"
                  status
                  output
                  output-lines
                  classified-paths))) ;; end varlist let[debug]
      ;; let[debug] body
      (erase-messages)
      (message "%s" result)
      (c-message-open "%s" result));; end let[debug]
    ) ;;end let*
  );; end defun git-status-get-filenames

(defun file-is-git-tracked ()
  "."
  (let* ((status-output (git-rev-parse (buffer-file-name)))
         (status (car status-output))
         (output (car (cdr status-output))))
    (eq 0 status)))
