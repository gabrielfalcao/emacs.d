(safe-load-file
 (expand-file-name "~/.emacs.d/c/staging/c-message/c-message-suite.el"))

(defun debug-regexp-subexpressions/seq-map-indexed-function (subexp idx)
  (unless (natnump subexp)
    (signal 'type-error
            (format "argument `subexp' should be a natural number but %S is a `%s'" subexp
                    (cl-type-of subexp))))

  (let (;
        (subexp-start (format "%d" subexp)) ;; (subexp-start (format "<%d>" subexp))
        (value-prefix   "=`")
        (value
         (condition-case err
             (match-string-no-properties subexp)
           (error
            (warn "error getting subexp index %S %S: %s" idx subexp err)
            "")))
        (value-suffix   "`")
        (subexp-end     "")              ;; (subexp-end (format "</%d>" subexp))
        (item-separator " => ")
        ;;
        )
    (cond
     ((when (stringp value)
        (let ((items
               (list
                subexp-start
                value-prefix

                value

                value-suffix
                subexp-end)))
          (format "%s\n" (string-join items item-separator)) ;; (format "%d=`%s`\n" subexp value)
          ))
      )
     (t
      (format "WAT"))
     )
    )
  )

(defun debug-regexp-subexpressions (&optional erase-messages-on &rest unused-arguments)
  "this function returns a string with N+1 lines, where every line is
comprised of the subexp number and subexp contents for each subexp in
the current `match-data' in order to help debug and visualize matched
groups in interactive invocations `replace-regexp' involving relatively
complex regular expressions containing multiple groups.

this function is meant to be used as the `TO-STRING' argument of the
interactive command `replace-regexp' like so:

\,(debug-regexp-subexpressions)
"
  (save-mark-excursion-and-match-data
    (let* (;;
           (md (match-data))
           (md-len (length md))
           (pairs (/ md-len 2))
           (c-messages-is-visible (c-message-visible-p))
           (subexp-count (- pairs 1))
           (subexp-range-seq (number-sequence 1 subexp-count))
           (subexp-dbg-strings (list))
           (result-string         "")
           ;;
           )
      (unless c-messages-is-visible (c-message-open))

      ;; ICAgICAgOzsgKGNvbmQKICAgICAgOzsgICgoZXF1YWwgdCAgICAgZXJhc2UtbWVzc2FnZXMtb24pCiAgICAgIDs7ICAgKGVyYXNlLWMtbWVzc2FnZXMpKQogICAgICA7OyAgKChlcXVhbCA6ZWFjaCBlcmFzZS1tZXNzYWdlcy1vbikKICAgICAgOzsgICAoZXJhc2UtYy1tZXNzYWdlcykpKQ==

      (condition-case error
          (progn
            (setq subexp-dbg-strings
                  (seq-map-indexed #'(lambda (subexp idx)

                                       ;; ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOzsgKHdoZW4gKGFuZCAoZXF1YWwgdCBlcmFzZS1tZXNzYWdlcy1vbikKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOzsgICAgICAgICAgICAoZXEgaWR4IDApKQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA7OyAgIChlcmFzZS1jLW1lc3NhZ2VzKSkKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOzsgKHdoZW4gKGVxdWFsIDplYWNoIGVyYXNlLW1lc3NhZ2VzLW9uKQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA7OyAgIChlcmFzZS1jLW1lc3NhZ2VzKSk=

                                       (debug-regexp-subexpressions/seq-map-indexed-function subexp idx)) subexp-range-seq))
            (setq result-string
                  (format "\n%s\n\n" (string-join subexp-dbg-strings "\n")))))
      (c-message "(match-string 0): %s" (match-string 0))
      (c-message "result-string: %s" result-string)
      (match-string 0)
      )
    )
  )


(defalias '~dbg-regex #'debug-regexp-subexpressions)
(defalias '~dbg-regexp #'debug-regexp-subexpressions)
(defalias 'dbg-regex #'debug-regexp-subexpressions)
(defalias 'dbg-regexp #'debug-regexp-subexpressions)
(defalias 'regex! #'debug-regexp-subexpressions)
