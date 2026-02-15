(defun symbol-metadata (sym)
  (let* (
         (name        (symbol-name sym))
	 (ty          (type-of sym))
	 ;; (value       (symbol-value sym))
	 ;; (value-ty    (type-of value))
	 (props       (condition-case err (append (cons :error nil) (symbol-plist sym)) (error (list :error err))))
         )
    (c-message-debug-symbols (list 'sym 'name 'ty 'props))
    (list
     :name       name
     :ty       ty
     ;; :value       value
     ;; :value-ty       value-ty
     :props       props
     )))

(defun debug-atoms (&optional objects-array)
    (c-message-open "debug-atoms")
  (mapatoms (lambda (sym)
              (symbol-metadata sym)
              )
            objects-array
            )
  )

;;(defun debug-match-data ()
;;  (mapatoms (lambda (symbol)
;;              (list
;;               (name        (symbol-name sym))
;;	       (ty          (type-of sym))
;;	       (value       (symbol-value sym))
;;	       (value-ty    (type-of value))
;;	       (props       (condition-case err (append (cons :error nil) (symbol-plist sym)) (error (list :error err))))
;;               )
;;              )
;;            )
;;  )
;;
;;
;;
;;
;;
;;  (save-match-data
;;    (let* (
;;           (data          (match-data t))
;;           (data-len      (length data))
;;           (pair-len      (/ (length data) 2))
;;           (subexpr-count (- pair-len 1))
;;           (data-props    (condition-case err
;;                              (append (cons :error nil) (symbol-plist data))
;;                            (error
;;                             (list :error err))))
;;           )
;;      (let ((local-let-vars '(
;;                              data
;;                              data-len
;;                              pair-len
;;                              subexpr-count
;;                              data-props)))
;;        (seq-map-indexed (lambda (sym index)
;;			   (unless (symbolp sym)
;;			     (signal 'type-error
;;				     (format  "[debug-match-data internal error] `local-let-vars' element %s is not a symbol: %s "
;;					      index
;;					      (type-of sym)
;;
;;					      )))
;;
;;			   (let* (
;;				  (name        (symbol-name sym))
;;				  (ty          (type-of sym))
;;				  (value       (symbol-value sym))
;;				  (value-ty    (type-of value))
;;				  (props       (condition-case err
;;					           (append (cons :error nil) (symbol-plist sym))
;;					         (error
;;					          (list :error err))))
;;				  )
;;			     (string-join
;;                              (list
;;                               name
;;                               (format "[%s]"
;;                                     ty)
;;                               (format "%s"
;;                                       value))
;;                              " ")
;;                             )
;;                           )
;;			 local-let-vars)
;;        )
;;      )
;;    )
;;  )
;;
