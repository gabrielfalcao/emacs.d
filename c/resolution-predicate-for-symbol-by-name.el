(defmacro try-or-nil (s-exprs)
  `(condition-case err
    (cons ,s-exprs nil)
    (error
     (let (message (format
                    "%s trying to execute expression %S"
                    (error-message-string err)
                    s-exprs))
      (cons nil message)))))
(let* (
       (sym 'error)
       ;; (name (symbol-name sym))
       ;; (value (symbol-value sym))
       (props (symbol-plist sym))
       (func (symbol-function sym))
       (is-function (not (null func))))
  (erase-c-messages)
  (c-message-open "debugging symbol `%s'" sym)
  (c-message-debug-symbols (list 'sym
                            ;; 'name
                            ;; 'value
                            'props
                            'func)
    'sym))
