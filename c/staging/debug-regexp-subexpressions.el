(defun get-debug-info-regexp-subexpressions ()
  "this function extracts useful debug information from `match-data',
returns plist whose keys are `keyword' objects and values are either
global match-data info such as the count of subespressions found in the
current match-data, or per-match information such as the boundaries of
each match.

"
  (let* (
         (md (match-data))
         (md-len (length md))
         (total-pairs (/ md-len 2))
         (total-subexps (- total-pairs 1))
         (subexp-seq (number-sequence 0 total-subexps))
         (subexps (seq-map-indexed
                   (lambda (num index)
                     (let* (
                            (beginning (match-beginning num))
                            (end       (match-end num))
                            (string    (match-string num))
                            )
                       (list
                        :index      index
                        :num        num
                        :beginning (match-beginning num)
                        :end       (match-end num)
                        :string    (match-string num)
                        ))
                     )
                   subexp-seq))
         ) ; end (let* (...varlist...))
    (list :subexps subexps
          :pairs total-pairs
          :total-subexps total-subexps
          :match-data md
          :match-data-info  ;; end (let* ...)
          )
    ) ;; end (defun get-debug-info-regexp-subexpressions ...)
  )


(defun debug-regexp-subexpressions (&optional collapse-linebreaks)
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
                        (if collapse-linebreaks ;; if `cond' argument #0
                            (save-match-data
                              (replace-regexp-in-string
                               "\\(\\s-*\\)\\(\r\n\\|\n\\)+\\(\\s-*\\)" "\\1\\3" value)) ;; if `then' argument #1
                          value  ;; if `else' argument #2
                          )
                        value-suffix
                        subexp-end)))
                  ;; (message "items %S" items)
                  ;; (c-message-open "items %S" items)
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

;; 2026/03/20 07:16:33 (1773990993)
