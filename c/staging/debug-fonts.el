;;;
;;;(defun debug-tag (tag-name &optional attrs-plist &rest children)
;;;  (unless (plistp attrs-plist)
;;;    (signal 'type-error
;;;            (format  "`debug-tag' argument `attrs-plist' must be either nil or a valid property list, received `%s': %s"
;;;                     (cl-type-of attrs-plist)
;;;                     attrs-plist)))
;;;
;;;  (let* (
;;;         (tag-attrs (seq-reduce (lambda (acc elt)
;;;
;;;         (tag-open (format "<%s
;;;

(defun debug-all-attributes (&optional face)
  (let* (
         (face (or face 'default))
         (raw-all-attributes (face-all-attributes face))
         (total-attributes (length raw-all-attributes))
         (plist-key-indexes (number-sequence 0 (/ total-attributes 2)))
         (key-value-attributes (list))
         (kv-index 0)
         ;; (all-attributes (seq-map-indexed (lambda (value index)
         ;;                                    (list :value value
         ;;                                          :index index))
         ;;                                  raw-all-attributes))
         )
    (while (length> raw-all-attributes 0)
    (string-join
     (list (format "<all-attributes %s>" (string-join (list (format "%s=\x22%S\x22"
   (format "    <all-attributes type=\x22%S\x22 length=\x22%d\x22>%s</all-attributes>\n"
           (cl-type-of all-attributes)
           (length all-attributes)
           all-attributes))

       )
(defun debug-face-attribute (item)
    (let* (
           (key (car item))
           (value (cdr item))
           (value-ty (type-of value))
           ;; (value-ty (cl-type-of value))
           )
      (format "    %S => %S (%s)\n"
              key
              value
              value-ty)
      ;; (format "    %S: %S\n"
      ;;         key
      ;;         value
      ;;         )
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
         (all-attributes-cons (face-all-attributes face))
         ;; (all-attributes (cdr all-attributes-cons))
         ;; (all-attributes (list (car all-attributes-cons) (cdr all-attributes-cons)))
         (all-attributes (seq-map-indexed (lambda (value index)
                                            (list :value value
                                                  :index index))
                                          all-attributes-cons))

         ;; (all-attributes (car all-attributes-cons))

         (item nil)
         (result-string-list
          (mapcar 'debug-face-attribute (face-all-attributes face)))
         (result ""))

    (let* (
           (tag-open (format "<debug-font-face face=\x22%s\x22>\n" face))
           (tag-close (format "\n</debug-font-face face=\x22%s\x22>" face))
           (tag-content (string-join
                         (append
                          (list)
                          (mapcar (lambda (item) (format "    %s" item))
                                  result-string-list)
                          )
                          "\n"))
           )
      (setq result
            (string-join (list tag-open tag-content tag-close) "\n")))
    (c-message-open)
    (erase-c-messages)
    (c-message "%s\n" result)
    )
  )

(erase-c-messages)
(debug-font-face 'default)
