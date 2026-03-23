(defun insert-escape-sexp-backslash-comma()
  (interactive "*")

  (let* (
         (codepoints         '(92 44 40 41))
         (chars              (mapcar #'char-to-string codepoints))
         (output             (string-join chars ""))
         (c-buf              (current-buffer))
         (c-buf-name         (buffer-name c-buf))
         (c-buf-filename     (buffer-file-name c-buf))
         (c-mode-name        (get-mode-name c-buf))
         )

    (insert output)
    (backward-char 1)
    (c-message "\ninsert-escape-sexp-backslash-comma:\n\n%s\n\n"
               (string-join (mapcar (lambda (sym)
                                      (let* (
                                             (name  (symbol-name sym))
                                             (value (symbol-value sym))
                                             (ty    (cl-type-of value))
                                             )
                                        (format "\tsymbol `%s' is a `%s' whose value is: %S" name ty value)
                                        )
                                      )

                                    '(
                                      'codepoints
                                      'chars
                                      'output
                                      'c-buf
                                      'c-buf-name
                                      'c-buf-filename
                                      'c-mode-name
                                      )
                             )
                            "\n")
               )
    )
  )


;;;
;;;
;;;(with-c-message-open
;;; (erase-c-messages)
;;; (c-message "(insert-escape-sexp-backslash-comma)\n\n%s\n"
;;;            (insert-escape-sexp-backslash-comma)))
;;;
;;;
