(defun debug-face-attribute (item)
    (let* (
           (key (car item))
           (value (cdr item))
           (key-ty (cl-type-of key))
           (value-ty (cl-type-of value))
           )
      (format "    key (%s) %S: value (%s): %S\n"
              key-ty key
              value-ty value)
      )
  )

;; (defun format-face-attribute (attr)
;;   "."
;;   (declare (not-side-effect-free t))
;;   (let* ((elisp-ty (type-of attr))
;;          (cl-ty (cl-type-of attr))
;;          (ty
;;           (or
;;            (and (eq elisp-ty cl-ty) (format "%s" cl-ty))
;;            (format "%s (%s)" elisp-ty cl-ty))))
;;     (format "attribute %S is a %S" attr ty)
;;     )
;;   )
;;
;; (defun debug-face-attribute (attr)
;;   "."
;;   (declare (not-side-effect-free t))
;;
;;   (let* ((value (format-face-attribute attr)))
;;     (c-message "%s" value)
;;     value
;;     ))

(defun debug-font-face (&optional face frame)
  (let* ((face (or face 'default))
         (all-attributes (face-all-attributes face))
         (item nil)
         (result-string-list
          (mapcar 'debug-face-attribute all-attributes))
         (result ""))
    (erase-c-messages)
    (c-message-open)
    (let* (
           (tag-open (format "<debug-font-face face=\x22%s\x22>\n" face))
           (tag-close (format "\n</debug-font-face face=\x22%s\x22>" face))
           (tag-content (string-join
                         (mapcar (lambda (item) (format "    %s" item))
                                 result-string-list)
                                     "\n"))
           )
      (setq result
            (string-join (list tag-open tag-content tag-close) "\n")))
    (c-message-open)
    (erase-c-messages)
    (c-message "%s\n" result)
    )
  )


(debug-font-face 'default)
