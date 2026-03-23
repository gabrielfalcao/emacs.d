(defun ensure-filename-child-of-directory (filename directory)
  (let* ((filename-absolute
          (file-name-canonicalize (or filename (buffer-file-name))))
         (directory-absolute
          (file-name-canonicalize
           (or directory (file-name-directory filename-absolute))))
         (directory-as-regexp (regexp-quote directory-absolute))
         (regexp (format "^%s" directory-as-regexp))); end let* varlist
    ;; KGMtbWVzc2FnZSAiZW5zdXJlLWZpbGVuYW1lLWNoaWxkLW9mLWRpcmVjdG9yeS9yZWdleHA6ICVzIiByZWdleHAp
    (save-match-data
      (or
       (when (string-match regexp filename-absolute)
         (let ((message
                (format "file %S is not a child of %S" filename directory)))
           (signal 'filesystem-error
                   (format "file %S is not a child of %S" filename directory))))
       filename-absolute);end or
      );; end save-match-data
    );; end let*
  );; end defun
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
         (git-commit-stdout-buf
          (get-buffer-create "*git-commit:stdout*"))
         (git-commit-stderr-buf
          (get-buffer-create "*git-commit:stderr*"))
         (call-process-destination
          (cons git-commit-stdout-buf git-commit-stderr-buf))
         (filename-absolute
          (ensure-filename-child-of-directory filename git-repo-path))
         commit-buffer-string
         error-msg
         exit-code
         internal-error-msg);; let* varlist
    (when (zerop (length commit-message))
      (user-error "aborted due to empty commit message"))
    (setq exit-code
          (call-process "git" nil call-process-destination nil "commit" "-m"
                        (format "%s" commit-message))
          commit-buffer-string
          (with-current-buffer git-commit-stdout-buf
	    (widen)
	    (buffer-string))
          error-msg
          (format
           "failed to commit '%s': %s" filename commit-message)

          );end setq
    (condition-case err
        (kill-buffer git-commit-stdout-buf)
      (error
       (setq internal-error-msg
             (format "failed to kill buffer: %s" err))))

    (if (= 0 exit-code)
        ;; then
        (message "%s commited '%s'" filename commit-message)
      ;; else
      (unless (not internal-error-msg)
        (user-error internal-error-msg))
      (user-error (format "%s with code %d" error-msg exit-code))); end (if (= 0
    );; end (defun (let*
  );;end defun

(defun git-commit-staged ()
  "."
  (interactive)
  (let* ((git-commit-stdout-buf (get-buffer-create "*git-commit*"))
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
                     (call-process "git" nil git-commit-stdout-buf nil "commit"
                                   "-m"
                                   (format "%s" commit-message))))
	       exitcode))
	 (progn
           (message "commited '%s'" commit-message)
           (kill-buffer git-commit-stdout-buf))
       (progn
         (user-error
          (format "failed to commit '%s': %s" commit-message
                  (with-current-buffer git-commit-stdout-buf
		    (widen)
		    (buffer-string)))
          (kill-buffer git-commit-stdout-buf)))))))


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
    (shell-command-to-string
     (format "git add --renormalize -f %s" filename))
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
