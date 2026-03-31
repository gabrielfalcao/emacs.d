(defun display-buffer-local-vars (&optional buffer-or-name)
  (when (null buffer-or-name)
    (setq buffer-or-name "shebang.sh"))

  (unless (or (bufferp buffer-or-name)
              (stringp buffer-or-name))
    (signal 'type-error (format "argument `buffer-or-name' must be either `string' or `buffer' but its actual value is `%s': %S"
                                (cl-type-of buffer-or-name) buffer-or-name)))

  (let* (
         (buf          (get-buffer buffer-or-name))
         (bufname      (buffer-name buf))
         (vars         (buffer-local-variables))
         (total        (length vars))
         (pos-width    (length (format "%s" total)))
         (result-items (seq-map-indexed (lambda (var-value var-idx)
                                          (let* (
                                                 (var-curpos (1+ var-idx))
                                                 (var-type   (cl-type-of var-value))
                                                 (pos        (format (format "%%%dd of %%d" pos-width) var-curpos total))
                                                 )

                                            (format "buffer-local var %s is a %S of value %S" pos var-type var-value)
                                            )
                                          )

                                        vars))
         (result-string (string-join result-items "\n"))
         )

    (string-join

     )
    )
  )
