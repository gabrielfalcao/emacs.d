(defun c-message-debug-buffer-local-vars (buffer-or-name)
  (let* (;
         (buf (get-buffer buffer-or-name))
         (buf-name
          (when buf (with-current-buffer buf (buffer-name buf))))
         (vars
          (when buf
            (with-current-buffer buf (buffer-local-variables buf))))
         (total (length vars))
         (result nil))

    (c-message-ensure-visible)

    (setq result
          (seq-map-indexed
           (lambda (item index)
             (let* (
                    ;;
                    (current (+ index 1))

                    (head (or (and (or (listp item) (consp item)) (car item)) (format "%s (%s) %S" "item" (cl-type-of item) item)))
                    (tail (or (and (or (listp item) (consp item)) (cdr item)) (format "%s (%s) %S" "item" (cl-type-of item) item)))

                    (key   (or (and (symbolp head) (symbol-name head)) (format "%s (%s) %S" "head" (cl-type-of head) head)))
                    (value (or (and (or (listp tail) (consp tail)) (car tail)) (format "%s (%s) %S" "tail" (cl-type-of tail) tail)))

                    (dbg-hdr-attrs (string-join (mapcar (lambda (item) (format "%s" item))
                                                        (list
                                                         ;; (format "head-type=\"%S\"" (cl-type-of head) )
                                                         ;; (format "tail-type=\"%S\"" (cl-type-of tail) )

                                                         (format "key-type=\"%S\"" (cl-type-of key) )
                                                         (format "value-type=\"%S\"" (cl-type-of value) )
                                                         )
                                                        )
                                                " "))
                    (dbg-hdr-fmt (format "<%%sbuffer %%S var={%%d} of={%%d} %s>" dbg-hdr-attrs))
                    (dbg-tag-open (format dbg-hdr-fmt "" buf-name current total))
                    (dbg-tag-close (format dbg-hdr-fmt "/" buf-name current total))

                    (dbg-msg (string-join (append (list dbg-tag-open)
                                                  (mapcar (lambda (item) (format "\t%s" item))
                                                          (list
                                                           (format "<key>\n%S\n</key>" key)
                                                           (format "<value type=\"%s\">\n%S\n</value>" (cl-type-of value) value)
                                                           )
                                                          )
                                                  (list dbg-tag-close))
                                          "\n"))
                    ;;
                    )
               (c-message "%s" dbg-msg)
               (list :item item
                     :index index
                     :head head
                     :tail tail
                     :key key
                     :value value)))
	   vars)
          ;;
          )
    ;;
    )
  )
