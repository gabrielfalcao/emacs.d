(defun string-pad-left (len string &optional pad-char)
  (pcase pad-char
    ((and (pred stringp) (pred (length= _ 1))) (substring-no-properties pad-char))
    ((and (pred stringp) (pred (length= _ 0))) (signal 'argument-error (format  "argument `pad-char' must be a string of length 1 but %S has " pad-char (length pad-char))))
    ((and (pred stringp) (pred (length> _ 1))) (signal 'argument-error (format  "argument `pad-char' must be a string of length 1 but %S has is %d characters long" pad-char (length pad-char))))

    (pred stringp) (and (length= 1) pad-char
                        (format (format "%c%s%dd" 37 "0" (length (number-to-string 100))) 1)
