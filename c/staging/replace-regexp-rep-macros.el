(define-error 'syntax-error  "Syntax Error" 'error)
(define-error 'macro-syntax-error  "Macro Syntax Error" 'syntax-error)

(defmacro map-subexps (args &rest body)
  (unless (listp args)
    (signal 'macro-syntax-error
            (format "macro `map-subexps' receives a list of arguments but its first form is a %s: %S"
                    (type-of args)
                    args)))
  (unless (length= args 2)
    (signal 'macro-syntax-error
            (format "macro `map-subexps' receives a list of exactly 2 arguments but instead got %d arguments"
                    (length args))))

  (erase-c-messages)
  (c-message-open "macro `map-subexps'")
  (c-message      "    args (%s): %S" (type-of args) args)
  (c-message      "    body (%s): %S" (type-of body) body)

  (let* ((total-subexps
          (- (/ (length (match-data)) 2) 1)))
    (let* ((arg-subexp (car args))
           (arg-total-subexps (nth 1 args)))

      (c-message "           arg-subexp (%s): %S"
                 (type-of arg-subexp)
                 arg-subexp)
      (c-message "    arg-total-subexps (%s): %S"
                 (type-of arg-total-subexps)
                 arg-total-subexps)

      (string-join
       (mapcar (lambda (subexp) ,@body))
       (number-sequence 1 total-subexps)))))


;;(string-join (mapcar (lambda (num) (let ((val (match-string num))) (and val (downcase (format "%d%s" (string-to-number (downcase val) 16) (or (and (= num pairs) "m") ";")))))) (number-sequence 1 pairs)))
