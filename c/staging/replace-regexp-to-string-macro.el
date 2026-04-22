(defmacro regexp-context-subexps(&optional match-string-properties &rest body)
  (let* (
         (sym-match-data-list (make-symbol))
         (sym-match-data-len (make-symbol))
         (sym-match-data-pairs (make-symbol))
         (sym-subexp-count (make-symbol))
         (sym-subexp-plist (make-symbol))
         (get-subexp-fn #'match-string-no-properties))
    (when match-string-no-properties
      (setq get-subexp-fn #'match-string))

    `(save-match-data
      (let* (
             (md (match-data))
             (md-len (length md))
             (md-pairs (/ md-len 2))
             (subexp-count (- md-pairs 1))
             (subexps (mapcar
                       (lambda (subexp) (list subexp (match-string-no-properties subexp)))
                       (number-sequence 0 subexp-count)))
             (fmt (match-string-no-properties 2))
             (full-desc (match-string-no-properties 4))
             (short-desc (match-string-no-properties 6))
             (label (substring-no-properties short-desc))
             (label (save-match-data (replace-regexp-in-string "file\\s-*system" "fs" label)))
             (label (save-match-data (replace-regexp-in-string "\\s-+" "_" label))))
       ;; <body>
       ,@body
       ;; </body>
       ))))
