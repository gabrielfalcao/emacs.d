(let* ( (item \1) (len (- length item) 1) (padding (string-join (make-list len " "))) ) (format "'%s" padding))
