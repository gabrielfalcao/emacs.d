(defun rsync-backup-params-replace-regexp-to-string()
  (let* (
         (arg-indent       (or (match-string 1) ""))
         (arg-comment      (or (match-string 2) ""))
         (arg-option       (or (match-string 3) ""))
         (syms             (list 'arg-indent 'arg-comment 'arg-option))
         (symcount         (length syms))
         )
    (string-join (seq-map-indexed
                  (lambda (sym index)
                    (let* (
                           (current (1+ index))
                           (sym-name   (symbol-name sym))
                           (sym-value  (symbol-value sym))
                           (sym-el-ty  (type-of sym-value))
                           (sym-cl-ty  (cl-type-of sym-value))
                           (value-str  (format "%s" sym-value))
                           (value-qut  (format "%S" value-str))
                           (meta-syms  (list 'sym
                                             'index
                                             'current
                                             'sym-name
                                             'sym-value
                                             'sym-el-ty
                                             'sym-cl-ty
                                             'value-str
                                             'value-qut
                                             'symcount))
                           ) ;end (let* (...varlist...))
                                        ;beg (let* ...body...)
                      (string-join (mapcar (lambda (subsym)
                                             (let* (
                                                    (subname (symbol-name subsym))
                                                    (subvalue (symbol-value subsym))
                                                    (subty    (cl-type-of subvalue))
                                                    )
                                               (format "%S (%s): %S" subname subty subvalue)
                                               )
                                             )
                                           meta-syms)
                                   "\n")

					;end (let* ...body...)
                      ) ;end (let* ...)
                    ) ;end (lambda ...)
                  syms)
                 "\n")
    )
  )

;;
;;
;;(list arg-indent)
;;(list arg-comment)
;;(list (replace-rege "\x22%s\x22" arg-option)) ""))
;;
