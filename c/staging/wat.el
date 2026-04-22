(let* (
       (items (list))
       (index 0)
       (count 10)
       (extra (list)))
  (while (<= index count)
    (pcase (% index 7)
      ((pred (= _ 0))
        (push mod items))

      (wat (progn (push wat extra)
            (message "wat: %s" wat))))
    (setq index (1+ index)))
  (condition-case err
    (progn
      (erase-c-messages)
      (c-message-open "")
      (c-message "<context>\n\n%s\n\n</context>"
        (string-join
          (mapcar (lambda (sym) (format "%s: %S"
                                 (symbol-name sym)
                                 (symbol-value sym)))
            (list 'index 'count 'items 'extra))
          "\n")))
    (error (display-warning 'emacs (format "caught error: %S:" err) :emergency))))
