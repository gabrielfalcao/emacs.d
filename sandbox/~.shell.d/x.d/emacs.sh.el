(defun emacs-sh-gather-local-vars()
  (let* (
         (buf-name "emacs.sh")
         (buf (get-buffer buf-name))
         (filename (progn
                     (unless buf
                       (throw-error 'type-error (format "no buffer open named %S" buf-name)))
                     (buffer-file-name buf)))
         (local-var-regexp "^\\(\\(\s-+\\)local\\)\\s-*\\(\\s-*\\([-]\\([-]\\|[a-zA-Z0-9]+\\)\\)\\s-*\\)\\([a-zA-Z_]+[a-zA-Z0-9_]*\\)\\([=]\\(.*\\)\\)$")
         (result nil)
         )
    (with-current-buffer buf
      (save-match-data-excursion-and-restriction
       (widen)
       (beginning-of-buffer)
       (while (re-search-forward local-var-regexp nil t)
         (let* (
                )
           (goto-char (match-beginning 0))
           )
         )
       )
      )
    )
  )
