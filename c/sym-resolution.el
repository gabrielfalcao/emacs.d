(defun resolution-predicate-for-symbol-by-name (sym)
  "Returns a predicate which resolves symbol `SYM' as long as the type of
`SYM' is either `string' or `symbol'.

Otherwise, returns a predicate function which always signals an error,
this predicate function is scope-bound to `SYM' and adds extra error
information if called with any argument other than the exact object as
`SYM'.

NOTE: this function is meant to be used only within the implementation
of `resolve-symbol-by-name'.
"
  (let* (
         (sym-ty (type-of sym))
         (ty-err-message
          (format "%s in `resolve-symbol-by-name': argument `SYM' has unexpected type `%s'"
                  (error-message-string err)))
       ;;   ) ;;end let varlist
       ;; (message "%s" error-message)
       ;; error-message) ;; end let
         )
    (defun unexpected-typep (arg)
      (let ((extra-error nil))
        (unless (eq sym arg)
          (let ((message (format "predicate expected `ARG' of type `%s' but received type `%s' expected type of `SYM' `%S' is `%s' `SYM': %S"
                                 sym-ty sym
                        sym))

          (setq extra-error
                (cons
                 'inconsistent-scope-error
                 (list
                  ))
      (signal 'error
              (format "unexpected type `%s' of `SYM': %S"
                      (type-of sym)
                      sym))))



  (condition-case err
      (cond
       ((stringp sym) #'intern-soft)
       ((symbolp sym) #'symbol-value)
       ((null sym) #'(lambda (arg)
                       (unless (eq sym arg)
                         (signal 'error
                                 (format "unexpected type `%s' of `SYM': %S"
                                         (type-of sym)
                                         sym))))


                       nil))

       (t #'(lambda (arg)

        (signal 'error
                (format "unexpected type `%s' of `SYM': %S"
                        (type-of sym)
                        sym))))
    (error
     (let ((error-message
            (format "error in `resolve-symbol-by-name': %s"
                    (error-message-string err)))) ;;end let varlist
       (message "%s" error-message)
       error-message) ;; end let
     )) ;; end condition-case
  )



(defun resolve-symbol-by-name (sym)
  "returns the value of symbol `SYM'. accepts `stringp' or `symbolp'"
  (unless (or (null sym) (stringp sym) (symbolp sym))
    (signal 'type-error
            (format "resolve-symbol-by-name argument sym should be string or symbol, got %s %S"
                    (type-of sym)
                    sym)))

  (condition-case err
      (cond
       ((stringp sym) (intern-soft sym))
       ((symbolp sym) (symbol-value sym))
       ((null sym) nil)
       (t
        (signal 'error
                (format "unexpected type `%s' of `SYM': %S"
                        (type-of sym)
                        sym))))
    (error
     (let ((error-message
            (format "error in `resolve-symbol-by-name': %s"
                    (error-message-string err)))) ;;end let varlist
       (message "%s" error-message)
       error-message) ;; end let
     )) ;; end condition-case
  )
