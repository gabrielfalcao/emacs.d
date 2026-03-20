(defun buffer-variables-plist (&optional buffer)
  (let* ((variables (buffer-local-variables buffer))
         (varcount (length variables))
         (variables-plist
          (seq-map-indexed
           (lambda (item index)
             (let* ((key (car item))
                    (value (cdr item))
                    (key-ty (cl-type-of key))
                    (value-ty (cl-type-of value))
                    (props
                     (list
                      :key-ty key-ty
                      :key key
                      :index index
                      :value value
                      :value-ty value-ty)))
               props)
             )
           variables))
         (lines
          (seq-map-indexed
           (lambda (item idx)
             (format "%s%d (%s): %S" ( idx (cl-type-of item) item))
             variables-plist))
          (output (string-join  lines "\n"))
          (props-result (list))
          )     ; end (lines ...)
         )


    (erase-c-messages)
    (c-message-open "")
    (c-message "buffer-local-variables (%d):\n\n%s\n" varcount output))
  )

(with-current-buffer (seq-random-elt (buffer-list))
  (buffer-variables-plist))
