

(defun buffer-is-current-p (buffer-or-name)
  (let* (
         (buffer (and buffer-or-name (get-buffer buffer-or-name)))
         )
    (eq buffer (current-buffer))))

(c-message-open "%S" (buffer-is-current-p (current-buffer)))
