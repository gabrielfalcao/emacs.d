(erase-messages)
(defun flatten (lst)
  (if (null lst)
      nil
    (if (listp (car lst))
        (append
         (flatten (car lst))
         (flatten (cdr lst)))
      (cons (car lst) (flatten (cdr lst))))))

(defun test-flatten(lst)
  (flatten '('a '(b) '(c d))))

(message (format "%s" (test-flatten)))
