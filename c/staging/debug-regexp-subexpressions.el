(defun debug-regexp-subexpressions (&rest unused-arguments)
  "this function returns a string with N+1 lines, where every line is
comprised of the subexp number and subexp contents for each subexp in
the current `match-data' in order to help debug and visualize matched
groups in interactive invocations `replace-regexp' involving relatively
complex regular expressions containing multiple groups.

this function is meant to be used as the `TO-STRING' argument of the
interactive command `replace-regexp' like so:

\,(debug-regexp-subexpressions)
"
  (let* ((regexp-groups
         (mapcar
          (lambda (g)

            (unless (and (integerp g) (>= g 0))
              (signal 'type-error (format "argument `g' should be a non-negative integer but %S is a `%s'" g (cl-type-of g ))))

            (let ((subexp-start (format "%d" g)) ;; (subexp-start (format "<%d>" g))
                  (value-prefix   "=`")
                  (value (match-string-no-properties g))
                  (value-suffix   "`")
                  (subexp-end     "")              ;; (subexp-end (format "</%d>" g))
                  (item-separator "")) ;; end let varlist
              (when (stringp value)
                (let ((items
                       (list
                        subexp-start
                        value-prefix

                        value

                        value-suffix
                        subexp-end)))
                  (string-join items item-separator) ;; (format "%d=`%s`\n" g value)
                  ))) ;
            )         ;; mapcar `function' argument #0
          (number-sequence 0
                           (- (/ (length (match-data)) 2) 1))  ;; mapcar `sequence' argument #1
          ) ;; string-join `strings' argument   #0
         )
        (result-string (format "\n%s\n\n" (string-join regexp-groups "\n" ;; string-join `separator' argument #1
                                                       )))
        ); end (let* (varlist))
    (progn
      (c-message-open "")
      (erase-c-messages)
      (c-message "%s" result-string)
      )

    (match-string 0)

    )

  ) ;; end defun debug-regexp-subexpressions

(defalias '~dbg-regex #'debug-regexp-subexpressions)
(defalias '~dbg-regexp #'debug-regexp-subexpressions)
(defalias 'dbg-regex #'debug-regexp-subexpressions)
(defalias 'dbg-regexp #'debug-regexp-subexpressions)
(defalias 'regex! #'debug-regexp-subexpressions)
