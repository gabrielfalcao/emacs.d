(defun insert-escape-sexp-backslash-comma()
  (interactive "*")

  (let* (
         (codepoints         '(92 44 40 41))
         (chars              (mapcar #'char-to-string codepoints))
         (output             (string-join chars ""))
         )
    (insert output)
    (backward-char 1)
    )
  )

(defmacro with-c-message-open (&rest body)
    `(progn
       (erase-c-messages)
       (c-message-open)
       ,@body
       ))

(progn
    (let* ((sexpr
            `(with-c-message-open
              (c-message "retval-of-insert => %S => %S"
                         (cl-type-of retval-of-insert)
                         retval-of-insert)))
           )
       (erase-c-messages)
       (c-message-open)

      (c-message "\n%S\n\n;;expands to\n\n%S\n" sexpr (macroexpand sexpr))))

;; (with-c-message-open
;;     (c-message "\nretval-of-insert => %S => %S\n" (cl-type-of retval-of-insert) retval-of-insert))
