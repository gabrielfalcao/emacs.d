(defun extract-regexp-subexprs-in-buffer (buffer-or-name &optional beg end)
  (unless (or (stringp buffer-or-name)
              (bufferp buffer-or-name))
    (signal 'type-error
            (format  "[extract-regexp-subexprs-in-buffer] argument `buffer-or-name' must be either a `buffer' or `string' but instead received `%s': %s"
                     (type-of buffer-or-name)
                     buffer-or-name)))

  (unless (> end beg)
    (signal 'type-error
            (format  "[extract-regexp-subexprs-in-buffer] argument `end' (%d) must be greater than argument `beg' (%d)"
                     end beg)))


  (let* (
         (buffer (let ((buf (get-buffer buffer-or-name)))
                   (unless (bufferp buf)
                     (signal 'type-error
                             (format  "[extract-regexp-subexprs-in-buffer] argument `buffer-or-name' must be an existing buffer but the %s %S led to: %s"
                                      (type-of buffer-or-name)
                                      (or (and (stringp buffer-or-name) (format "%S" buffer-or-name))
                                          (format "%s" buffer-or-name))
                                      buffer-or-name)))
                   buf))
         (actual-beg beg)
         (actual-end end)
         )
    (save-match-data
      (save-mark-and-excursion
