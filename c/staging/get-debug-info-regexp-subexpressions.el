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
