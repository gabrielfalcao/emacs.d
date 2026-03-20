;; (defun debug-face-attribute (attribute)
;;   (lambda (item)
;;     (let* (
;;            (key (car item))
;;            (value (cadr item))
;;            (key-ty (cl-type-of key))
;;            (value-ty (cl-type-of value))
;;            )
;;       (format "    key (%s) %S: value (%s): %S\n"
;;               key-ty key
;;               value-ty value)
;;       )
;;     ) ;end lambda
;;   )

(defun debug-face-attribute (attr)
  (let* ((elisp-ty (type-of attr))
         (cl-ty (cl-type-of attr))
         (ty
          (or
           (and (eq elisp-ty cl-ty) (format "%s" cl-ty))
           (format "%s (%s)" elisp-ty cl-ty))))
    (format "attribute %S is a %s" attr ty)) ;end lambda
  )

(defun debug-font-face (&optional face frame)
  (let* ((face (or face 'default))
         (attributes (face-all-attributes face))
         (item nil)
         (result-string-list
          (mapcar #'debug-face-attribute
                  (face-all-attributes 'default)))
         (result ""))
    (let* ((tag-open (format "<debug-font-face face=\x22%s\x22>" face))
           (tag-close (format "</debug-font-face face=\x22%s\x22>" face))
           (tag-content (string-join result-string-list "\n")))
      (setq result
            (string-join (list tag-open tag-content tag-close) "\n")))
    ))
