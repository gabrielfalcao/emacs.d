(let* (
       (subexpr-count (- (/ (length (match-data)) 2) 1))
       (subexpr-numbers (number-sequence 0 subexpr-count))
       (subexpr-numbers-nonzero (cdr-safe subexpr-numbers))
       (whole-match  (match-string 0))
       )
  (format ";;%s ;; %s"
          (match-string 0)
          (string-join
           (mapcar (lambda (subexpr)
                  (format "<%d>%s</%d>" subexpr (match-string subexpr) subexpr))
              )
   ))
))
