(defun get-mode-name-neat-only-string(&optional buffer-or-name)
  (let* (
         (buf (cond
               ((bufferp buffer-or-name)
                 (get-buffer buffer-or-name))

               ((and (stringp buffer-or-name) (get-buffer buffer-or-name))
                 (get-buffer buffer-or-name))

               ((null buffer-or-name) (current-buffer))

               (t
                 (signal 'type-error (format "argument `buffer-or-name' must be either a `buffer', `string' with existing buffer name or `nil' but instead received a `%s': %S"
                                      (cl-type-of buffer-or-name)
                                      buffer-or-name)))))

         (strings (seq-filter (lambda (s) (and (stringp s) (not (string-match-p "[^a-zA-Z0-9_-]" s)))) (flatten-tree mode-name))))
    (when (seq-empty-p strings)
      (signal 'error (format "failed to obtain `mode-name' for buffer \"%s\"" (buffer-name buf))))

    (car strings)))

(defun get-mode-name(&optional buffer-or-name)
  (let* (
         (buf (or (and buffer-or-name (get-buffer buffer-or-name)) (current-buffer))))
    (with-current-buffer buf
      (format "%s-mode"
        (replace-regexp-in-string
          "^\\([a-z0-9-]+\\)[^A-Za-z0-9-]+.*$"
          "\\1"
          (downcase
            (cond
              ((listp mode-name)
                (car mode-name))
              ((stringp mode-name)
                mode-name)
              ((t (format "%S" mode-name))))))))))
