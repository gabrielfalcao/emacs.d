(defvar wezterm-eval-shell-script-read-input-history (list))

(defun wezterm-eval-shell-script-read-input (prompt)
  (setq c-message-write-to-minibuffer nil)
  (let* ((initial-input
          (car wezterm-eval-shell-script-read-input-history))
         (arg-prefix
          (string-trim
           (read-string
            (format "%s: " prompt)
            initial-input
            'wezterm-eval-shell-script-read-input-history))))
    (add-to-history 'wezterm-eval-shell-script-read-input-history arg-prefix)
    (list arg-prefix)))


(defun wezterm-eval-shell-script-string(script-code)
  (interactive
   (wezterm-eval-shell-script-read-input-history "script"))

  (let ((rust-file-name
         (expand-file-name
          (read-file-name
           "insert members of rust file: "
           (rust-path-to-current-file-mod)
           nil 'confirm-after-completion))))

    (let* ((tmp-buffer-name
            (format "*rust-autocomplete:%s*" rust-file-name))
           (tmp-buffer (get-buffer-create tmp-buffer-name))
           (exit-code
            (call-process "rust-autocomplete" nil tmp-buffer nil "list" "--docs" rust-file-name)))
      (if (eq 0 exit-code)
          (let ((items
                 (with-current-buffer tmp-buffer
                   (widen)
                   (buffer-substring-no-properties
                    (point-min)
                    (point-max)))))
            (kill-buffer tmp-buffer)
            (insert (format "\n%s\n" items))
            (rust-format-buffer))
	(progn
          (switch-to-buffer tmp-buffer)
          (user-error
           (format "failed to list items of file %s"
                   (abbreviate-file-name (rust-file-name)))))))))

)
