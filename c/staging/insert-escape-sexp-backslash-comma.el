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


;;;
;;;
;;;(with-c-message-open
;;; (erase-c-messages)
;;; (c-message "(insert-escape-sexp-backslash-comma)\n\n%s\n"
;;;            (insert-escape-sexp-backslash-comma)))
;;;
;;;
