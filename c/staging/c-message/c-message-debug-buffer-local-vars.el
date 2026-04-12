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
    (unless (c-message-visible-p)
      (c-message-open)
      (erase-c-messages))

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

                    (dbg-hdr-fmt "<%sbuffer %S var %d of %d>")
                    (dbg-tag-open (format dbg-hdr-fmt "" buf-name current total))
                    (dbg-tag-close (format dbg-hdr-fmt "/" buf-name current total))

                    (dbg-msg (string-join (append (list dbg-tag-open) (mapcar (lambda (item) (format "\t%s" item))
                                                                              (list
                                                                               (format "head (%s): %S" (cl-type-of head) head)
                                                                               (format "tail (%s): %S" (cl-type-of tail) tail)

                                                                               (format "key (%s): %S" (cl-type-of key) key)
                                                                               (format "value (%s): %S" (cl-type-of value) value)
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
