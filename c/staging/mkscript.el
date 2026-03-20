
(defun mkscript (&optional owner-only buffer-or-name)
  (let* (
         (buffer (and buffer-or-name (get-buffer buffer-or-name)))
         (buffer-is-current (pcase buffer
                              (pred (eql (current-buffer))
         (buffer-name (buffer-name buffer))
         (filename (buffer-file-name buffer))
         )
    (unless filename
      (signal 'argument-error (format ""

  (chmod ((or (and owner-only "u+x") "a+x")
