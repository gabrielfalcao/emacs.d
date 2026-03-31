(safe-load-file (expand-file-name "~/.emacs.d/c/staging/c-message/c-message-suite.el"))

(defun debug-regexp-subexpressions/seq-map-indexed-function (subexp idx)
  (unless (natnump subexp)
    (signal 'type-error
            (format "argument `subexp' should be a natural number but %S is a `%s'" subexp
                    (cl-type-of subexp))))

  (let (
					;
        (subexp-start (format "%s" subexp)) ;; (subexp-start (format "<%d>" subexp))
        (value-prefix   "=`")
        (value (condition-case err
                   (match-string-no-properties subexp)
                 (error
                  (erase-messages)
                  (message "error getting subexp index %S %S: %s" idx subexp err)
                  ""
                  )
                 )
               )
        (value-suffix   "`")
        (subexp-end     "")              ;; (subexp-end (format "</%d>" subexp))
        (item-separator " => ")
					;
        )
    (when (stringp value)
      (let ((items
             (list
              subexp-start
              value-prefix

              value

              value-suffix
              subexp-end)))
        (format "%s\n" (string-join items item-separator)) ;; (format "%d=`%s`\n" subexp value)
        ))) ;
  )

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
  (let* ( ;;
         (md                                        (match-data))
         (md-len                                    (length md))
         (pairs                                     (/ md-len 2))
         (subexp-count                              (- pairs 1))
         (subexp-range-seq                          (number-sequence 0 subexp-count))
         (subexp-dbg-strings                        (seq-map-indexed #'debug-regexp-subexpressions/seq-map-indexed-function subexp-range-seq))
         (result-string                             (format "\n%s\n\n" (string-join subexp-dbg-strings "\n")))
         (existing-c-messages-buffer                (seq-reduce (lambda (buf next-buf)
					                          (cond
					                           ((and (bufferp buf)
						                         (string= (buffer-name buf) "*C-Messages*"))
					                            buf)

					                           ((and (bufferp next-buf)
						                         (string= (buffer-name next-buf) "*C-Messages*"))
					                            next-buf))
					                          )
					                        (buffer-list) (current-buffer)))

         )
        ;;;      (unless (c-message-visible-p (current-buffer))
        ;;;        (c-message-open))
        ;;;
        ;;;      (erase-c-messages)
    (unless (and (bufferp       existing-c-messages-buffer)
                 (buffer-live-p existing-c-messages-buffer))
      (c-message-open))

    (c-message "%s" result-string)
    (match-string 0)

    )
  )



(defalias '~dbg-regex #'debug-regexp-subexpressions)
(defalias '~dbg-regexp #'debug-regexp-subexpressions)
(defalias 'dbg-regex #'debug-regexp-subexpressions)
(defalias 'dbg-regexp #'debug-regexp-subexpressions)
(defalias 'regex! #'debug-regexp-subexpressions)
