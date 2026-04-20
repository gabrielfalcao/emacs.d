;; ^\(\s-*\)\(declare\(\s-+\)\([-][a-z-]+\)\(\s-+\)\([a-z_][a-z0-9_]*\)=\(.*[^;\n]*\)\)[;]?$\n

(let* ((data (match-data)
             )
       (
        data-len (length data)
        )
       (
        pair-count (/ data-len 2)
        )
       (
        subexpr-count (- pair-count 1)
        ))
  (
   format "\n%s\n" (string-join (mapcar (lambda (num) (string-join (list (or (and (> num 0) "    ") "") ) "")
                                          )
                                        (
                                         number-sequence subexpr-count) ) "\n" )) )


